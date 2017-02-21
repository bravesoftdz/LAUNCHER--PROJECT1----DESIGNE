program Project1;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  News in 'News.pas',
  Status in 'Status.pas',
  CRCUnit in 'CRCUnit.pas',
  Update in 'Update.pas',
  GStart in 'GStart.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
