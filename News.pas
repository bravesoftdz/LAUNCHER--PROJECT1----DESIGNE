unit News;

interface

uses
  SysUtils, Classes, IdHTTP, IdTCPClient;

type
  TNews = class(tthread)
  private
  protected

    procedure execute; override;

  public
  end;

implementation

Uses Main;

procedure TNews.execute;
Var
  S: string;
  http: TIdHTTP;
begin
  http := TIdHTTP.Create(nil);
  try
    S := http.Get
      ('http://theproject1.net/index.php?option=com_content&view=article&id=123&catid=85');
    Delete(S, 1, Pos('<p>---</p>', S) - 1);

    Delete(S, 1, Pos('="', S) + 1);
    NL1 := 'http://theproject1.net' + Copy(S, 1, Pos('"', S) - 1);
    Delete(S, 1, Pos('>', S));
    NN1 := Copy(S, 1, Pos('<', S) - 1);

    Delete(S, 1, Pos('="', S) + 1);
    NL2 := 'http://theproject1.net' + Copy(S, 1, Pos('"', S) - 1);
    Delete(S, 1, Pos('>', S));
    NN2 := Copy(S, 1, Pos('<', S) - 1);

    Delete(S, 1, Pos('="', S) + 1);
    NL3 := 'http://theproject1.net' + Copy(S, 1, Pos('"', S) - 1);
    Delete(S, 1, Pos('>', S));
    NN3 := Copy(S, 1, Pos('<', S) - 1);

    Delete(S, 1, Pos('="', S) + 1);
    NL4 := 'http://theproject1.net' + Copy(S, 1, Pos('"', S) - 1);
    Delete(S, 1, Pos('>', S));
    NN4 := Copy(S, 1, Pos('<', S) - 1);

    http.Free;
  except
    NN1:='Новости не доступны';
    NN2:='Новости не доступны';
    NN3:='Новости не доступны';
    NN4:='Новости не доступны';
    http.Free;
  end;
end;

end.
