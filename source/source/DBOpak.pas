unit DBOpak;

interface

uses
  System.SysUtils, System.Classes, uGraphicCommon, uUrlPicture,
  uDownloadPictureManager, UniProvider, SQLServerUniProvider, Data.DB, DBAccess,
  Uni, uDrawPicture, uSkinImageList,System.Rtti,Generics.Collections,
  FMX.Platform, System.UITypes, FMX.Controls,FMX.Types,MemData,FMX.PhoneDialer,
  uSkinMaterial, uSkinButtonType
  ///,FMX.TMSFNCMaps,FMX.TMSFNCGoogleMaps
  ;

 const
  cFirma='Mikotek';
  cAppURL='http://88.247.42.50:8080/bin/OpakSatis.apk';
  cAppName='MSS';
  cAppVersiyon='1.1.0';

type

   TYetki = record
     CariGor:Byte;
     YetkiliEkle:Boolean;
     YetkiliSil:Boolean;
     YetkiliDuzenle:Boolean;
     NotEkle:Boolean;
     NotSil:Boolean;
     NotDuzenle:Boolean;
   procedure LoadStr(const s:string);
  end;

  TConfig = class
  strict private
    FServerIP: string;
    FServerPass: string;
    FServerUser: string;
    FSirket: string;
    FUserName: string;
    FUserPass: string;
    FUserID: Integer;
    FHatirla: Boolean;
    FDonem: string;
    FYetki: TYetki;


    public
     procedure Save;
     procedure Load;
     property UserID:Integer read FUserID write FUserID;
     property Yetki:TYetki read FYetki;

    published
     property Hatirla:Boolean read FHatirla write FHatirla;
     property ServerIP:string read FServerIP write FServerIP;
     property ServerUser:string read FServerUser write FServerUser;
     property ServerPass:string read FServerPass write FServerPass;
     property Sirket:string read FSirket write FSirket;
     property Donem:string read FDonem write FDonem;
     property UserName:string read FUserName write FUserName;
     property UserPass:string read FUserPass write FUserPass;


  end;

  TDB = class(TDataModule)
    cn_db: TUniConnection;
    SQLServerUniProvider1: TSQLServerUniProvider;
    PictureManager1: TDownloadPictureManager;
    SkinTheme: TSkinTheme;
    SkinImageList1: TSkinImageList;
    img_white: TSkinImageList;
    img_Color: TSkinImageList;
    img_Color1: TSkinImageList;
    update: TUniSQL;
    btn_konum_Material: TSkinButtonDefaultMaterial;
    procedure cn_dbConnectionLost(Sender: TObject; Component: TComponent;
      ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
    procedure DataModuleCreate(Sender: TObject);
  private

    function VGet(const Index: Integer): Variant;
    procedure VSet(const Index: Integer; const Value: Variant);
    { Private declarations }
  public
    FPhoneDialerService: IFMXPhoneDialerService;

    { Public declarations }
    procedure MakeCallPhone(s: string);
    //property AppURL:Variant Index 0 read VGet write VSet;
  end;


    function Cur2Str(const AValue: Double): string;


   procedure DoMessage(const AParant:TFmxObject;AMsg1,AMsg2:String;
   const AMsgType:TMsgDlgType =TMsgDlgType.mtInformation;
   const ABtnCaption:string='Tamam'; //const OnEvent:TNotifyEvent=nil;
   AProc:TProc<TObject,Boolean,string,string>=nil;const EdtCount:Integer=0);

var
  DB: TDB;
  Config:TConfig;
  FolderApp:string;
  FormatEN:TFormatSettings;

implementation
  uses sdk,System.IOUtils,FMX.Forms,FMX.DialogService,
  qjson,HintFrame,WaitingFrame,Help.DB,Help.uni, uUIFunction,MessageBoxFrame;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}
function Cur2Str(const AValue: Double): string;
begin
  Result := CurrToStrF(AValue, ffCurrency, 2, FormatSettings);
end;

  procedure DoMessage(const AParant:TFmxObject;AMsg1,AMsg2:String;
 const AMsgType:TMsgDlgType =TMsgDlgType.mtInformation;
 const ABtnCaption:string='Tamam'; //const OnEvent:TNotifyEvent=nil;
 AProc:TProc<TObject,Boolean,string,string>=nil;const EdtCount:Integer=0);
const
 AMgTitle : array [0..4] of string =('Uyarý', 'Hata', 'Bilgilendirme', 'Onaylama', 'Özel');
begin

     ShowMessageBoxFrame(AParant,AMsg1,AMsg2,AMsgType, ABtnCaption.Split([',']),
                            nil,nil,Translate(AMgTitle[Integer(AMsgType)]),['cancel','ok'],nil,EdtCount,nil,
                              procedure(Sender:TObject;
                                        AModalResult:String;
                                        AModalResultName:String;
                                        AInputEditText1:String;
                                        AInputEditText2:String)
                             begin
                                if Assigned(AProc) then
                                 AProc(Sender,SameText(AModalResultName,'ok'),AInputEditText1,AInputEditText2)
                                end
                              );
end;



procedure TDB.cn_dbConnectionLost(Sender: TObject; Component: TComponent;
  ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
begin
RetryMode := rmReconnectExecute;
 (*
   if Application.MessageBox('Veri tabaný baðlantýsý kesildi. Tekrar baðlanýlsýn mý?','Baðlantý Kesildi',MB_ICONINFORMATION + MB_YESNO) = IDYES
      RetryMode := rmReconnectExecute  // - > TRetryMode = (rmRaise, rmReconnect, rmReconnectExecute);
  else
    SafetyTerminate(Application.MainForm.Handle);
    *)
end;


{ TConfig }

procedure TConfig.Load;
var
  json: TQJson;

begin

 if not FileExists(FolderApp + 'setting.json') then  exit;
 json := TQJson.Create;
  try
    json.LoadFromFile(FolderApp + 'setting.json');
    json.ToRtti(Config, True);


  finally
    json.Free;
  end;


end;

procedure TConfig.Save;
var
  json: TQJson;
  s:string;
begin
  json := TQJson.Create;
  try
    Self.ServerIP:=DB.cn_db.Server;
    Self.ServerUser:=DB.cn_db.Username;
    Self.ServerPass:=DB.cn_db.Password;
    json.FromRtti(Config);
    s:=json.AsJson;
    json.SaveToFile(FolderApp + 'setting.json');
   finally
    json.Free;
  end;

end;



procedure Init;
 begin
   FormatEN:=TFormatSettings.Create('en-US');
 {$IF defined(MSWINDOWS)}
    FolderApp := TPath.GetHomePath + TPath.DirectorySeparatorChar + 'mikotek' + TPath.DirectorySeparatorChar;
{$ELSEIF defined(ANDROID)}
    FolderApp := TPath.GetHomePath + TPath.DirectorySeparatorChar;
{$ELSEIF defined(IOS)}
    FolderApp := TPath.GetDocumentsPath + TPath.DirectorySeparatorChar;
{$ENDIF}

  ForceDirectories(FolderApp);

  Config:=TConfig.Create;

  Config.Load;

  //qjson.JSONFormatSettings := TFormatSettings.Create('en-US');

 end;

procedure TDB.DataModuleCreate(Sender: TObject);
begin
 TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, FPhoneDialerService);


end;

procedure TDB.MakeCallPhone(s: string);
begin
  if FPhoneDialerService <> nil then
  begin
    s:=Str2CharSet(s,['0'..'9']);
    if s <> '' then
    begin
     FPhoneDialerService.Call(s)
    end
  end
  else TDialogService.ShowMessage('PhoneDialer service not supported'+sLineBreak+s);
end;

function TDB.VGet(const Index: Integer): Variant;
begin
  case Index of
   0:Result:='http://88.247.42.50:8080/bin/OpakSatis.apk';
   1:Result:='Mikotek';
  end;
end;

procedure TDB.VSet(const Index: Integer; const Value: Variant);
begin

end;

{ TYetki }

procedure TYetki.LoadStr(const s: string);
 procedure StrToBool1(c:Char; var BEkle,BDuzenle,BSil:Boolean);
 var
  TempInt:Integer;
 begin
   TempInt:=StrToIntDef(c,0);
   BEkle    :=TempInt>0;
   BDuzenle :=TempInt>1;
   BSil :=TempInt>2;
 end;
begin
  if s.Length<>3 then
  begin
    Self.CariGor:=0;
    Self.YetkiliEkle:=False;
    Self.YetkiliSil:=False;
    Self.NotEkle:=False;
    Self.NotSil:=False;
  end
  else
  begin
   Self.CariGor:=StrToIntDef(s.Chars[0],0);
   StrToBool1(s.Chars[1],YetkiliEkle,YetkiliDuzenle,YetkiliSil);
   StrToBool1(s.Chars[2],NotEkle,NotDuzenle,NotSil);

  end;
  //EMessage:='000';
end;

initialization
  init;

finalization

end.
