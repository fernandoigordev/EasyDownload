unit Data.Service.Download.Observer.Subject;

interface

uses Data.Service.Download.Observer.Interfaces, IdHTTP, System.Classes,
  System.Generics.Collections, IdComponent, IdSSLOpenSSL;

type

TServiceDownloadSubject = Class(TInterfacedObject, IServiceDownloadSubject)
  private
    FIdHttp: TIdHttp;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    FFileDownload: TFileStream;
    FNotifyDownloadInformation: TNotifyDownloadInformation;
    FObserversList: TList<IServiceObserver>;

    procedure OnBeginWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    function GetNameFromUrl(AUrl: String): String;
  public
    Constructor Create;
    Destructor Destroy;override;
    function StartDownload(AUrl: String): Boolean;
    procedure StopDownload;
    procedure RegisterObserver(AObserver: IServiceObserver);
    procedure UnRegisterObserver(AObserver: IServiceObserver);
    procedure NotifyObservers;
End;

implementation

uses
  Vcl.Dialogs, System.SysUtils, System.Types;

{ TServiceDownloadSubject }

constructor TServiceDownloadSubject.Create;
begin
  FIdHttp := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvSSLv23;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1_2, sslvTLSv1_1, sslvTLSv1];
  FIdHttp.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdHttp.HandleRedirects := True;

  FIdHttp.OnWorkBegin := OnBeginWork;
  FIdHttp.OnWork := OnWork;
  FObserversList := TList<IServiceObserver>.Create;
end;

destructor TServiceDownloadSubject.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHttp.Free;
  inherited;
end;

function TServiceDownloadSubject.GetNameFromUrl(AUrl: String): String;
var
  PositionPos: Integer;
begin
  PositionPos := LastDelimiter('/', AUrl);
  Result := Copy(AUrl, PositionPos+1, MaxInt);
end;

procedure TServiceDownloadSubject.NotifyObservers;
var
  Index: Integer;
begin
  for Index := 0 to FObserversList.Count-1 do
    FObserversList.Items[Index].Notify(FNotifyDownloadInformation);
end;

procedure TServiceDownloadSubject.OnBeginWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  FNotifyDownloadInformation.DownloadName := GetNameFromUrl(FIdHttp.URL.URI);
  FNotifyDownloadInformation.WorkAcountMax := AWorkCountMax;
  FNotifyDownloadInformation.WorkAcount := 1;
  NotifyObservers;
end;

procedure TServiceDownloadSubject.OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  FNotifyDownloadInformation.WorkAcount := AWorkCount;
  NotifyObservers;
end;

procedure TServiceDownloadSubject.RegisterObserver(AObserver: IServiceObserver);
begin
  if FObserversList.IndexOfItem(AObserver, TDirection.FromBeginning) = -1 then
    FObserversList.Add(AObserver);
end;

function TServiceDownloadSubject.StartDownload(AUrl: String): Boolean;
var
  SaveDialog: TSaveDialog;
  SaveDialogSucces: Boolean;
begin
  Result := False;
  SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.FileName := GetNameFromUrl(AUrl);
    SaveDialog.Filter := ExtractFileExt(Concat('|*',AUrl));

    TThread.Synchronize(nil, procedure
    begin
      SaveDialogSucces := SaveDialog.Execute;
    end);

    if SaveDialogSucces then
    begin
      FFileDownload := TFileStream.Create(SaveDialog.FileName, fmCreate);
      try
        FIdHttp.Get(AUrl, FFileDownload);
        Result := True;
      finally
        FFileDownload.Free;
      end;
    end;
  finally
    SaveDialog.Free;
  end;
end;

procedure TServiceDownloadSubject.StopDownload;
begin
  FIdHttp.Disconnect;
  if Assigned(FFileDownload) then
  begin
    DeleteFile(FFileDownload.FileName);
  end;
end;

procedure TServiceDownloadSubject.UnRegisterObserver(AObserver: IServiceObserver);
begin
  if FObserversList.IndexOfItem(AObserver, TDirection.FromBeginning) <> -1 then
    FObserversList.Remove(AObserver);
end;

end.
