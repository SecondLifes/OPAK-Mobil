unit Form.Satis;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  MobilePermissions.Model.Signature, MobilePermissions.Model.Dangerous,
  MobilePermissions.Model.Standard, MobilePermissions.Component,FMX.Platform, FMX.PhoneDialer;

type
  TF_Satis = class(TForm)
    MobilePermissions1: TMobilePermissions;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
   FPhoneDialerService: IFMXPhoneDialerService;
    { Public declarations }
    procedure MakeCallPhone(s:string);
  end;

var
  F_Satis: TF_Satis;

implementation
  uses
  {$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
{$ENDIF}
  SDK,uUIFunction,System.UIConsts, uGraphicCommon,System.IOUtils,
 FMX.VirtualKeyboard,FMX.DialogService,Frame.Login;
{$R *.fmx}

procedure TF_Satis.FormCreate(Sender: TObject);
begin
 TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, FPhoneDialerService);
end;

procedure TF_Satis.FormShow(Sender: TObject);
begin




  ShowFrame(TFrame(Frame_login), TFrame_login, Self, nil, nil, nil, Application, True, True, ufsefNone);
end;

procedure TF_Satis.MakeCallPhone(s: string);
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


end.
