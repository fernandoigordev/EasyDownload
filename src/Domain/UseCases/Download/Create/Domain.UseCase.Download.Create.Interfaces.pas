unit Domain.UseCase.Download.Create.Interfaces;

interface
uses Domain.Abstraction.Download;

type

IUseCaseDownloadCreate = interface
  ['{106E4892-5557-47AA-956E-2ECD981DBD25}']
  function Execute(AUrl: String): TAbstractionDownload;
end;

implementation

end.
