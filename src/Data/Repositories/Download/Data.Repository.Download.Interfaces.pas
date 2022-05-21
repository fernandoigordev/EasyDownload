unit Data.Repository.Download.Interfaces;

interface
uses System.Generics.Collections, Domain.Abstraction.Download;

type

IRepositoryDownload = Interface
  ['{6F8E627D-81E3-412F-8EAC-FBE69E81351E}']
  procedure CreateDownload(AbstractionDownload: TAbstractionDownload);
  function ReadDownloads: TObjectList<TAbstractionDownload>;
  procedure UpdateDownload(AbstractionDownload: TAbstractionDownload);
End;

implementation

end.
