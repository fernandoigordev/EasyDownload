unit Domain.UseCase.Download.History;

interface
uses System.Generics.Collections, Domain.Abstraction.Download, Domain.UseCase.Download.History.Interfaces,
     Data.Repository.Download.Interfaces;

type

TUseCaseDownloadHistory = Class(TInterfacedObject, IUseCaseDownloadHistory)
  private
    FRepositoryDownload: IRepositoryDownload;
  public
    function Execute: TObjectList<TAbstractionDownload>;
    Constructor Create(ARepositoryDownload: IRepositoryDownload);
End;

implementation

{ TUseCaseDownloadHistory }

constructor TUseCaseDownloadHistory.Create(ARepositoryDownload: IRepositoryDownload);
begin
  FRepositoryDownload := ARepositoryDownload;
end;

function TUseCaseDownloadHistory.Execute: TObjectList<TAbstractionDownload>;
begin
  Result := FRepositoryDownload.List;
end;

end.
