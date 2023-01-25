Unit uMain;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uPlayground;

Type
    TfrmMain = class(TForm)
        btnStart: TButton;
        tTimer: TTimer;
        Procedure btnStartClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; var Action: TCloseAction);

    Private
        { Private declarations }

    Public
        { Public declarations }
    End;

Var
    frmMain: TfrmMain;

Implementation

{$R *.dfm}


Procedure TfrmMain.btnStartClick(Sender: TObject);
Var
    frmPlayground: TfrmPlayground;
Begin
    frmMain.Hide;
    Try
        frmPlayground := TfrmPlayground.Create(Nil);
        frmPlayground.ShowModal;
    Finally
        frmPlayground.Free;
    End;
    frmMain.Show;
End;

Procedure TfrmMain.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    Application.Terminate;
End;



End.
