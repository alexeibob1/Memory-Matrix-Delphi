Unit uPlayground;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uField, Vcl.ExtCtrls;

Type
    TfrmPlayground = class(TForm)
    pbArea: TPaintBox;
        Procedure FormCreate(Sender: TObject);
        Procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
                                Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);

    Private
        { Private declarations }
        Field: TMatrix;
    Public
        { Public declarations }
        Procedure DrawPlayground();
    End;

//Var
 //   frmPlayground: TfrmPlayground;

Implementation

{$R *.dfm}

Procedure TfrmPlayground.FormCreate(Sender: TObject);
Begin
    Field := TMatrix.Create(4);
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) OR
                  WS_EX_APPWINDOW);

End;

Procedure TfrmPlayground.FormMouseDown(Sender: TObject; Button: TMouseButton;
                                       Shift: TShiftState; X, Y: Integer);
Var
    I, J, N: Integer;
    Left, Top, Width: Integer;
Begin

    N := Field.GetSize();

    If (Field <> Nil) then
    Begin
        For I := 0 to (N - 1) do
        Begin
            For J := 0 to (N - 1) do
            Begin
                Field.GetPosition(I, J, Left, Top, Width);
                If (X >= Left) and (X <= Left + Width)
                               and (Y >= Top) and (Y <= Top + Width) then
                Begin
                    Field.SetColor(I, J, clGreen);
                    Field.DrawRect(I, J, pbArea.Canvas);
                End;

            End;
        End;
    End;
End;


Procedure TfrmPlayground.FormPaint(Sender: TObject);
Begin
    DrawPlayground();
End;

Procedure TfrmPlayground.DrawPlayground();
Var
    I, J: Integer;
    N: Integer;
    Left, Top, Width: Integer;
Begin
    N := Field.GetSize;
    For I := 0 to (N - 1) do
    Begin
        For J := 0 to (N - 1) do
        Begin
            Field.GetPosition(I, J, Left, Top, Width);
            pbArea.Canvas.Brush.Color := Field.GetColor(I, J);
            pbArea.Canvas.Rectangle(Top, Left, Top + Width, Left + Width);
        End;
    End;
End;

End.
