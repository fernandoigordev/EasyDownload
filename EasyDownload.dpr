program EasyDownload;

uses
  Vcl.Forms,
  Presentation.View.Menu in 'src\Presentation\Views\Presentation.View.Menu.pas' {frmViewMenu},
  Presentation.View.Download in 'src\Presentation\Views\Presentation.View.Download.pas' {frmViewDownload},
  Presentation.View.DownloadHistory in 'src\Presentation\Views\Presentation.View.DownloadHistory.pas' {frmViewDownloadHistory},
  Presentation.View.Main in 'src\Presentation\Views\Presentation.View.Main.pas' {frmViewMain},
  Presentation.Routes in 'src\Presentation\Presentation.Routes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmViewMain, frmViewMain);
  Application.Run;
end.
