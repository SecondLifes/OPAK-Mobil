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
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }

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
 FMX.VirtualKeyboard,FMX.DialogService,Frame.Login,DBOpak,Form.Cariler,Frame.Cari;
{$R *.fmx}

procedure TF_Satis.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
 FService : IFMXVirtualKeyboardService;
begin
 if Key = vkHardwareBack then
 begin
   TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
   if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
   begin
     // Back button pressed, keyboard visible, so do nothing...
   end else
   begin
    Key:=0;
    //TDialogService.ShowMessage(CurrentFrameHistroy.ToFrame.Name+sLineBreak+CurrentFrameHistroy.LastToFrame.Name);
         if uUIFunction.CurrentFrame = FForm_Cari then  FForm_Cari.BackFrame
    else if uUIFunction.CurrentFrame = FCariler then  FCariler.BackFrame
    else    DoMessage(Self,'Programdan Çýkmak Ýstiyor Musunuz.?','PDMobil',
                                  TMsgDlgType.mtInformation,
                                  'Hayýr'+','+'Evet',
                                  procedure ( obj: TObject; AIsOk:boolean; edt1,edt2:string)
                                  begin
                                   if AISok then Application.Terminate;
                                  end
                                  );


    end;
 end;

end;

procedure TF_Satis.FormShow(Sender: TObject);
begin




  ShowFrame(TFrame(Frame_login), TFrame_login, Self, nil, nil, nil, Application, True, True, ufsefNone);
end;



end.
