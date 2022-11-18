unit Frame.iletisim;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Frame.Base, uSkinLabelType, uSkinFireMonkeyLabel, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinFireMonkeyControl, uSkinCalloutRectType,
  uSkinButtonType, uSkinFireMonkeyButton, FMX.Edit, FMX.Controls.Presentation,
  uSkinFireMonkeyEdit, uSkinMaterial, uSkinMemoType, uSkinEditType,uSkinItems,DBOpak,Genel;

type
  TF_iletisim = class(TFBase)
    btnReturn: TSkinFMXButton;
    btn_kayet: TSkinFMXButton;
    edt_gorev: TSkinFMXEdit;
    ClearEditButton2: TClearEditButton;
    D_Edit: TSkinEditDefaultMaterial;
    edt_tel: TSkinFMXEdit;
    ClearEditButton1: TClearEditButton;
    edt_Adi: TSkinFMXEdit;
    ClearEditButton3: TClearEditButton;
    edt_cep: TSkinFMXEdit;
    ClearEditButton4: TClearEditButton;
    btn_login: TSkinFMXButton;
    procedure btn_kayetClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
  private
    { Private declarations }
    FItem:TIletisim;
    FID:Integer;
  public
    { Public declarations }
  end;

  procedure ViewIletisim(const AItem:TIletisim=nil);


implementation
uses uUIFunction,Frame.Cari;
var
  F_iletisim: TF_iletisim;

{$R *.fmx}

  procedure ViewIletisim(const AItem:TIletisim);
  begin

     ShowFrame(TFrame(F_iletisim),TF_iletisim,Application.MainForm,nil,nil,nil,Application);
     F_iletisim.FID:=0;

     if AItem<>nil then
     begin
       F_iletisim.FItem:=AItem;
       F_iletisim.FID:=AItem.ID.AsInteger;
       F_iletisim.edt_gorev.Text:=AItem.Gorevi.AsString;
       F_iletisim.edt_Adi.Text:=AItem.Adi.AsString;
       F_iletisim.edt_tel.Text:=AItem.Tel.AsString;
       F_iletisim.edt_cep.Text:=AItem.Cep.AsString;
     end;
  end;

procedure TF_iletisim.btnReturnClick(Sender: TObject);
begin

  ClearOnReturnFrameEvent(Self);

  HideFrame;//();
  ReturnFrame();

     //HideFrame(Self,hfcttBeforeReturnFrame);
     //ReturnFrame(FForm_Cari);

end;

procedure TF_iletisim.btn_kayetClick(Sender: TObject);
begin
   if FID<1 then
   FItem:=iletisimListe.AddNewItem;

     FItem.Gorevi:=F_iletisim.edt_gorev.Text;
     FItem.Adi:=F_iletisim.edt_Adi.Text;
     FItem.Tel:=F_iletisim.edt_tel.Text;
     FItem.Cep:=F_iletisim.edt_cep.Text;

   if FID>0 then
   begin
     FItem.Caption:=F_iletisim.edt_gorev.Text;
     FItem.Detail:=F_iletisim.edt_Adi.Text;
     FItem.Detail1:=F_iletisim.edt_tel.Text;
     FItem.Detail2:=F_iletisim.edt_cep.Text;

     DB.cn_db.ExecSQL(
     'UPDATE dbo.TBLCARITELEFONSB SET TELEFON = '+QuotedStr(F_iletisim.edt_tel.Text)+
     ',YETKILI = '+QuotedStr(F_iletisim.edt_Adi.Text)+
     ',GOREVI = '+QuotedStr(F_iletisim.edt_gorev.Text)+',CEPTEL = '+
     QuotedStr(F_iletisim.edt_cep.Text)+' where ID='+IntToStr(FID)
     );
   end
   else
   begin

     DB.cn_db.ExecSQL(
    format('INSERT INTO dbo.TBLCARITELEFONSB(CARIID,TELEFON,YETKILI,GOREVI,CEPTEL) VALUES (%d,%s,%s,%s,%s);',
    [0,F_iletisim.edt_tel.Text.QuotedString,
    F_iletisim.edt_Adi.Text.QuotedString,
    F_iletisim.edt_gorev.Text.QuotedString,
    F_iletisim.edt_cep.Text.QuotedString])
     );

   end;

  btnReturnClick(nil);

end;

end.
