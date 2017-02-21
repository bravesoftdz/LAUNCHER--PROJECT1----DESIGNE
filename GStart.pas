unit GStart;

interface

uses
  SysUtils, Classes, ShellApi, Windows, Registry, Dialogs;

type
  TStart = class(tthread)
  private
  protected
    procedure execute; override;
    function getjava: String;
  public

  end;

implementation

Uses Main;

function TStart.getjava: String;
Var
  reg: TRegistry;
  V: String;
begin
  Try
    reg := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
  except
    reg := TRegistry.Create;
  End;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKeyReadOnly('\SOFTWARE\JavaSoft\Java Runtime Environment');
  V := reg.ReadString('CurrentVersion');
  if V <> '' then
  begin
    reg.OpenKeyReadOnly('\SOFTWARE\JavaSoft\Java Runtime Environment\' + V);
    Result := reg.ReadString('JavaHome');
  end
  else
  begin
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKeyReadOnly
      ('\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment');
    V := reg.ReadString('CurrentVersion');
    if V <> '' then
    begin
      reg.OpenKeyReadOnly
        ('\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment\' + V);
      Result := reg.ReadString('JavaHome');
    end;
  end;
  reg.CloseKey;
  reg.free;
end;

procedure TStart.execute;
Var
  Path, Dir, log, pass: String;
begin
  log := Form1.CompoundTextBox1.TextBox.Text;
  pass := Form1.CompoundTextBox2.TextBox.Text;
  if (log <> '') and (pass <> '') then
  begin
    Dir := Form1.LoadOpt('dir');
    if getjava = '' then
      ShowMessage('Установить Java . Сайт: java.com')
    else
    begin
      Path := getjava + '\bin\javaw.exe';
      SetEnvironmentVariable(PChar('APPDATA'), PWideChar(Dir));
      if (FileExists(Dir + '\.minecraft\bin\minecraft.jar')) then
      begin
        ShellExecute(Handle, 'open', PChar(Path),
          PWideChar('-Xincgc -Xmx' + '1024' +
          'M -XX:PermSize=64m -XX:MaxPermSize=128m ' +
          '-Dsun.java2d.noddraw=true -Dsun.java2d.pmoffscreen=false ' +
          '-Dsun.java2d.d3d=false -Dsun.java2d.opengl=false -cp "' + Dir +
          '\.minecraft\bin\minecraft.jar;' + Dir + '\.minecraft\bin\lwjgl.jar;'
          + Dir + '\.minecraft\bin\lwjgl_util.jar;' + Dir +
          '\.minecraft\bin\jinput.jar" -Djava.library.path="' + Dir +
          '\.minecraft\bin\natives" net.minecraft.client.Minecraft ' + log + ' '
          + pass), nil, SW_SHOW);
      end;
    end;
  end;
end;

end.
