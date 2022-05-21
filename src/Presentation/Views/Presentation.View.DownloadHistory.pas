unit Presentation.View.DownloadHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCGrids, System.ImageList,
  Vcl.ImgList, Data.DB, Datasnap.DBClient, Presentation.Controller.Download.History,
  Data.Repository.Download.Interfaces, Data.Repository.Download.SqLite, Vcl.DBCtrls;

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
    cdsDownloadHistory: TClientDataSet;
    dsDownloadHistory: TDataSource;
    cdsDownloadHistoryURL: TStringField;
    cdsDownloadHistoryDateDetails: TStringField;
    cdsDownloadHistoryIconIndex: TIntegerField;
    mmUrl: TDBMemo;
    mmDateDetails: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdDownloadHistoryPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
  private
    { Private declarations }
    FControllerDownloadHistory: TControllerDownloadHistory;
    FRepositoryDownload: IRepositoryDownload;
    procedure SetValues;
  public
    { Public declarations }
  end;

var
  frmViewDownloadHistory: TfrmViewDownloadHistory;

implementation
uses Presentation.Routes, Data.Database.DataModule;

{$R *.dfm}

procedure TfrmViewDownloadHistory.FormCreate(Sender: TObject);
begin
  {Se tiver download em andamento mostra o progresso}
  FRepositoryDownload := TRepositoryDownloadSqLite.Create(DataModule1.FDConnection);
  FControllerDownloadHistory := TControllerDownloadHistory.Create(FRepositoryDownload);
end;

procedure TfrmViewDownloadHistory.FormDestroy(Sender: TObject);
begin
  FControllerDownloadHistory.Free;
end;

procedure TfrmViewDownloadHistory.FormShow(Sender: TObject);
begin
 FControllerDownloadHistory.Handle(cdsDownloadHistory);
end;

procedure TfrmViewDownloadHistory.grdDownloadHistoryPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
begin
  SetValues;
end;

procedure TfrmViewDownloadHistory.imgBackClick(Sender: TObject);
begin
  Close;
  Routes.SetElement(rViewMenu);
end;

procedure TfrmViewDownloadHistory.SetValues;
begin
  if cdsDownloadHistory.RecordCount > 0 then
  begin
    imgFile.Visible := True;
    imgButton.Visible := True;
    imgListButton.GetBitmap(cdsDownloadHistoryIconIndex.AsInteger, imgButton.Picture.Bitmap);
  end
  else
  begin
    imgFile.Visible := False;
    imgButton.Visible := False;
  end;
end;

end.
