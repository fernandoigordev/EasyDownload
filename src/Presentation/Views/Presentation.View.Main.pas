unit Presentation.View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Presentation.View.Menu, Presentation.Routes;

type
  TfrmViewMain = class(TForm)
    pnlContainer: TPanel;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ViewMenu: TfrmViewMenu;
  public
    { Public declarations }
  end;

var
  frmViewMain: TfrmViewMain;

implementation

{$R *.dfm}

procedure TfrmViewMain.FormCreate(Sender: TObject);
begin
  Routes := TRoutes.Create(pnlContainer);
end;

procedure TfrmViewMain.FormDestroy(Sender: TObject);
begin
  Routes.Free;
end;

procedure TfrmViewMain.FormResize(Sender: TObject);
begin
  Routes.SetElement(rViewMenu);
end;

end.
