Unit uField;

Interface

Uses
    VCL.Graphics;

Type
    TCell = class
        Private
            Width: Integer;
            Top: Integer;
            Color: TColor;
            Left: Integer;
            IsClicked: Boolean;
            IsGuessed: Boolean;
        Public
            Constructor Create();
            Destructor Destroy; Override;
            Procedure SetSize(W, H: Integer);
            Procedure SetPosition(T, L: Integer);
        End;

    TCellsArr = Array of Array of TCell;

    TMatrix = class
    Private
        Size: Integer;
        Cells: TCellsArr;
    Public
        Constructor Create(N: Integer);
        Destructor Destroy; Override;
        Function GetSize(): Integer;
        Procedure SetSize(N: Integer);
        Function GetColor(I, J: Integer): TColor;
        Procedure SetColor(I, J: Integer; NewClr: TColor);
        Procedure GetPosition(I, J: Integer; Var L, T, W: Integer);
        Procedure DrawRect(I, J: Integer; Canvas: TCanvas);
    End;



Implementation

Uses
    uPlayground;

Constructor TCell.Create();
Begin
    Width := 0;
    IsClicked := False;
    IsGuessed := False;
End;

Destructor TCell.Destroy;
Begin
    Inherited;
End;

Procedure TCell.SetSize(W: Integer; H: Integer);
Begin
    Self.Width := W;
End;

Procedure TCell.SetPosition(T: Integer; L: Integer);
Begin
    Self.Top := T;
    Self.Left := L;
End;

Constructor TMatrix.Create(N: Integer);
Const
    WIDTH = 25;
    MARGIN = 3;
Var
    I, J, CurrTop, CurrLeft: Integer;
Begin
    SetSize(N);
    SetLength(Cells, Size, Size);
    For I := 0 to (Size - 1) do
    Begin
        For J := 0 to (Size - 1) do
        Begin
            Cells[I, J] := TCell.Create;
        End;
    End;

    CurrTop := WIDTH;
    For I := 0 to (Size - 1) do
    Begin
        CurrLeft := WIDTH;
        For J := 0 to (Size - 1) do
        Begin
            Cells[I, J].Create;
            Cells[I, J].Color := clRed;
            Cells[I, J].Width := WIDTH;
            If (I = 0) and (J = 0) then
            Begin
                Cells[I, J].Top := WIDTH;
                Cells[I, J].Left := WIDTH;
            End
            Else
            Begin
                Cells[I, J].Top := CurrTop;
                Cells[I, J].Left := CurrLeft;
            End;
            CurrLeft := CurrLeft + WIDTH + MARGIN;
        End;
        CurrTop := CurrTop + WIDTH + MARGIN;
    End;
End;

Destructor TMatrix.Destroy;
Var
    I, J: Integer;
Begin
    For I := 0 to (Size - 1) do
    Begin
        For J := 0 to (Size - 1) do
        Begin
            Cells[I, J].Destroy;
        End;
    End;
    Cells := Nil;
    Inherited;
End;

Function TMatrix.GetSize: Integer;
Begin
    Result := Size;
End;

Procedure TMatrix.SetSize(N: Integer);
Begin
    Size := N;
End;

Function TMatrix.GetColor(I, J: Integer): TColor;
Begin
    Result := Cells[I, J].Color;
End;

Procedure TMatrix.GetPosition(I, J: Integer; Var L: Integer; Var T: Integer; Var W: Integer);
Begin
    L := Cells[I, J].Left;
    T := Cells[I, J].Top;
    W := Cells[I, J].Width;
End;

Procedure TMatrix.SetColor(I: Integer; J: Integer; NewClr: TColor);
Begin
    Cells[I, J].Color := NewClr;
End;

Procedure TMatrix.DrawRect(I, J: Integer; Canvas: TCanvas);
Begin
    Canvas.Brush.Color := Cells[I, J].Color;;
    Canvas.Rectangle(Cells[I, J].Left, Cells[I, J].Top,
                                   Cells[I, J].Left + Cells[I, J].Width,
                                   Cells[I, J].Top + Cells[I, J].Width);
End;


End.
