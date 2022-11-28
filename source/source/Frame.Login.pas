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
  uSkinFireMonkeyButton, Data.DB, DBAccess, Uni,
  MobilePermissions.Model.Signature, MobilePermissions.Model.Dangerous,
  MobilePermissions.Model.Standard, MobilePermissions.Component,
  uSkinScrollBoxContentType, uSkinFireMonkeyScrollBoxContent,
  uSkinScrollControlType, uSkinScrollBoxType, uSkinFireMonkeyScrollBox;

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
    edt_donem: TSkinFMXEdit;
    ClearEditButton6: TClearEditButton;
    btn_guncelle: TSkinFMXButton;
    MobilePermissions1: TMobilePermissions;
    SkinFMXScrollBox1: TSkinFMXScrollBox;
    SkinFMXScrollBoxContent1: TSkinFMXScrollBoxContent;
    procedure btn_loginClick(Sender: TObject);
    procedure pagesChanging(Sender: TObject; NewIndex: Integer;
      var AllowChange: Boolean);
    procedure btn_guncelleClick(Sender: TObject);
  private
  procedure AfterConstruction;  override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frame_login: TFrame_login;

implementation
Uses qjson,Help.DB,Help.uni,Help.Str, uUIFunction,WaitingFrame,HintFrame,System.Rtti ,
Frame.Menu,FMX.DialogService,Form.Satis,Apk.Installer
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
          ECode:=-2;
          EMessage:='';
          cn._DoOpen('SELECT U.ID,U.mobilyetki FROM dbo.TBLKULLANICISUBESB S LEFT OUTER JOIN dbo.TBLKULLANICISIRKETSB U ON (S.KULLANICIID = U.ID) '+
                       'where U.KULLANICI_ADI='+QuotedStr(Frame_login.edt_username.Text)+' and U.SIFRE='+QuotedStr(Frame_login.edt_pass.Text)
                       +' and S.SIRKET='+QuotedStr(Frame_login.edt_db.Text),
                       procedure (dt:TDataset)
                       begin
                        ECode:=dt.recordcount;
                        EMessage:=dt._S['mobilyetki'];
                       end);
          if ECode<>-2 then
          begin

            DB.cn_DB.Port:=cn.Port;

            if not cn._DoOpen('SELECT SERVER,DBNAME,DBUSER,DBPASSWORD FROM TBLSIRKET where AKTIF=''E'' and DBNAME='+QuotedStr(Frame_login.edt_db.Text),
            procedure (dt:TDataset)
            begin

             //DB.cn_DB.Server:=dt.FieldByName('SERVER').AsString;
             DB.cn_DB.Server:=cn.Server;
             DB.cn_DB.Database:=dt.FieldByName('DBNAME').AsString;
             DB.cn_DB.Username:=dt.FieldByName('DBUSER').AsString;
             DB.cn_DB.Password:=dt.FieldByName('DBPASSWORD').AsString;

            end ) then ECode:=-2
            else begin
                if cn._sqlResultsCount('TBLSIRKETDONEMHAR','where SIRKET='+QuotedStr(DB.cn_DB.Database)+' and DONEM = '+Frame_login.edt_Donem.text)>0 then
                begin
                DB.cn_DB.PerformConnect(False);
                Config.Yetki.LoadStr(EMessage);
                Config.Hatirla:=Frame_login.sw_hatirla.Prop.Checked;
                Config.Sirket:=Frame_login.edt_db.Text;
                Config.UserID:=ECode;
                if Config.Hatirla then
                begin
                  Config.UserName:=Frame_login.edt_username.Text;
                  Config.UserPass:=Frame_login.edt_pass.Text;
                  Config.Donem:=Frame_login.edt_Donem.Text;
                end else
                begin
                  Config.UserName:='';
                  Config.UserPass:='';
                end;
                Config.Save;
                Config.UserName:=Frame_login.edt_username.Text;
                 ECode:=0;
                end else ECode:=-3;
            end;



          end;


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
             -3:begin HintFrame.ShowHintFrame(Frame_login, 'Þirket Donemi Bulunamadý.'); HideWaitingFrame; end;
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
  edt_Donem.Text:=Config.Donem;
  if Config.Hatirla then
  begin
    edt_username.Text:=Config.UserName;
    edt_pass.Text:=Config.UserPass;
    sw_hatirla.Prop.Checked := True;
  end;

  edt_ip.Text :='88.247.42.50,317';
  edt_sql_user.Text:='sa';
  edt_sql_pass.Text:='123456';
  edt_db.Text:='MÝKOTEK';

      with MobilePermissions1 do
      begin
          Dangerous.AccessCoarseLocation := True;
          Dangerous.Camera               := True;
          Dangerous.ReadExternalStorage  := True;
          Dangerous.WriteExternalStorage := True;
          Dangerous.CallPhone:=True;
          Dangerous.AccessFineLocation:=True;

          Signature.RequestInstallPackages:=true;


          Standard.AccessLocationExtra:=True;
          Standard.AccessNetworkState:=True;

          Standard.Internet:=True;
         MobilePermissions1.Apply;
      end;

end;

procedure TFrame_login.btn_guncelleClick(Sender: TObject);
begin

         APKInstaller(cAppURL,
        procedure (const EventID:byte; var v:TValue)
        begin
           case EventID of
            0 :ShowWaitingFrame('Ýndiriliyor...');
            1: if not v.AsBoolean then
                  DoMessage(Self,'Ýndirme iþlemi baþarýsýz'+sLineBreak+
                  'Lütfen Baðlantýnýzý kontrol edin','DAS TEKNOLOJÝ', TMsgDlgType.mtError);
            99:HideWaitingFrame;
           end;
        end
        );
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

procedure TFrame_login.pagesChanging(Sender: TObject; NewIndex: Integer;
  var AllowChange: Boolean);
begin
  AllowChange:=False;
end;

end.
