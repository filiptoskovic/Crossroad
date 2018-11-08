unit uIObserver;

interface

type
  IObserveable = interface;

  IObserver = interface
    procedure Update(AControler : TObject);
  end;

  IObserveable = interface
    procedure Notify;
    procedure Subscribe(AObs : IObserver);
    procedure UnSubscribe(AObs : IObserver);
  end;


implementation

end.
