unit uRoad;

interface

uses
  System.Classes, System.Generics.Collections, FMX.Types,
  uIObserveable, uIObserver, Behaverable, IBehaverable;

type
  TRoadDirection = -360..360;

  TLightState = (LightOff, Red , RedYelow, Green, Yellow);

  TVehicle = class
  private
    FDriver: IBehaver;
  public
    property Driver : IBehaver read FDriver write FDriver;
  end;

  TVehicleGenerator = class(TComponent)
  private
    FPercentageOfFast: integer;
    FPercentageOfSlow: integer;
    FTimer : TTimer;
    procedure SetInterval(const Value: integer);
    function GetInterval: integer;
    procedure SetPower(const Value: Boolean);
    function GetPower: Boolean;
  public
    function produce : Tvehicle;
    property PercentageOfFast : integer read FPercentageOfFast write FPercentageOfFast;
    property PercentageOfSlow : integer read FPercentageOfSlow write FPercentageOfSlow;
    property Interval : integer read GetInterval write SetInterval;
    property Power : Boolean read GetPower write SetPower;
    constructor Create(AOwner : TComponent); override;
  end;

  TTrafficLight = class (TInterfacedObject, IObserveable, IObserver)
  private
    FControlerGroup: integer;
    FLightOn: TLightState;
    FController: TObject;
    function GetControlerGroup: integer;
    procedure SetControlerGroup(const Value: integer);
  public
    procedure Notify;
    procedure Subscribe(AObs : IObserver);
    procedure UnSubscribe(AObs : IObserver);
    procedure Update(AControler : TObject);
    constructor Create;
    destructor Destroy; override;
    property ControlerGroup : integer read GetControlerGroup write SetControlerGroup;
    property LightOn : TLightState read FlightOn;
    property Controller : TObject read FController write FController;

  end;

  TRoad = class
  private
    FVisibleLenght: integer;
    FVehicles : TQueue<TVehicle>;
    FTrafficLight : TTrafficLight;
    FDirection : TRoadDirection;
  public
    property VisibleLenght : integer read FVisibleLenght write FVisibleLenght;
    constructor Create(Adirection : TRoadDirection);
    destructor Destroy; override;
    property Direction : TRoadDirection read FDirection;
    property TraficLight : TTrafficLight read FTrafficLight;
  end;

implementation

uses
  uControler;

{ TTrafficLight }

constructor TTrafficLight.Create;
begin
  inherited;
  FLightOn := Yellow;
end;

destructor TTrafficLight.Destroy;
begin

  inherited;
end;

function TTrafficLight.GetControlerGroup: integer;
begin
  Result := FControlerGroup;
end;

procedure TTrafficLight.Notify;
begin

end;

procedure TTrafficLight.SetControlerGroup(const Value: integer);
begin
    FControlerGroup := Value;
end;

procedure TTrafficLight.Subscribe(AObs: IObserver);
begin

end;

procedure TTrafficLight.UnSubscribe(AObs: IObserver);
begin

end;

procedure TTrafficLight.Update(AControler: TObject);
begin
  if AControler is TTrafficLightControler  then
    FLightOn := TTrafficLightControler(AControler).ActiveLights.Items[ControlerGroup];
end;

{ TRoad }

constructor TRoad.Create(Adirection : TRoadDirection);
begin
  inherited Create;
  FTrafficLight := TTrafficLight.Create;
  FDirection := Adirection;
end;

destructor TRoad.Destroy;
begin
  FTrafficLight.Free;
  inherited;
end;

{ TVehicleGenerator }

constructor TVehicleGenerator.Create(AOwner : TComponent);
begin
  inherited;
  FTimer := TTimer.Create(Self);
end;

function TVehicleGenerator.GetInterval: integer;
begin
  Result := FTimer.Interval div 1000;
end;

function TVehicleGenerator.GetPower: Boolean;
begin
  Result := FTimer.Enabled;
end;

function TVehicleGenerator.produce: Tvehicle;
var
  R: Integer;
begin
  Result := TVehicle.Create;
  R := Random(100);
  if R  < FPercentageOfSlow then
    Result.Driver := TSlow.Create
  else
    if R > FPercentageOfFast then
      Result.Driver := TBully.Create
    else
      Result.Driver := TNormal.Create;
end;

procedure TVehicleGenerator.SetInterval(const Value: integer);
begin
  FTimer.Interval := Value * 1000;
end;

procedure TVehicleGenerator.SetPower(const Value: Boolean);
begin
  FTimer.Enabled := Value;
end;

initialization
  Randomize;
end.
