program CrossRoad;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  Behaverable in 'Behaverable.pas',
  IBehaverable in 'IBehaverable.pas',
  uIObserver in 'uIObserver.pas',
  uClassObservable in 'uClassObservable.pas',
  uClassObserver in 'uClassObserver.pas',
  uCrossRoad in 'uCrossRoad.pas',
  uRoad in 'uRoad.pas',
  uControler in 'uControler.pas',
  uRadianToDegree in 'uRadianToDegree.pas',
  MainLogic in 'MainLogic.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
