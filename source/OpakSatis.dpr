program OpakSatis;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.Satis in 'source\Form.Satis.pas' {F_Satis},
  DBOpak in 'source\DBOpak.pas' {DB: TDataModule},
  Frame.Base in 'source\Frame.Base.pas' {FBase: TFrame},
  Frame.Login in 'source\Frame.Login.pas' {Frame_login: TFrame},
  Frame.Menu in 'source\Frame.Menu.pas' {FMenu: TFrame},
  Form.Cariler in 'source\Form.Cariler.pas' {FCariler: TFrame},
  Genel in 'source\Genel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_Satis, F_Satis);
  Application.CreateForm(TDB, DB);
  Application.Run;
end.
