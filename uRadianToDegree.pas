unit uRadianToDegree;

interface

uses
  uRoad;

function GeoToMath (AGeoDirection : TRoadDirection) : TRoadDirection;
function RadianToDegree (ADegree : Extended) : Extended;
function RoadCoord (ASideA, ASIdeB, AAngle : extended): extended;

implementation

function GeoToMath (AGeoDirection : TRoadDirection) : TRoadDirection;
begin
  result := (360 - AGeoDirection + 90) mod 360;
end;

function RadianToDegree (ADegree : Extended) : Extended;
begin
  Result := (2 * Pi * ADegree) / 360;
end;

function RoadCoord (ASideA, ASideB, AAngle : extended): extended;
var HalfD : Extended;
begin
  HalfD := (Sqrt(Sqr(ASideA) + Sqr(ASIdeB))) / 2;
  Result := RadianToDegree(Cos(AAngle)) * HalfD;
end;

end.
