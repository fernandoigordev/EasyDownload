unit Domain.UseCase.Download.History.Interfaces;

interface
uses System.Generics.Collections, Domain.Abstraction.Download;

type
  IUseCaseDownloadHistory = interface
    ['{0AD4EE24-2C03-491B-8EEF-2450657F0FA8}']
    function Execute: TObjectList<TAbstractionDownload>;
  end;

implementation

end.
