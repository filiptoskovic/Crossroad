unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  uCrossroad, uRoad, uRadianToDegree, uIObserver, MainLogic;

type
  TForm1 = class(TForm, IObserver)
    Image1: TImage;
    butStartStop: TButton;
    Rectangle1: TRectangle;
    ArcDial3: TArcDial;
    ArcDial4: TArcDial;
    ArcDial1: TArcDial;
    ArcDial2: TArcDial;
    Memo1: TMemo;
    Button1: TButton;
    procedure butStartStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private

  public
    procedure DrawCrossRoad(ARoads : TArray<TRoadDirection>);
    procedure Update(AControler : TObject);
  end;

var
  Form1: TForm1;

implementation

uses
  FMX.Grid, uControler, RTTI;

{$R *.fmx}

{ TForm1 }

procedure TForm1.butStartStopClick(Sender: TObject);
begin
  DrawCrossRoad(Crossroad.RoadDirections);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Crossroad.TraficLightControler.Power := not (Crossroad.TraficLightControler.Power);
  if Crossroad.TraficLightControler.Power then
    Button1.Text := 'Off'
  else
    Button1.Text := 'On';
end;

procedure TForm1.DrawCrossRoad(ARoads : TArray<TRoadDirection>);
var Centar : TPointF;
  r: TRoadDirection;

  procedure DrawRoad(AAngle : integer);
  var
    A: Extended;
  begin
    A := RoadCoord(Image1.Bitmap.Width,Image1.Bitmap.Height,AAngle) ;
    Centar.X := Image1.Bitmap.Width / 2;
    Centar.Y := Image1.Bitmap.Height / 2;
    Image1.Bitmap.Canvas.BeginScene;
    Image1.Bitmap.Canvas.DrawLine(Centar, tpointf.Create(Centar.X , A), 1);
    Image1.Bitmap.Canvas.EndScene;
  end;

begin
  for r in ARoads do
    DrawRoad(r);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  R: TRoad;
  TL : IOBserver;
begin
  Crossroad := TCrossRoad.Create( Self, [0, 90, 180], 2);
  for R in Crossroad.Roads do
    R.TraficLight.ControlerGroup := Crossroad.Roads.IndexOf(R) mod 2;
  Crossroad.TraficLightControler.Subscribe(self);
end;

procedure TForm1.Update(AControler: TObject);
var
  R: TRoad;
  i: Integer;
begin
  for R in Crossroad.Roads do
  begin
    i := r.TraficLight.ControlerGroup;
    Memo1.Lines.Add(i.ToString + ' ' + TRttiEnumerationType.GetName(R.TraficLight.LightOn));
  end;
end;

end.
