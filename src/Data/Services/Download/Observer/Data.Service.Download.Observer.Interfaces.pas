unit Data.Service.Download.Observer.Interfaces;

interface

type

TNotifyDownloadInformation = Record
  DownloadName: String;
  WorkAcountMax: Int64;
  WorkAcount: Int64;
End;

IServiceObserver = interface
  ['{972034CE-7243-4AC0-B168-05D710ABAFE5}']
  procedure Notify(ANotifyDownloadInformation: TNotifyDownloadInformation);
end;

IServiceDownloadSubject = interface
  ['{C76A5CE9-2F9A-4DA1-9166-61267310BB81}']
  function StartDownload(AUrl: String): Boolean;
  procedure StopDownload;
  procedure RegisterObserver(AObserver: IServiceObserver);
  procedure UnRegisterObserver(AObserver: IServiceObserver);
  procedure NotifyObservers;
end;

implementation

end.
