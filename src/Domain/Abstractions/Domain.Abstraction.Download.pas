unit Domain.Abstraction.Download;

interface

type

TAbstractionDownload = Class
  private
    FCode: Integer;
    FUrl: String;
    FInitialDate: TDateTime;
    FFinalDate: TDateTime;
  public
    property Code: Integer read FCode write FCode;
    property Url: String read FUrl write FUrl;
    property InitialDate: TDateTime read FInitialDate write FInitialDate;
    property FinalDate: TDateTime read FFinalDate write FFinalDate;
End;

implementation

end.
