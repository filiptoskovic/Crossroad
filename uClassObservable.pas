unit uClassObservable;

interface

uses
  uIObserveable, uIObserver;

type
  TObseveable = class(TInterfacedObject, IObserveable)
  private
    FTrafficLight : TObseveable;
    procedure Notify;
    procedure Subscribe(AObs : IObserver);
    procedure UnSubscribe(AObs : IObserver);
    constructor Create;
end;

implementation

{ TObseveable }

constructor TObseveable.Create;
begin
  FTrafficLight := TObseveable.Create;
end;

procedure TObseveable.Notify;
begin

end;

procedure TObseveable.Subscribe(AObs: IObserver);
begin

end;

procedure TObseveable.UnSubscribe(AObs: IObserver);
begin

end;

end.
