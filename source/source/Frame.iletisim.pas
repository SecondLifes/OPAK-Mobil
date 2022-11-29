unit Frame.iletisim;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Frame.Base, uSkinLabelType, uSkinFireMonkeyLabel, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinFireMonkeyControl, uSkinCalloutRectType,
  uSkinButtonType, uSkinFireMonkeyButton, FMX.Edit, FMX.Controls.Presentation,
  uSkinFireMonkeyEdit, uSkinMaterial, uSkinMemoType, uSkinEditType,uSkinItems,DBOpak,Genel,
  FMX.ListBox, uSkinFireMonkeyComboBox, FMX.Layouts;

type
  TF_iletisim = class(TFBase)
    btnReturn: TSkinFMXButton;
    btn_kayet: TSkinFMXButton;
    D_Edit: TSkinEditDefaultMaterial;
    btn_login: TSkinFMXButton;
    SkinFMXPanel1_Material: TSkinPanelDefaultMaterial;
    pnl_3: TSkinFMXPanel;
    edt_cep: TSkinFMXEdit;
    ClearEditButton5: TClearEditButton;
    pnl_1: TSkinFMXPanel;
    edt_tel: TSkinFMXEdit;
    ClearEditButton6: TClearEditButton;
    pnl_2: TSkinFMXPanel;
    edt_Adi: TSkinFMXEdit;
    ClearEditButton7: TClearEditButton;
    pnl_4: TSkinFMXPanel;
    edt_gorev: TSkinFMXEdit;
    ClearEditButton8: TClearEditButton;
    Layout1: TLayout;
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



     if AItem<>nil then
     begin
       F_iletisim.FItem:=AItem;
       F_iletisim.FID:=AItem.ID.AsInteger;
       F_iletisim.edt_gorev.Text:=AItem.Gorevi.AsString;
       F_iletisim.edt_Adi.Text:=AItem.Adi.AsString;
       F_iletisim.edt_tel.Text:=AItem.Tel.AsString;
       F_iletisim.edt_cep.Text:=AItem.Cep.AsString;
     end
     else
     begin
       F_iletisim.FItem:=nil;
       F_iletisim.FID:=0;
       F_iletisim.edt_gorev.Text:='';
       F_iletisim.edt_Adi.Text:='';
       F_iletisim.edt_tel.Text:='';
       F_iletisim.edt_cep.Text:='';
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
iletisimListe.prop.BeginUpdate;
   if FID<1 then
   FItem:=iletisimListe.prop.Items.Add as TIletisim;//iletisimListe.AddNewItem;

    FItem.Gorevi:=F_iletisim.edt_gorev.Text;
    FItem.Adi:=F_iletisim.edt_Adi.Text;
    FItem.Tel:=F_iletisim.edt_tel.Text;
    FItem.Cep:=F_iletisim.edt_cep.Text;
    FItem.SaveDB;
  iletisimListe.prop.EndUpdate;
  btnReturnClick(nil);

end;

end.
