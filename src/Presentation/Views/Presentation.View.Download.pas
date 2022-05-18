unit Presentation.View.Download;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCGrids, Vcl.ExtCtrls, dxGDIPlusClasses, Vcl.StdCtrls, AdvGlowButton,
  Vcl.ComCtrls;

type
  TfrmViewDownload = class(TForm)
    pnlContainer: TPanel;
    pnlFormDownload: TPanel;
    pnlTitleImage: TPanel;
    pnlTitle: TPanel;
    pnlTitleButton: TPanel;
    imgBack: TImage;
    Label1: TLabel;
    imgLogoDownload: TImage;
    pnlDownloading: TPanel;
    edtUrlDownload: TEdit;
    lblUrlDownload: TLabel;
    btnStartDownload: TAdvGlowButton;
    pnlDownloadingInfo: TPanel;
    pnlDownloadingDetails: TPanel;
    imgDownloading: TImage;
    Image1: TImage;
    pnlDownloadingContent: TPanel;
    lblDownloadingUrl: TLabel;
    ProgressBar1: TProgressBar;
    lblMoreDetails: TLabel;
    lblDownloadName: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure lblMoreDetailsClick(Sender: TObject);
    procedure btnStartDownloadClick(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewDownload: TfrmViewDownload;

implementation
uses Presentation.Routes;

{$R *.dfm}

procedure TfrmViewDownload.btnStartDownloadClick(Sender: TObject);
begin
  pnlFormDownload.Visible := False;
  pnlDownloading.Visible  := True;
end;

procedure TfrmViewDownload.imgBackClick(Sender: TObject);
begin
  Routes.SetElement(rViewMenu);
end;

procedure TfrmViewDownload.lblMoreDetailsClick(Sender: TObject);
begin
  pnlDownloadingDetails.Visible := not pnlDownloadingDetails.Visible;
  if pnlDownloadingDetails.Visible then
    lblMoreDetails.Caption := 'Ocultar detalhes'
  else
    lblMoreDetails.Caption := 'Mostrar detalhes'

end;

end.
