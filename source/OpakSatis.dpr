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
  Genel in 'source\Genel.pas',
  Frame.Cari in 'source\Frame.Cari.pas' {FForm_Cari: TFrame},
  OMR.Cari in 'source\OMR.Cari.pas',
  Frame.iletisim in 'source\Frame.iletisim.pas' {F_iletisim: TFrame},
  OpenViewUrl in 'source\OpenViewUrl.pas',
  Frame.Map in 'source\Frame.Map.pas' {Frame_Map: TFrame},
  Frame.Note in 'source\Frame.Note.pas' {F_Note: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_Satis, F_Satis);
  Application.CreateForm(TDB, DB);
  Application.Run;
end.
