unit Domain.UseCase.Download.Update;

interface

uses Domain.UseCase.Download.Update.Interfaces, Domain.Abstraction.Download, Data.Repository.Download.Interfaces;

type
TUseCaseDownloadUpdate =  Class(TInterfacedObject, IUseCaseDownloadUpdate)
  private
    FRepositoryDownload: IRepositoryDownload;
  public
    Constructor Create(ARepositoryDownload: IRepositoryDownload);
    procedure Execute(AAbstractionDownload: TAbstractionDownload);
End;

implementation

{ TUseCaseDownloadUpdate }

constructor TUseCaseDownloadUpdate.Create(ARepositoryDownload: IRepositoryDownload);
begin
  FRepositoryDownload := ARepositoryDownload;
end;

procedure TUseCaseDownloadUpdate.Execute(AAbstractionDownload: TAbstractionDownload);
begin
  FRepositoryDownload.UpdateDownload(AAbstractionDownload);
end;

end.
