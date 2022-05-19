unit Presentation.Controller.Download.History;

interface
uses Datasnap.DBClient,Uni, Data.Repository.Download.Interfaces,
     Domain.UseCase.Download.History.Interfaces, Domain.UseCase.Download.History;

type

TIndexImageIcon = (imiSucces, imiCanceled);

TControllerDownloadHistory = Class
  private
    FUseCaseDownloadHistory: IUseCaseDownloadHistory;
  public
    procedure Handle(AClientDataSet: TClientDataSet);
    Constructor Create(ARepositoryDownload: IRepositoryDownload);
End;

implementation
uses System.Generics.Collections, Domain.Abstraction.Download, System.SysUtils;

{ ControllerDownloadHistory }

constructor TControllerDownloadHistory.Create(ARepositoryDownload: IRepositoryDownload);
begin
  FUseCaseDownloadHistory := TUseCaseDownloadHistory.Create(ARepositoryDownload);
end;

procedure TControllerDownloadHistory.Handle(AClientDataSet: TClientDataSet);
var
  ListDownloads: TObjectList<TAbstractionDownload>;
  Download: TAbstractionDownload;
begin
  AClientDataSet.DisableControls;
  try
    AClientDataSet.EmptyDataSet;
    ListDownloads := FUseCaseDownloadHistory.Execute;
    if ((ListDownloads <> nil) and (ListDownloads.Count > 0)) then
    begin
      AClientDataSet.Open;
      for Download in ListDownloads do
      begin
        AClientDataSet.Append;
        AClientDataSet.FieldByName('URL').AsString := Download.Url;
        if DateToStr(Download.FinalDate) <> '30/12/1899' then
        begin
          AClientDataSet
            .FieldByName('DateDetails')
            .AsString := Concat('Início ', DateTimeToStr(Download.InitialDate),' - ',
                                'Termino ',DateTimeToStr(Download.FinalDate));
          AClientDataSet.FieldByName('IconIndex').AsInteger := Integer(TIndexImageIcon.imiSucces);
        end
        else
        begin
          AClientDataSet
            .FieldByName('DateDetails')
            .AsString := Concat('Início ', DateTimeToStr(Download.InitialDate));
          AClientDataSet.FieldByName('IconIndex').AsInteger := Integer(TIndexImageIcon.imiCanceled);
        end;
        AClientDataSet.Post;
      end;
    end;
  finally
    AClientDataSet.EnableControls;
  end;
end;

end.
