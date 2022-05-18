unit Presentation.View.DownloadHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCGrids, System.ImageList,
  Vcl.ImgList, Data.DB, Datasnap.DBClient;

type
  TfrmViewDownloadHistory = class(TForm)
    pnlTitle: TPanel;
    Label1: TLabel;
    pnlTitleButton: TPanel;
    imgBack: TImage;
    pnlTitleImage: TPanel;
    imgLogoHistory: TImage;
    pnlContainer: TPanel;
    grdDownloadHistory: TDBCtrlGrid;
    imgFile: TImage;
    imgButton: TImage;
    imgListButton: TImageList;
    pnlContentHistory: TPanel;
    lblUrl: TLabel;
    lblDataInformation: TLabel;
    cdsDownloadHistory: TClientDataSet;
    dsDownloadHistory: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewDownloadHistory: TfrmViewDownloadHistory;

implementation
uses Presentation.Routes;

{$R *.dfm}

procedure TfrmViewDownloadHistory.FormCreate(Sender: TObject);
begin
  {Se tiver download em andamento mostra o progresso}
end;

procedure TfrmViewDownloadHistory.imgBackClick(Sender: TObject);
begin
  Routes.SetElement(rViewMenu);
end;

end.
