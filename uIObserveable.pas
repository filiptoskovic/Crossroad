unit uIObserveable;

interface

uses
  uIObserver;
type

  IObserveable = interface
    procedure Notify;
    procedure Subscribe(AObs : IObserver);
    procedure UnSubscribe(AObs : IObserver);
  end;

implementation

end.
