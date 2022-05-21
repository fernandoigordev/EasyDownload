unit Data.Database.DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TDataModule1 = class(TDataModule)
    FDConnection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure HandleExceptions(Sender: TObject; E: Exception);
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

uses
  Vcl.Forms, Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
  DataBasePath: String;
begin
  Application.OnException := HandleExceptions;
  DataBasePath := Concat(ExtractFilePath(Application.ExeName), 'database.sqlite');
  if not FileExists(DataBasePath) then
  begin
    MessageDlg('Arquivo de banco de dados não localizado, a aplicação será encerrada', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK], 0);
    Application.Terminate;
  end;

  FDConnection.Params.Database := DataBasePath;
  FDConnection.Connected := True;
end;

procedure TDataModule1.HandleExceptions(Sender: TObject; E: Exception);
begin
  MessageDlg(Concat('Ocorreu algo de errado na aplicação, por favor contate o suporte e informe o seguinte erro: ', E.Message), TMsgDlgType.mtError, [mbOK], 0);
end;

end.
