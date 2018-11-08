unit Behaverable;

interface

uses
  IBehaverable;

type

  TSlow = class(TInterfacedObject, IBehaver)
    function Behave : integer;
  end;

  TNormal = class(TInterfacedObject, IBehaver)
    function Behave : integer;
  end;

  TBully = class(TInterfacedObject, IBehaver)
    function Behave : integer;
  end;


implementation

{ TBehaver }

function TSlow.Behave: integer;
begin
  result := random(30);
end;

{ TSpeedy }

function TNormal.Behave: integer;
begin
  result := random(30) + 30;
end;

{ TBully }

function TBully.Behave: integer;
begin
  result := random(30) + 70;
end;

end.
