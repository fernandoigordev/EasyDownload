unit Data.Repository.Download.SqLite;

interface

uses System.Generics.Collections, Domain.Abstraction.Download, Data.Repository.Download.Interfaces,
  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Phys.SQLite;

type
TRepositoryDownloadSqLite = Class(TInterfacedObject, IRepositoryDownload)
  private
    FQuery: TFDQuery;
  public
    procedure CreateDownload(AbstractionDownload: TAbstractionDownload);
    function ReadDownloads: TObjectList<TAbstractionDownload>;
    procedure UpdateDownload(AbstractionDownload: TAbstractionDownload);
    Constructor Create(AConnection: TFdConnection);
    Destructor Destroy;override;
End;

implementation

uses
  System.SysUtils;

{ RepositoryDownloadSqLite }

constructor TRepositoryDownloadSqLite.Create(AConnection: TFdConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
end;

procedure TRepositoryDownloadSqLite.CreateDownload(AbstractionDownload: TAbstractionDownload);
begin
  FQuery.Close;
  FQuery.SQL.Clear;

  if DateToStr(AbstractionDownload.FinalDate) <> '30/12/1899' then
  begin
    FQuery.SQL.Add(Concat('INSERT INTO LOGDOWNLOAD(CODIGO, URL, DATAINICIO, DATAFIM) ',
                         'VALUES(:CODIGO, :URL, :DATAINICIO, :DATAFIM)'));
    FQuery.ParamByName('CODIGO').AsInteger := AbstractionDownload.Code;
    FQuery.ParamByName('URL').AsString := AbstractionDownload.Url;
    FQuery.ParamByName('DATAINICIO').AsDateTime := AbstractionDownload.InitialDate;
    FQuery.ParamByName('DATAFIM').AsDateTime := AbstractionDownload.FinalDate;
  end
  else
  begin
    FQuery.SQL.Add(Concat('INSERT INTO LOGDOWNLOAD(CODIGO, URL, DATAINICIO) ',
                         'VALUES(:CODIGO, :URL, :DATAINICIO)'));
    FQuery.ParamByName('CODIGO').AsInteger := AbstractionDownload.Code;
    FQuery.ParamByName('URL').AsString := AbstractionDownload.Url;
    FQuery.ParamByName('DATAINICIO').AsDateTime := AbstractionDownload.InitialDate;
  end;
  FQuery.ExecSQL;
end;

destructor TRepositoryDownloadSqLite.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TRepositoryDownloadSqLite.ReadDownloads: TObjectList<TAbstractionDownload>;
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

procedure TRepositoryDownloadSqLite.UpdateDownload(AbstractionDownload: TAbstractionDownload);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Concat('UPDATE LOGDOWNLOAD SET URL = :URL, DATAINICIO = :DATAINICIO, DATAFIM = :DATAFIM ',
                        'WHERE CODIGO = :CODIGO'));
  FQuery.ParamByName('CODIGO').AsInteger := AbstractionDownload.Code;
  FQuery.ParamByName('URL').AsString := AbstractionDownload.Url;
  FQuery.ParamByName('DATAINICIO').AsDateTime := AbstractionDownload.InitialDate;
  FQuery.ParamByName('DATAFIM').AsDateTime := AbstractionDownload.FinalDate;
  FQuery.Execute;
end;

end.
