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
  Data.Database.DataModule in 'src\Data\Database\Data.Database.DataModule.pas' {DataModule1: TDataModule},
  Domain.UseCase.Download.Create.Interfaces in 'src\Domain\UseCases\Download\Create\Domain.UseCase.Download.Create.Interfaces.pas',
  Domain.UseCase.Download.Create in 'src\Domain\UseCases\Download\Create\Domain.UseCase.Download.Create.pas',
  Data.Service.Download.Observer.Interfaces in 'src\Data\Services\Download\Observer\Data.Service.Download.Observer.Interfaces.pas',
  Data.Service.Download.Observer.Subject in 'src\Data\Services\Download\Observer\Data.Service.Download.Observer.Subject.pas',
  Presentation.Controller.Download.Tasks in 'src\Presentation\Controllers\Download\Presentation.Controller.Download.Tasks.pas',
  Domain.UseCase.Download.Update.Interfaces in 'src\Domain\UseCases\Download\Update\Domain.UseCase.Download.Update.Interfaces.pas',
  Domain.UseCase.Download.Update in 'src\Domain\UseCases\Download\Update\Domain.UseCase.Download.Update.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmViewMain, frmViewMain);
  Application.Run;
end.
