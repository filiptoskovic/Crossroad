unit uClassObserver;

interface

uses
  uIObserver;

type
  TObserver = class (TInterfacedObject, IObserver)
    procedure Update(AControler : TObject);
  end;

implementation

{ TObserver }

procedure TObserver.Update(AControler : TObject);
begin

end;

end.
