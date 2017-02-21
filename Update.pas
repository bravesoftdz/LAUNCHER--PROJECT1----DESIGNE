unit Update;

interface

uses
  SysUtils, Classes, IdHTTP, IdTCPClient, Registry, CRCunit, StrUtils, IdURI,
  Dialogs;

type
  TUpdate = class(tthread)
  private
  protected
    procedure UpdateList(StartDir: string; List: TStringList);
    procedure Update;
    procedure execute; override;
  public
  end;

Var
  UList: TStringList;
  Dir: String;

implementation

Uses Main;

Procedure TUpdate.Update;
var
  i, Count: Integer;
  stream: TFileStream;
  http: TIdHTTP;
  cd, d, url: string;
begin
  Form1.ProgressBar1.Value := 0;
  Form1.ProgressBar1.Max := UList.Count;
  Count := UList.Count;

  Form1.Button1.Enabled := False;
  Form1.Button2.Enabled := False;
  Form1.Button3.Enabled := False;
  Form1.Button4.Enabled := False;

  for i := 0 to UList.Count - 1 do
  begin
    http := TIdHTTP.Create;
    Count := Count - 1;
    Form1.HudLabel1.Text := 'Устарело: ' + IntTOStr(Count);
    Form1.ProgressBar1.Value := Form1.ProgressBar1.Value + 1;

    d := Dir + UList.Names[i];
    cd := copy(d, 0, Length(d) - Pos('\', AnsiReverseString(d)));
    if DirectoryExists(d) = False then
      ForceDirectories(cd);

    stream := TFileStream.Create(Dir + UList.Names[i], fmCreate);
    url := 'http://dl.dropbox.com/u/7335408/' + StringReplace(UList.Names[i],
      '\', '/', [rfReplaceAll, rfIgnoreCase]);
    try
      try
        http.Get(TIdURI.ParamsEncode(url), stream);
      except
        on E: Exception do
      end;
    finally
      FreeAndNil(http);
      FreeAndNil(stream);
    end;
  end;
  Form1.ProgressBar1.Value := 0;
  Form1.Button1.Enabled := True;
  Form1.Button2.Enabled := True;
  Form1.Button3.Enabled := True;
  Form1.Button4.Enabled := True;
  Form1.ProgressBar1.Visible := False;
  Form1.ColorButton1.Visible := True;
end;

procedure TUpdate.UpdateList(StartDir: string; List: TStringList);
var
  SearchRec: TSearchRec;
  Fold: String;
begin
  if StartDir[Length(StartDir)] <> '\' then
    StartDir := StartDir + '\';
  if FindFirst(StartDir + '*.*', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory) <> faDirectory then
      begin
        Fold := StringReplace(StartDir, Dir, '', [rfReplaceAll, rfIgnoreCase]);
        if UList.Values[(Fold + SearchRec.Name)
          ] = IntToHex(GetFileCRC(StartDir + SearchRec.Name), 8) then
          UList.Delete(UList.IndexOf(Fold + SearchRec.Name + '=' + UList.Values
            [(Fold + SearchRec.Name)]));
      end
      else if (SearchRec.Name <> '..') and (SearchRec.Name <> '.') then
      begin
        UpdateList(StartDir + SearchRec.Name + '\', List);
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;
end;

procedure TUpdate.execute;
Var
  Path: String;
  stream: TFileStream;
  http: TIdHTTP;
begin
  Path := Form1.LoadOpt('dir');
  if (Path <> '') and (DirectoryExists(Path)) then
  begin

    Dir := Path;
    UList := TStringList.Create;
    http := TIdHTTP.Create;

    stream := TFileStream.Create(GetCurrentDir + '/' + SelGame + 'list.dwn',
      fmCreate);
    try
      try
        http.Get('http://dl.dropbox.com/u/7335408/' + SelGame +
          'list.dwn', stream);
      except
        on pe: EIdHTTPProtocolException do
          ShowMessage('Обновление не доступно..' + #13 + 'Ошибка: ' +
            IntTOStr(pe.ErrorCode));
      end;
    finally
      FreeAndNil(http);
      FreeAndNil(stream);
      UList.LoadFromFile(GetCurrentDir + '/' + SelGame + 'list.dwn');
      UpdateList(Path, UList);
      Form1.HudLabel1.Text := 'Устарело:' + ' ' + IntTOStr(UList.Count);

      if UList.Count > 0 then
      begin
        Update; // НАЧАТЬ ОБНОВЛЕНИЕ
      end
      else
      begin
        Form1.ProgressBar1.Visible := False;
        Form1.ColorButton1.Visible := True;
      end;

    end;
  end;
end;

end.
