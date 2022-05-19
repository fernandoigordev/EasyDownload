program EasyDownload;

uses
  Vcl.Forms,
  Presentation.View.Menu in 'src\Presentation\Views\Presentation.View.Menu.pas' {frmViewMenu},
  Presentation.View.Download in 'src\Presentation\Views\Presentation.View.Download.pas' {frmViewDownload},
  Presentation.View.DownloadHistory in 'src\Presentation\Views\Presentation.View.DownloadHistory.pas' {frmViewDownloadHistory},
  Presentation.View.Main in 'src\Presentation\Views\Presentation.View.Main.pas' {frmViewMain},
  Presentation.Routes in 'src\Presentation\Presentation.Routes.pas',
  Domain.UseCase.Download.History.Interfaces in 'src\Domain\UseCases\Download\History\Domain.UseCase.Download.History.Interfaces.pas',
  Domain.Abstraction.Download in 'src\Domain\Abstractions\Domain.Abstraction.Download.pas',
  Domain.UseCase.Download.History in 'src\Domain\UseCases\Download\History\Domain.UseCase.Download.History.pas',
  Data.Repository.Download.Interfaces in 'src\Data\Repositories\Download\Data.Repository.Download.Interfaces.pas',
  Data.Repository.Download.SqLite in 'src\Data\Repositories\Download\Data.Repository.Download.SqLite.pas',
  Presentation.Controller.Download.History in 'src\Presentation\Controllers\Download\Presentation.Controller.Download.History.pas',
  Data.Database.DataModule in 'src\Data\Database\Data.Database.DataModule.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmViewMain, frmViewMain);
  Application.Run;
end.
