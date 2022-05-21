unit Presentation.Controller.Download.Tasks;

interface

uses Data.Service.Download.Observer.Interfaces, Data.Repository.Download.Interfaces,
     Domain.UseCase.Download.Create.Interfaces, Domain.UseCase.Download.Create,
     System.Threading, Domain.Abstraction.Download, Domain.UseCase.Download.Update.Interfaces,
     Domain.UseCase.Download.Update, System.SysUtils;

type

TControllerDownloadTasks = Class
  private
    FServiceDownloadSubject: IServiceDownloadSubject;
    FUseCaseDownloadCreate: IUseCaseDownloadCreate;
    FUseCaseDownloadUpdate: IUseCaseDownloadUpdate;
    FAbstractionDownload: TAbstractionDownload;
    FTaskDownload: ITask;
  public
    Constructor Create(AServiceDownloadSubject: IServiceDownloadSubject; ARepositoryDownload: IRepositoryDownload);
    procedure StartDownload(AUrl: String; AProcedure: TProc);
    procedure StopDownload;
End;

implementation

uses
  System.Classes;

{ TControllerDownloadTasks }

constructor TControllerDownloadTasks.Create(AServiceDownloadSubject: IServiceDownloadSubject; ARepositoryDownload: IRepositoryDownload);
begin
  FServiceDownloadSubject := AServiceDownloadSubject;
  FUseCaseDownloadCreate := TUseCaseDownloadCreate.Create(ARepositoryDownload);
  FUseCaseDownloadUpdate := TUseCaseDownloadUpdate.Create(ARepositoryDownload);
end;

procedure TControllerDownloadTasks.StartDownload(AUrl: String; AProcedure: TProc);
var
  DownloadSucces: Boolean;
begin
  {Grava no banco}
   FAbstractionDownload := FUseCaseDownloadCreate.Execute(AUrl);

  {Inicia Thread de download}
  FTaskDownload := TTask.Create(procedure
  begin
    DownloadSucces := FServiceDownloadSubject.StartDownload(AUrl);
    TThread.Synchronize(TThread.CurrentThread,
    Procedure
    begin
      {Atualiza banco de dados}
      if DownloadSucces then
      begin
        FAbstractionDownload.FinalDate := Now;
        FUseCaseDownloadUpdate.Execute(FAbstractionDownload);
        AProcedure;
      end
      else
        AProcedure;
    end)
  end);
  FTaskDownload.Start;
end;

procedure TControllerDownloadTasks.StopDownload;
begin
  {Dar Stop na Thread de Download}
  if Assigned(FTaskDownload) and (FTaskDownload.Status = TTaskStatus.Running) then
  begin
    FTaskDownload.Cancel;
    FServiceDownloadSubject.StopDownload;
  end;
end;

end.
