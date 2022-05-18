unit Presentation.View.Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, dxGDIPlusClasses, AdvGlowButton;

type
  TfrmViewMenu = class(TForm)
    pnlTitle: TPanel;
    pnlButtons: TPanel;
    pnlImage: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    btnDownload: TAdvGlowButton;
    btnHistory: TAdvGlowButton;
    procedure btnDownloadClick(Sender: TObject);
    procedure btnHistoryClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewMenu: TfrmViewMenu;

implementation
uses Presentation.Routes;

{$R *.dfm}

procedure TfrmViewMenu.btnDownloadClick(Sender: TObject);
begin
  Routes.SetElement(rViewDownload);
end;

procedure TfrmViewMenu.btnHistoryClick(Sender: TObject);
begin
  Routes.SetElement(rViewDownloadHistory);
end;

end.
