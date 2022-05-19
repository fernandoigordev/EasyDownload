unit Presentation.Routes;

interface

uses
  Vcl.Controls, Presentation.View.Menu, Presentation.View.Download,
  Presentation.View.DownloadHistory;

type

TRouter = (rViewMenu, rViewDownload, rViewDownloadHistory);

TRoutes = Class
  private
    FParent: TWinControl;
    ViewMenu: TfrmViewMenu;
    ViewDownload: TfrmViewDownload;
    ViewDownloadHistory: TfrmViewDownloadHistory;
  public
    procedure SetElement(ARouter: TRouter);
    Constructor Create(AParent: TWinControl);
    Destructor Destroy;override;
End;

var
  Routes: TRoutes;

implementation

{ TRoutes }

constructor TRoutes.Create(AParent: TWinControl);
begin
  FParent := AParent;
end;

destructor TRoutes.Destroy;
begin
  if Assigned(ViewMenu) then
    ViewMenu.Free;

  if Assigned(ViewDownload) then
    ViewDownload.Free;

  if Assigned(ViewDownloadHistory) then
    ViewDownloadHistory.Free;
  inherited;
end;

procedure TRoutes.SetElement(ARouter: TRouter);
begin
  case ARouter of
    rViewMenu:
    begin
      if not Assigned(ViewMenu) then
      begin
        ViewMenu := TfrmViewMenu.Create(FParent);
        ViewMenu.Parent := FParent;
        ViewMenu.Align  := alClient;
        ViewMenu.Show;
      end;
      if not ViewMenu.Showing then
        ViewMenu.Show;
      ViewMenu.BringToFront;
    end;

    rViewDownload:
    begin
      if not Assigned(ViewDownload) then
      begin
        ViewDownload := TfrmViewDownload.Create(FParent);
        ViewDownload.Parent := FParent;
        ViewDownload.Align  := alClient;
        ViewDownload.Show;
      end;
      if not ViewDownload.Showing then
        ViewDownload.Show;
      ViewDownload.BringToFront;
    end;

    rViewDownloadHistory:
    begin
      if not Assigned(ViewDownloadHistory) then
      begin
        ViewDownloadHistory := TfrmViewDownloadHistory.Create(FParent);
        ViewDownloadHistory.Parent := FParent;
        ViewDownloadHistory.Align  := alClient;
      end;
      if not ViewDownloadHistory.Showing then
        ViewDownloadHistory.Show;
      ViewDownloadHistory.BringToFront;
    end;

  end;
end;

end.
