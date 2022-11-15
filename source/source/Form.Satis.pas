unit Form.Satis;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  MobilePermissions.Model.Signature, MobilePermissions.Model.Dangerous,
  MobilePermissions.Model.Standard, MobilePermissions.Component;

type
  TF_Satis = class(TForm)
    MobilePermissions1: TMobilePermissions;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Satis: TF_Satis;

implementation
  uses  uUIFunction,System.UIConsts, uGraphicCommon,System.IOUtils,
 FMX.VirtualKeyboard,FMX.DialogService,Frame.Login;
{$R *.fmx}

procedure TF_Satis.FormShow(Sender: TObject);
begin
  with MobilePermissions1 do
  begin
      Dangerous.AccessCoarseLocation := True;
      Dangerous.Camera               := True;
      Dangerous.ReadExternalStorage  := True;
      Dangerous.WriteExternalStorage := True;

    Signature.RequestInstallPackages:=true;

      Standard.AccessLocationExtra:=True;
      Standard.AccessNetworkState:=True;
      Standard.Internet:=True;

  end;
  MobilePermissions1.Apply;



  ShowFrame(TFrame(Frame_login), TFrame_login, Self, nil, nil, nil, Application, True, True, ufsefNone);
end;

end.
