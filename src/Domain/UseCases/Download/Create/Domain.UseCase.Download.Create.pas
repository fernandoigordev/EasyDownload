unit Domain.UseCase.Download.Create;

interface
uses Domain.UseCase.Download.Create.Interfaces, Data.Repository.Download.Interfaces, Domain.Abstraction.Download;

type
TUseCaseDownloadCreate = Class(TInterfacedObject, IUseCaseDownloadCreate)
  private
    FRepositoryDownload: IRepositoryDownload;
  public
    Constructor Create(ARepositoryDownload: IRepositoryDownload);
    function Execute(AUrl: String): TAbstractionDownload;
End;

implementation

uses
  System.SysUtils;

{ TUseCaseDownloadSave }

constructor TUseCaseDownloadCreate.Create(ARepositoryDownload: IRepositoryDownload);
begin
  FRepositoryDownload := ARepositoryDownload;
end;

function TUseCaseDownloadCreate.Execute(AUrl: String): TAbstractionDownload;
var
  AbstractionDownload: TAbstractionDownload;
begin
  Result := nil;
  AbstractionDownload := TAbstractionDownload.Create;
  AbstractionDownload.Code := DateTimeToFileDate(Now);
  AbstractionDownload.InitialDate := Now;
  AbstractionDownload.Url := AUrl;
  FRepositoryDownload.CreateDownload(AbstractionDownload);
  Result := AbstractionDownload;
end;

end.
