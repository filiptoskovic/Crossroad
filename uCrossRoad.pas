unit uCrossRoad;

interface

uses
  System.Generics.Collections, System.Classes,
  uControler, uRoad;

type
  TCrossRoad = class(TComponent)
  private
    FTraficLightControler : TTrafficLightControler;
    FRoads : TList<TRoad>;
    function GetDirections: TArray<TRoadDirection>;
  public
    property TraficLightControler : TTrafficLightControler read FTraficLightControler;
    property Roads : TList<TRoad> read FRoads;
    property RoadDirections : TArray<TRoadDirection> read GetDirections;
    constructor Create(AOwner : TComponent; ARoads : array of TRoadDirection; AGroupCount : integer); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TCrossRoad }

constructor TCrossRoad.Create(AOwner : TComponent; ARoads : array of TRoadDirection; AGroupCount : integer);
var
  D: TRoadDirection;
  R: TRoad;
  i: Integer;
begin
  inherited Create(AOwner);
  FTraficLightControler := TTrafficLightControler.Create(Self);
  for i := 1 to AGroupCount do
    FTraficLightControler.ActiveLights.Add(LightOff);

  FRoads := TList<TRoad>.Create;
  for D in ARoads do
  begin
    R := TRoad.Create(D);
    R.TraficLight.Controller := TraficLightControler;
    TraficLightControler.Subscribe(R.TraficLight);
    Roads.Add(R);
  end;
end;


destructor TCrossRoad.Destroy;
begin
  TraficLightControler.Free;
  Roads.DisposeOf;
  inherited;
end;

function TCrossRoad.GetDirections: TArray<TRoadDirection>;
var
  l: TList<TRoadDirection>;
  r: TRoad;
begin
  l := TList<TRoadDirection>.Create;
  for r in Roads do
    l.Add(r.Direction);
  Result := l.ToArray;
  l.DisposeOf;
end;

end.
