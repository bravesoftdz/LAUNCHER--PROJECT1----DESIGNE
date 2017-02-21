unit Main;

interface

uses
  Windows, SysUtils, Variants, Classes, Messages, Forms,
  Dialogs, vg_scene, vg_objects, vg_controls, vg_layouts, Controls, vg_textbox,
  vg_extctrls, ImgList, vg_actions, News, ShellAPI, Status, ExtCtrls, Registry,
  FileCtrl, Update, GStart;

type
  TForm1 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgLayout;
    HudPanel1: TvgHudPanel;
    Image1: TvgImage;
    Button1: TvgButton;
    Button2: TvgButton;
    Button3: TvgButton;
    Button4: TvgButton;
    Resources1: TvgResources;
    Image3: TvgImage;
    BitmapObject1: TvgBitmapObject;
    BitmapObject2: TvgBitmapObject;
    BitmapObject3: TvgBitmapObject;
    BitmapObject4: TvgBitmapObject;
    BitmapObject5: TvgBitmapObject;
    BitmapObject6: TvgBitmapObject;
    BitmapObject7: TvgBitmapObject;
    BitmapObject8: TvgBitmapObject;
    Layout1: TvgLayout;
    TextBox1: TvgTextBox;
    TextBox2: TvgTextBox;
    TextBox3: TvgTextBox;
    TextBox4: TvgTextBox;
    Layout2: TvgLayout;
    CompoundTextBox1: TvgCompoundTextBox;
    CompoundTextBox2: TvgCompoundTextBox;
    HudButton1: TvgHudButton;
    HudButton2: TvgHudButton;
    ProgressBar1: TvgProgressBar;
    HudLabel1: TvgHudLabel;
    Image2: TvgImage;
    ColorButton1: TvgColorButton;
    Timer1: TTimer;
    HudWindow1: TvgHudWindow;
    Button5: TvgButton;
    TextBox5: TvgTextBox;
    Image4: TvgImage;
    CloseButton2: TvgCloseButton;
    Button6: TvgButton;
    procedure GamButSel(BitObj: TvgBitmapObject; Logo: TvgBitmapObject);
    procedure News;
    procedure ShowNews(Sender: TObject);
    procedure Status;
    procedure SetStatColor(s: string);
    procedure SaveOpt(t: String; s: String);
    function LoadOpt(t: String): String;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure HudPanel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TextBox1Click(Sender: TObject);
    procedure TextBox2Click(Sender: TObject);
    procedure TextBox3Click(Sender: TObject);
    procedure TextBox4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HudButton2Click(Sender: TObject);
    procedure HudButton1Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  statrf, statai, statmc, statkf: String;
  NN1, NL1, NN2, NL2, NN3, NL3, NN4, NL4: String;
  // NN - Õ‡Á‚‡ÌËÂ ÌÓ‚ÓÒÚË , NL - —Ò˚ÎÍ‡
  SelGame: String;

implementation

{$R *.dfm}

procedure TForm1.GamButSel(BitObj: TvgBitmapObject; Logo: TvgBitmapObject);
// ¬˚·Ó Ë„˚.
begin
  if Layout1.Visible = True then
  begin
    Layout1.Visible := False;
    Layout2.Visible := True;
  end;

  if Logo = BitmapObject7 then
    Image2.Position.X := 225
  else
    Image2.Position.X := 244;

  if Form1.Width <> 700 then
  begin
    HudPanel1.Width := 460;
    Form1.Width := 700;
    Image3.Visible := True;
  end;

  if BitObj = BitmapObject2 then
    Form1.Width := 670;
  if BitObj = BitmapObject4 then
    Form1.Width := 730;

  Image3.Bitmap := BitObj.Bitmap;
  Image2.Bitmap := Logo.Bitmap;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  GamButSel(BitmapObject1, BitmapObject5);
  SelGame := 'rf';
  SetStatColor(statrf);
  CompoundTextBox1.TextBox.Text := LoadOpt('log');
  CompoundTextBox2.TextBox.Text := LoadOpt('pas');
  if Image4.Visible <> True then
  begin
    Image4.Visible := True;
    CloseButton2.Visible := True;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  GamButSel(BitmapObject2, BitmapObject6);
  SelGame := 'ai';
  SetStatColor(statai);
  CompoundTextBox1.TextBox.Text := LoadOpt('log');
  CompoundTextBox2.TextBox.Text := LoadOpt('pas');
  if Image4.Visible <> True then
  begin
    Image4.Visible := True;
    CloseButton2.Visible := True;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  GamButSel(BitmapObject3, BitmapObject7);
  SelGame := 'mc';
  SetStatColor(statmc);
  CompoundTextBox1.TextBox.Text := LoadOpt('log');
  CompoundTextBox2.TextBox.Text := LoadOpt('pas');
  if Image4.Visible <> True then
  begin
    Image4.Visible := True;
    CloseButton2.Visible := True;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  GamButSel(BitmapObject4, BitmapObject8);
  SelGame := 'kf';
  SetStatColor(statkf);
  CompoundTextBox1.TextBox.Text := LoadOpt('log');
  CompoundTextBox2.TextBox.Text := LoadOpt('pas');
  if Image4.Visible <> True then
  begin
    Image4.Visible := True;
    CloseButton2.Visible := True;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
Var
  Dir: String;
begin
  SelectDirectory('¬˚·ÂË Ô‡ÔÍÛ ‚˚·‡ÌÌÓÈ Ë„˚', 'd:\ , c:\', Dir,
    [sdNewFolder, sdNewUI]);
  SaveOpt('dir', Dir);
  TextBox5.Text := LoadOpt('dir');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  HudWindow1.Visible := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Status;
  News;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

procedure TForm1.HudButton1Click(Sender: TObject);
Var
  s: TStart;
begin
  if (CompoundTextBox1.TextBox.Text <> '') and
    (CompoundTextBox2.TextBox.Text <> '') then
  begin
    SaveOpt('log', CompoundTextBox1.TextBox.Text);
    SaveOpt('pas', CompoundTextBox2.TextBox.Text);
    s := TStart.Create(True);
    s.Priority := tpNormal;
    s.FreeOnTerminate := True;
    s.Resume;
  end;
end;

procedure TForm1.HudButton2Click(Sender: TObject);
Var
  U: TUpdate;
begin
  ColorButton1.Visible := False;
  ProgressBar1.Visible := True;
  if SysUtils.DirectoryExists(LoadOpt('dir')) then
  begin
    U := TUpdate.Create(True);
    U.Priority := tpNormal;
    U.FreeOnTerminate := True;
    U.Resume;
  end
  else
    HudWindow1.Visible := True;
end;

procedure TForm1.HudPanel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  HudWindow1.Visible := True;
  TextBox5.Text := LoadOpt('dir');
end;

/// /////////////////////////////////    œŒÀ”◊≈Õ»≈ ÕŒ¬Œ—“≈…  /////////////////////
procedure TForm1.News;
Var
  s: TNews;
begin
  s := TNews.Create(True);
  s.Priority := tpNormal;
  s.FreeOnTerminate := True;
  s.OnTerminate := ShowNews;
  s.Resume;
end;

procedure TForm1.ShowNews(Sender: TObject);
begin
  TextBox1.Text := NN1;
  TextBox2.Text := NN2;
  TextBox3.Text := NN3;
  TextBox4.Text := NN4;
end;

procedure TForm1.TextBox1Click(Sender: TObject);
begin
  if NL1 <> '' then
    ShellExecute(Handle, nil, PWideChar(NL1), nil, nil, SW_SHOW);
end;

procedure TForm1.TextBox2Click(Sender: TObject);
begin
  if NL2 <> '' then
    ShellExecute(Handle, nil, PWideChar(NL2), nil, nil, SW_SHOW);
end;

procedure TForm1.TextBox3Click(Sender: TObject);
begin
  if NL3 <> '' then
    ShellExecute(Handle, nil, PWideChar(NL3), nil, nil, SW_SHOW);
end;

procedure TForm1.TextBox4Click(Sender: TObject);
begin
  if NL4 <> '' then
    ShellExecute(Handle, nil, PWideChar(NL4), nil, nil, SW_SHOW);
end;

/// /////////////////////////////////    ŒÕ≈÷ œŒÀ”◊≈Õ»ﬂ ÕŒ¬Œ—“≈…  /////////////////////

/// //////////////////////////////   œ–Œ¬≈– ¿ —“¿“”—Œ¬ ///////////////////////////////
procedure TForm1.SetStatColor(s: string);
begin
  if ColorButton1.Visible <> True then
    ColorButton1.Visible := True;

  Timer1.Interval := 120000; // ÒÚ‡‚ËÏ “‡ÈÏÂ Ì‡ 2ÏËÌ ÔÓ‚ÂÍÛ.
  if s = 'Online' then
    ColorButton1.Color := '#FF33960E'; // Online
  if s = 'Offline' then
    ColorButton1.Color := '#FF960E0E'; // Offline
  if s = 'Error' then
  begin
    ColorButton1.Color := '#FF960E0E';
    Timer1.Interval := 30000; // ≈ÒÎË Ò‡ÈÚ ÛÔ‡Î , Û˜‡˘‡ÂÏ ÔÓ‚ÂÍÛ.
  end;
  ColorButton1.Text := s;
end;

procedure TForm1.Status;
Var
  s: TStatus;
begin
  s := TStatus.Create(True);
  s.Priority := tpNormal;
  s.FreeOnTerminate := True;
  s.Resume;
end;
/// /////////////////////////////////    ŒÕ≈÷ œ–Œ¬≈– » —“¿“”—Œ¬ //////////////////

/// /////////////////////////////////—Œ’–¿Õ≈Õ»≈ «¿√–”« ¿ — –≈≈—“–¿//////////////
procedure TForm1.SaveOpt(t: String; s: String);
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      if OpenKey('\SOFTWARE\TheProject1', True) then
      begin
        WriteString(t + SelGame, s);
        WriteString(t + SelGame, s);
        CloseKey;
      end;
    finally
      Free;
    end;
end;

function TForm1.LoadOpt(t: String): String;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      if OpenKey('\SOFTWARE\TheProject1', True) then
      begin
        Result := ReadString(t + SelGame);
        CloseKey;
      end;
    finally
      Free;
    end;
end;

/// ///////////////////////////// ŒÕ≈÷ –≈≈—“–¿//////////////////////////////////
end.
