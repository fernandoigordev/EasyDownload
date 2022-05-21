unit Domain.UseCase.Download.Update.Interfaces;

interface
uses Domain.Abstraction.Download;
type

IUseCaseDownloadUpdate = interface
  ['{AFA14EEC-BF50-4843-B8F0-328AA9864339}']
  procedure Execute(AbstractionDownload: TAbstractionDownload);
end;

implementation

end.
