unit uControler;

interface

uses
  System.Generics.Collections, FMX.Types, System.Classes,
  uIObserveable, uIObserver, uRoad;

type
  TTrafficLightControler = class(TComponent, IObserveable)
  private
    FTimer : TTimer;
    {$REGION 'Gets & Setts'}
    FObservers : TList<IObserver>;
    FControlerState : TLightState;
    FDurationsOfLights : TDictionary<TLightState, integer>;
    FActiveLights : TList<TLightState>;
    function GetPower: Boolean;
    procedure SetPower(const Value: Boolean);
    procedure SetControlerState(const Value: TLightState);
    {$ENDREGION}
  public
/// <summary> Represent list of switched on lights on each traffic light group. </summary>
    property ActiveLights : TList<TLightState> read FActiveLights;

/// <summary> Represent duration of each light on leading traffic light group. </summary>
    property DurationsOfLights : TDictionary<TLightState, integer> read FDurationsOfLights;

/// <summary> Swithes traffic light controller. Run/Stop timer/controlling method of traffic light controller </summary>
    property Power : Boolean read GetPower write SetPower;

/// <summary> Represent controller state as state of leading traffic light group. </summary>
    property ControlerState : TLightState read FControlerState write SetControlerState;

/// <summary> Set duration in miliseconds of each light in leading group.</summary>
/// <param name="AVals">The array of pairs(<c>TLightState, integer</c>) where <c>TLightState</c> denotes light state and <c>integer</c> denote duration of corresponding light state.</param>
    procedure InitLightIntervals(AVals : TArray<TPair<TLightState, integer>>);

/// <summary> Notify all subscribers of changes. Implementation of observer pattern <c>Notify</c> method.</summary>
    procedure Notify;

/// <summary> Subscribe parameter object to notifications. Implementation of observer pattern <c>Subscribe</c> method.</summary>
/// <param name="AObs">Object to be notified on changes.</param>
    procedure Subscribe(AObs : IObserver);

/// <summary> Remove parameter object from subscription to notifications. Implementation of observer pattern <c>Unsubscribe</c> method.</summary>
/// <param name="AObs">Object to be removed from notification list.</param>
    procedure UnSubscribe(AObs : IObserver);

/// <summary> Remove parameter object from subscription to notifications.
/// Implementation of observer pattern. <c>Unsubscribe</c> method.</summary>
/// <param name="AObs">Object to be removed from notification list.</param>
    procedure GroupSwitchLight(AGroup : integer; ALight : TLightState);


    procedure Controling(ASender : TObject);      // Do be changed

/// <summary> Get duration of light in miliseconds for specified light.</summary>
/// <param name="ALightState">State of traffic light</param>
/// <returns>Duration in miliseconds.</returns>
    function GetLightDuration(ALightState : TLightState) : integer;

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end;

implementation

{ TTrafficLightControler }

procedure TTrafficLightControler.Controling(ASender: TObject);
var F : integer;

  procedure SetLights(ALight : TLightState);
  begin
    ActiveLights.Items[0] := ALight;
    ActiveLights.Items[1] := TLightState((ord(ALight) + 2) mod 5);
    ControlerState := ALight;
  end;

begin
  F := ord(FControlerState);
  Inc(F);
  F := F mod 5;
  if F = 0 then
    F := 1;
  SetLights(TLightState(F))
end;

constructor TTrafficLightControler.Create(AOwner : TComponent);
begin
  FObservers := TList<IObserver>.Create;
  FActiveLights := TList<TLightState>.Create;
  FDurationsOfLights := TDictionary<TLightState, integer>.Create;
  FTimer := TTimer.Create(self);
  FTimer.Interval := 3000;
  FTimer.Enabled := false;
  FTimer.OnTimer := Controling;
end;

destructor TTrafficLightControler.Destroy;
begin
  FObservers.DisposeOf;
  ActiveLights.DisposeOf;
  DurationsOfLights.DisposeOf;
  inherited;
end;

function TTrafficLightControler.GetLightDuration(ALightState: TLightState): integer;
begin
  result := 0;
  if DurationsOfLights.ContainsKey(ALightState) then
    Result := DurationsOfLights.Items[ALightState];
end;

function TTrafficLightControler.GetPower: Boolean;
begin
  Result := FTimer.Enabled;
end;

procedure TTrafficLightControler.GroupSwitchLight(AGroup: integer; ALight: TLightState);
begin
  ActiveLights[AGroup] := ALight
end;

procedure TTrafficLightControler.InitLightIntervals(AVals: TArray<TPair<TLightState, integer>>);
var P : TPair<TLightState, integer>;
begin
  for p in AVals do
    DurationsOfLights.AddOrSetValue(p.Key, p.Value);
end;

procedure TTrafficLightControler.Notify;
var
  T: IObserver;
begin
  for T in FObservers do
    T.Update(self);
end;

procedure TTrafficLightControler.SetControlerState(const Value: TLightState);
begin
  FControlerState := Value;
  Notify;
end;

procedure TTrafficLightControler.SetPower(const Value: Boolean);
begin
  FTimer.Enabled := Value;
end;

procedure TTrafficLightControler.Subscribe(AObs: IObserver);
begin
  FObservers.Add(aobs);
end;

procedure TTrafficLightControler.UnSubscribe(AObs: IObserver);
begin
  FObservers.Remove(Aobs);
end;

end.
