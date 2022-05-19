unit Data.Repository.Download.Interfaces;

interface
uses System.Generics.Collections, Domain.Abstraction.Download;

type

IRepositoryDownload = Interface
  ['{6F8E627D-81E3-412F-8EAC-FBE69E81351E}']
  function List: TObjectList<TAbstractionDownload>;
End;

implementation

end.
