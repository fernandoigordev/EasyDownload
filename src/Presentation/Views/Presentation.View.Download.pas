unit Presentation.View.Download;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCGrids, Vcl.ExtCtrls, dxGDIPlusClasses, Vcl.StdCtrls, AdvGlowButton,
  Vcl.ComCtrls, Data.Service.Download.Observer.Interfaces,
  Data.Service.Download.Observer.Subject, Data.Repository.Download.Interfaces, Data.Repository.Download.SqLite, Presentation.Controller.Download.Tasks;

type
  TfrmViewDownload = class(TForm, IServiceObserver)
    pnlContainer: TPanel;
    pnlFormDownload: TPanel;
    pnlTitleImage: TPanel;
    pnlTitle: TPanel;
    pnlTitleButton: TPanel;
    imgBack: TImage;
    lblTitle: TLabel;
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
    ProgressBar1: TProgressBar;
    lblMoreDetails: TLabel;
    lblDownloadName: TLabel;
    lblDownloadPercentage: TLabel;
    lblDownloaded: TLabel;
    SaveDialog1: TSaveDialog;
    mmUrlDownload: TMemo;
    procedure lblMoreDetailsClick(Sender: TObject);
    procedure btnStartDownloadClick(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
    FRepositoryDownload: IRepositoryDownload;
    FServiceDownloadSubject: IServiceDownloadSubject;
    FControllerDownloadTasks: TControllerDownloadTasks;
    procedure ConfigureDownload(ADownloading: Boolean);
  public
    { Public declarations }
    procedure Notify(ANotifyDownloadInformation: TNotifyDownloadInformation);
    function FormatGbToMb(Avalue: Int64): String;
    function FormatToPercentage(AMaxValue, ACurrentValue: Int64): String;
  end;

var
  frmViewDownload: TfrmViewDownload;

implementation
uses Presentation.Routes, Data.Database.DataModule;

{$R *.dfm}

procedure TfrmViewDownload.btnStartDownloadClick(Sender: TObject);

begin
  if edtUrlDownload.Text <> EmptyStr then
  begin
    ConfigureDownload(True);
    FControllerDownloadTasks.StartDownload(edtUrlDownload.Text,
    procedure
    begin
      ConfigureDownload(False);
    end);
  end
  else
  begin
    MessageDlg('Url de Download inválida', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK], 0);
  end;
end;

procedure TfrmViewDownload.ConfigureDownload(ADownloading: Boolean);
begin
  if ADownloading then
  begin
    mmUrlDownload.Text := edtUrlDownload.Text;
    lblDownloadPercentage.Caption := '0%';
    pnlFormDownload.Visible := False;
    pnlDownloading.Visible  := True;
    ProgressBar1.Position := 0;
    lblTitle.Caption := 'Download em andamento...';
  end
  else
  begin
    mmUrlDownload.Text := EmptyStr;
    lblDownloadPercentage.Caption := '0%';
    edtUrlDownload.Text := EmptyStr;
    pnlFormDownload.Visible := True;
    pnlDownloading.Visible  := False;
    lblTitle.Caption := 'Digite os dados para efetuar o download';
  end;
end;

function TfrmViewDownload.FormatGbToMb(Avalue: Int64): String;
begin
  Result := FormatFloat('0.00 mb', (Avalue/1024));
end;

function TfrmViewDownload.FormatToPercentage(AMaxValue, ACurrentValue: Int64): String;
begin
  Result := FormatFloat('0%',Round((ACurrentValue/AMaxValue)*100));
end;

procedure TfrmViewDownload.FormCreate(Sender: TObject);
begin
  FRepositoryDownload := TRepositoryDownloadSqLite.Create(DataModule1.FDConnection);
  FServiceDownloadSubject := TServiceDownloadSubject.Create;
  FServiceDownloadSubject.RegisterObserver(Self);

  FControllerDownloadTasks := TControllerDownloadTasks.Create(FServiceDownloadSubject, FRepositoryDownload);
end;

procedure TfrmViewDownload.Image1Click(Sender: TObject);
begin
  FControllerDownloadTasks.StopDownload;
  ConfigureDownload(False);
end;

procedure TfrmViewDownload.imgBackClick(Sender: TObject);
begin
  Close;
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

procedure TfrmViewDownload.Notify(ANotifyDownloadInformation: TNotifyDownloadInformation);
begin
  if ANotifyDownloadInformation.WorkAcountMax <> ProgressBar1.Max then
    ProgressBar1.Max := ANotifyDownloadInformation.WorkAcountMax;

  if lblDownloadName.Caption <> ANotifyDownloadInformation.DownloadName then
    lblDownloadName.Caption := ANotifyDownloadInformation.DownloadName;

  ProgressBar1.Position := ANotifyDownloadInformation.WorkAcount;
  lblDownloadPercentage.Caption := FormatToPercentage(ANotifyDownloadInformation.WorkAcountMax,  ANotifyDownloadInformation.WorkAcount);
  lblDownloaded.Caption := Concat('Baixado ', FormatGbToMb(ANotifyDownloadInformation.WorkAcount),
                                  ' de ', FormatGbToMb(ANotifyDownloadInformation.WorkAcountMax));

end;

end.
