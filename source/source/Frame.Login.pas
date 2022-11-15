unit Frame.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Frame.Base, uSkinLabelType, uSkinFireMonkeyLabel, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinFireMonkeyControl, uSkinCalloutRectType,
  uSkinImageType, uSkinFireMonkeyImage,DBOpak, uSkinCheckBoxType,
  uSkinFireMonkeyCheckBox, FMX.Edit, FMX.Controls.Presentation,
  uSkinFireMonkeyEdit, FMX.Layouts, uSkinMaterial, uSkinEditType,
  uSkinPageControlType, uSkinFireMonkeyPageControl, uSkinButtonType,
  uSkinFireMonkeyButton, Data.DB, DBAccess, Uni;

type
  TFrame_login = class(TFBase)
    SkinFMXImage1: TSkinFMXImage;
    D_Edit: TSkinEditDefaultMaterial;
    pcColorStyle_Material: TSkinPageControlDefaultMaterial;
    btn_login: TSkinFMXButton;
    pages: TSkinFMXPageControl;
    ts01: TSkinFMXTabSheet;
    Layout1: TLayout;
    edt_pass: TSkinFMXEdit;
    ClearEditButton2: TClearEditButton;
    Layout4: TLayout;
    sw_hatirla: TSkinFMXCheckBox;
    SkinFMXLabel2: TSkinFMXLabel;
    edt_username: TSkinFMXEdit;
    ClearEditButton1: TClearEditButton;
    ts02: TSkinFMXTabSheet;
    Layout2: TLayout;
    edt_ip: TSkinFMXEdit;
    ClearEditButton8: TClearEditButton;
    edt_sql_user: TSkinFMXEdit;
    ClearEditButton4: TClearEditButton;
    edt_sql_pass: TSkinFMXEdit;
    ClearEditButton5: TClearEditButton;
    edt_db: TSkinFMXEdit;
    ClearEditButton3: TClearEditButton;
    procedure btn_loginClick(Sender: TObject);
  private
  procedure AfterConstruction;  override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frame_login: TFrame_login;

implementation
Uses qjson,Help.DB,Help.uni,Help.Str, uUIFunction,WaitingFrame,HintFrame,System.Rtti ,Frame.Menu
   //,RESTRequest4D
  //,Apk.Installer
 ;

{$R *.fmx}




procedure DoServerTest;
var
  ECode: Integer;
begin


  ShowWaitingFrame(Frame_login, 'Lütfen Bekleyin...');

  TThread.CreateAnonymousThread(
    procedure
    var
      cn: TUniConnection;
      ECode: Integer;
      EMessage: string;
      arg:TArray<string>;
    begin
      cn := TUniConnection.Create(nil);
      try
        ECode := 0;
        cn.ConnectString := DB.cn_DB.ConnectString; //'Provider Name=SQL Server;Provider=TDS;Initial Catalog=minim;Login Prompt=False';
        arg:=Frame_login.edt_ip.Text.Split([',']);
        cn.Server := arg[0];
        if Length(arg) =2 then
        cn.Port:=StrToIntDef(arg[1],0);
        cn.Username := Frame_login.edt_sql_user.Text;
        cn.Password := Frame_login.edt_sql_pass.Text;
        cn.Database:='OPAKERP';
       {$IFDEF DEBUG}
         // cn.ConnectString:='Provider Name=SQL Server;Provider=TDS;Data Source=88.225.223.51;Initial Catalog=rest;Port=723;User ID=sa;Password=das@1w2e3.;Login Prompt=False';
       {$ENDIF}

        try
          //DB.cn_DB.ConnectString := cn.ConnectString;
          cn.PerformConnect(False);
          ECode:=cn._sqlResults('SELECT U.ID FROM dbo.TBLKULLANICISUBESB S LEFT OUTER JOIN dbo.TBLKULLANICISIRKETSB U ON (S.KULLANICIID = U.ID) '+
                       'where U.KULLANICI_ADI='+QuotedStr(Frame_login.edt_username.Text)+' and U.SIFRE='+QuotedStr(Frame_login.edt_pass.Text)
                       +' and S.SIRKET='+QuotedStr(Frame_login.edt_db.Text),-2);
          if ECode<>-2 then
          begin
            if not cn._DoOpen('SELECT SERVER,DBNAME,DBUSER,DBPASSWORD FROM TBLSIRKET where AKTIF=''E'' and DBNAME='+QuotedStr(Frame_login.edt_db.Text),
            procedure (dt:TDataset)
            begin
             DB.cn_DB.Server:=dt.FieldByName('SERVER').AsString;
             DB.cn_DB.Database:=dt.FieldByName('DBNAME').AsString;
             DB.cn_DB.Username:=dt.FieldByName('DBUSER').AsString;
             DB.cn_DB.Password:=dt.FieldByName('DBPASSWORD').AsString;
            end ) then ECode:=-2;

            DB.cn_DB.PerformConnect(False);
            Config.Hatirla:=Frame_login.sw_hatirla.Prop.Checked;
            Config.Sirket:=Frame_login.edt_db.Text;
            Config.UserID:=ECode;
            if Config.Hatirla then
            begin
              Config.UserName:=Frame_login.edt_username.Text;
              Config.UserPass:=Frame_login.edt_pass.Text;
            end else
            begin
              Config.UserName:='';
              Config.UserPass:='';
            end;
            Config.Save;

          end;
          ECode:=0;

        except

          on E: EUniError do
          begin
            ECode := e.ErrorCode;
            if ECode = 0 then
              Dec(ECode);
            raise;
          end
          else

            raise;
        end;

      finally
        cn.Close;
        cn.Free;

        TThread.Queue(nil,
          procedure()
          begin

           if ECode <> 0 then Frame_login.pages.Prop.ActivePageIndex:=1;
           //else Frame_login.pages.Prop.ActivePageIndex:=0;

            case ECode of
             -2:begin HintFrame.ShowHintFrame(Frame_login, 'Kullanýcý Adý veya Þifreniz Yanlýþtýr.'); HideWaitingFrame; end;
             -1:begin HintFrame.ShowHintFrame(Frame_login, 'Server Baðlantýnýzý Kontrol Ediniz..'); HideWaitingFrame; end;
              18456:begin HintFrame.ShowHintFrame(Frame_login, 'Lütfen SQL Kullanýcý adý ve þifrenizi kontrol ediniz.'); HideWaitingFrame; end;
              4060:begin HintFrame.ShowHintFrame(Frame_login, 'Database bulunamadý lütfen yöneticinize baþvurun'); HideWaitingFrame; end;
              0: begin HideWaitingFrame; ShowFrame(TFrame(FMenu), TFMenu, Application.MainForm , nil, nil, nil,Application, True, True, ufsefNone); end;
            end;
          end);
      end;

    end).Start;

end;

procedure TFrame_login.AfterConstruction;
begin
   inherited;


  edt_ip.Text := Config.ServerIP;
  edt_sql_user.Text := Config.ServerUser;
  edt_sql_pass.Text := Config.ServerPass;
  edt_db.Text := Config.Sirket;
  if Config.Hatirla then
  begin
    edt_username.Text:=Config.UserName;
    edt_pass.Text:=Config.UserPass;
    sw_hatirla.Prop.Checked := True;
  end;

end;

procedure TFrame_login.btn_loginClick(Sender: TObject);
begin
    if edt_ip.Text.IsEmpty or edt_sql_user.Text.IsEmpty or edt_sql_pass.Text.IsEmpty then
  begin
    DoMessage(Self, 'Eksik Bilgi', 'Lütfen Gerekli Bütün alanlarý doldurunuz.', TMsgDlgType.mtError);
     Frame_login.pages.Prop.ActivePageIndex:=1;
    Exit;
  end;

    if edt_username.Text.IsEmpty or edt_pass.Text.IsEmpty then
  begin
    DoMessage(Self, 'Eksik Bilgi', 'Lütfen Gerekli Bütün alanlarý doldurunuz.', TMsgDlgType.mtError);
     Frame_login.pages.Prop.ActivePageIndex:=0;
    Exit;
  end;

  DoServerTest;

end;

end.
