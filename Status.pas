unit Status;

interface

uses
  SysUtils, Classes, IdHTTP, IdTCPClient;

type
  TStatus = class(tthread)
  private
  protected

    procedure execute; override;

  public
  end;

implementation

Uses Main;

procedure TStatus.execute;
Var
  S: string;
  http: TIdHTTP;
begin
  http := TIdHTTP.Create(nil);
  try
    S := http.Get('http://theproject1.net');

    Delete(S, 1, Pos('<span>RF Online</span>', S) - 1);
    Delete(S, 1, Pos('/images/', S) + 7);
    statrf := Copy(S, 1, Pos('.png', S) - 1);

    Delete(S, 1, Pos('<span>Aion</span>', S) - 1);
    Delete(S, 1, Pos('/images/', S) + 7);
    statai := Copy(S, 1, Pos('.png', S) - 1);

    Delete(S, 1, Pos('<span>MineCraft</span>', S) - 1);
    Delete(S, 1, Pos('/images/', S) + 7);
    statmc := Copy(S, 1, Pos('.png', S) - 1);

    Delete(S, 1, Pos('<span>KillingFloor</span>', S) - 1);
    Delete(S, 1, Pos('/images/', S) + 7);
    statkf := Copy(S, 1, Pos('.png', S) - 1);
    http.Free;
  except
    statrf := 'Error';
    statai := 'Error';
    statmc := 'Error';
    statkf := 'Error';
    http.Free;
  end;
end;

end.
