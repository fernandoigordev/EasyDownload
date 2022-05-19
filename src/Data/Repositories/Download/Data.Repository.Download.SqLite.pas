unit Data.Repository.Download.SqLite;

interface

uses System.Generics.Collections, Domain.Abstraction.Download, Data.Repository.Download.Interfaces,
  FireDAC.Comp.Client, FireDAC.DApt;

type
RepositoryDownloadSqLite = Class(TInterfacedObject, IRepositoryDownload)
  private
    FQuery: TFDQuery;
  public
    function List: TObjectList<TAbstractionDownload>;
    Constructor Create(AConnection: TFdConnection);
    Destructor Destroy;override;
End;

implementation

{ RepositoryDownloadSqLite }

constructor RepositoryDownloadSqLite.Create(AConnection: TFdConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
end;

destructor RepositoryDownloadSqLite.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function RepositoryDownloadSqLite.List: TObjectList<TAbstractionDownload>;
var
  ListAbstractionDownload: TObjectList<TAbstractionDownload>;
  AbstractionDownload: TAbstractionDownload;
begin
  Result := Nil;
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT * FROM LOGDOWNLOAD');
  FQuery.Open;
  if FQuery.RecordCount > 0 then
  begin
    ListAbstractionDownload := TObjectList<TAbstractionDownload>.Create;
    FQuery.First;
    while not FQuery.Eof do
    begin
      AbstractionDownload := TAbstractionDownload.Create;
      AbstractionDownload.Code := FQuery.FieldByName('CODIGO').AsInteger;
      AbstractionDownload.Url := FQuery.FieldByName('URL').AsString;
      AbstractionDownload.InitialDate := FQuery.FieldByName('DATAINICIO').AsDateTime;
      AbstractionDownload.FinalDate := FQuery.FieldByName('DATAFIM').AsDateTime;

      ListAbstractionDownload.Add(AbstractionDownload);

      FQuery.Next;
    end;

    Result := ListAbstractionDownload;
  end;
end;

end.
