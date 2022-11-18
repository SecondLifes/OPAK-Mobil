unit Frame.Cari;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Frame.Base, uSkinLabelType, uSkinFireMonkeyLabel, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinFireMonkeyControl, uSkinCalloutRectType,
  uSkinPageControlType, uSkinFireMonkeyPageControl, uSkinButtonType,
  uSkinNotifyNumberIconType, uSkinFireMonkeyNotifyNumberIcon, uDrawPicture,
  uSkinImageList, FMX.Edit, FMX.Controls.Presentation, uSkinFireMonkeyEdit,
  DBOpak,OMR.Cari, uSkinFireMonkeyButton, uSkinScrollControlType,
  uSkinScrollBoxType, uSkinFireMonkeyScrollBox, FMX.ComboEdit,
  uSkinFireMonkeyComboEdit, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  uSkinFireMonkeyMemo, uSkinMaterial, uSkinEditType, uSkinComboEditType,
  uSkinMemoType,uTimerTaskEvent, uDrawCanvas, uSkinItems, uSkinCustomListType,
  uSkinVirtualListType, uSkinListBoxType, uSkinFireMonkeyListBox,
  uSkinItemDesignerPanelType, uSkinFireMonkeyItemDesignerPanel
  ;

type
  TFForm_Cari = class(TFBase)
    imglistTabIcon: TSkinImageList;
    pcMain: TSkinFMXPageControl;
    nniTalkCount: TSkinFMXNotifyNumberIcon;
    ts02Iletisim: TSkinFMXTabSheet;
    ts03Talk: TSkinFMXTabSheet;
    ts04ShopCart: TSkinFMXTabSheet;
    ts09Konum: TSkinFMXTabSheet;
    ts01Home: TSkinFMXTabSheet;
    SkinFMXScrollBox1: TSkinFMXScrollBox;
    edt_Unvani: TSkinFMXEdit;
    ClearEditButton1: TClearEditButton;
    edt_Adi: TSkinFMXEdit;
    ClearEditButton2: TClearEditButton;
    edt_soyad: TSkinFMXEdit;
    ClearEditButton3: TClearEditButton;
    edt_tc: TSkinFMXEdit;
    ClearEditButton4: TClearEditButton;
    edt_ilce: TSkinFMXEdit;
    ClearEditButton5: TClearEditButton;
    btnReturn: TSkinFMXButton;
    edt_vergiDaire: TSkinFMXEdit;
    ClearEditButton9: TClearEditButton;
    edt_vergino: TSkinFMXEdit;
    ClearEditButton10: TClearEditButton;
    edt_adres: TSkinFMXMemo;
    D_Edit: TSkinEditDefaultMaterial;
    edt_sehir: TSkinFMXComboEdit;
    SkinFMXPanel1: TSkinFMXPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    lbl_cariid: TSkinFMXLabel;
    lbl_cari_kod: TSkinFMXLabel;
    btn_kayet: TSkinFMXButton;
    lbl_borc: TSkinFMXLabel;
    lbl_alacak: TSkinFMXLabel;
    lbl_bakiye: TSkinFMXLabel;
    list_iletisim: TSkinFMXListBox;
    desig_iletisim: TSkinFMXItemDesignerPanel;
    lbl_iletisim_grv: TSkinFMXLabel;
    lbl_iletisim_adi: TSkinFMXLabel;
    SkinFMXLabel3: TSkinFMXLabel;
    SkinFMXLabel4: TSkinFMXLabel;
    lbl_iletisim_tel: TSkinFMXLabel;
    lbl_iletisim_cep: TSkinFMXLabel;
    idpItemPanDrag: TSkinFMXItemDesignerPanel;
    btnCall: TSkinFMXButton;
    btnDel: TSkinFMXButton;
    btn_new_iletisim: TSkinFMXButton;
    btn_edit: TSkinFMXButton;
    procedure btnReturnClick(Sender: TObject);
    procedure btn_kayetClick(Sender: TObject);
    procedure lbl_iletisim_telClick(Sender: TObject);
    procedure pcMainChanging(Sender: TObject; NewIndex: Integer;
      var AllowChange: Boolean);
    procedure btn_new_iletisimClick(Sender: TObject);
  private

    procedure LoadCari(const ACariID:Cardinal);
    procedure SaveCari;
    procedure BackFrame;
    procedure Clear;
    { Private declarations }
  public
      FCari:TCari;
      procedure AfterConstruction; override;
      destructor Destroy; override;


    { Public declarations }

  end;

  var
   FForm_Cari:TFForm_Cari;

 procedure FormCari(const ACariID:Integer);

implementation
uses uUIFunction,HintFrame,WaitingFrame,Frame.iletisim,Genel;

{$R *.fmx}

  procedure FormCari(const ACariID:Integer);
  begin
    ShowFrame(TFrame(FForm_Cari),TFForm_Cari,Application.MainForm,nil,nil,nil,Application);
    FForm_Cari.LoadCari(ACariID);
  end;


{ TF_Cari }

procedure TFForm_Cari.AfterConstruction;
begin
  inherited AfterConstruction;
  pcMain.Prop.ActivePageIndex:=0;
  iletisimListe:=TIletisimListe.create(list_iletisim.Prop);
  iletisimListe.Clear(true);
  FCari:=TCari.Create(0);
end;

procedure TFForm_Cari.BackFrame;
begin

     HideFrame(Self,hfcttBeforeReturnFrame);
     //ReturnFrame();
     Clear;
end;

procedure TFForm_Cari.btnReturnClick(Sender: TObject);
begin
 BackFrame;
end;

procedure TFForm_Cari.btn_kayetClick(Sender: TObject);
begin
   SaveCari;

end;

procedure TFForm_Cari.btn_new_iletisimClick(Sender: TObject);
begin
 ViewIletisim(nil);

end;

procedure TFForm_Cari.Clear;
begin
  FCari.Clear;

end;

destructor TFForm_Cari.Destroy;
begin
  FCari.Free;
  inherited Destroy;
end;

procedure TFForm_Cari.lbl_iletisim_telClick(Sender: TObject);
var
itm:TSkinItem;
 tel,cep:string;
begin
 itm:=list_iletisim.Prop.InteractiveItem;

 if itm=nil then exit;

 tel:=itm.Detail1;
 cep:=itm.Detail2;
 if tel.IsEmpty and cep.IsEmpty then exit;
 if not tel.IsEmpty and cep.IsEmpty then cep:=tel
 else if not cep.IsEmpty and tel.IsEmpty then tel:=cep;

 case TFmxObject(Sender).Tag of
    1:DB.MakeCallPhone(tel);
    2,3:DB.MakeCallPhone(cep);
    4:begin
              DoMessage(Self,'Ýletiþim Bilgisi silinsin mi ?',
              itm.Caption+sLineBreak+itm.Detail+sLineBreak+tel+sLineBreak+cep,
                                  TMsgDlgType.mtInformation,
                                  'Hayýr'+','+'Evet',
                                  procedure ( obj: TObject; AIsOk:boolean; edt1,edt2:string)
                                  begin
                                   if AISok then
                                   begin
                                    FCari.IletisimSil(Itm.tag);
                                     list_iletisim.Prop.BeginUpdate;
                                     list_iletisim.Prop.Items.Delete(itm.Index);
                                     list_iletisim.Prop.EndUpdate;

                                   end;

                                  end
                                  );
      end;
    5:ViewIletisim(itm as TIletisim);
 end;
  list_iletisim.Prop.StopItemPanDrag;
end;

procedure TFForm_Cari.LoadCari(const ACariID: Cardinal);
var
 itm:TRealSkinItem;
begin
 FCari.LoadDB(ACariID);
 lbl_cariid.Text:=FCari.CariID.ToString;
 lbl_cari_kod.Text:=FCari.CariKodu;
 edt_Unvani.Text:=FCari.Unvani;
 edt_Adi.Text:=FCari.Adi;
 edt_soyad.Text:=FCari.SoyAdi;
 edt_tc.Text:=FCari.TCNo;
 edt_vergiDaire.Text:=FCari.VergiDairesi;
 edt_vergino.Text:=FCari.VergiNo;
 edt_sehir.Text:=FCari.IL;
 edt_ilce.Text:=FCari.ILCE;
 edt_adres.Lines.Text:=FCari.Adres;
 lbl_alacak.Text:=Cur2Str(FCari.Alacak);
 lbl_borc.Text:=Cur2Str(FCari.Borc);
 lbl_bakiye.Text:=Cur2Str(FCari.Bakiye);

 iletisimListe.LoadDB(ACariID.ToString,True);
 exit;
 if FCari.Bakiye>0 then
 lbl_bakiye.SelfOwnMaterialToDefault.DrawCaptionParam.DrawFont.FontColor.Color:=DB.SkinTheme.SkinThemeColor2
 else
 lbl_bakiye.SelfOwnMaterialToDefault.DrawCaptionParam.DrawFont.FontColor.Color:=DB.SkinTheme.SkinThemeColor;
end;

procedure TFForm_Cari.pcMainChanging(Sender: TObject; NewIndex: Integer;
  var AllowChange: Boolean);
begin
btn_kayet.Visible:=NewIndex=0;
btn_new_iletisim.Visible:=NewIndex=1;
end;

procedure TFForm_Cari.SaveCari;
begin
 FCari.Unvani:=edt_Unvani.Text;
 FCari.Adi:=edt_Adi.Text;
 FCari.SoyAdi:=edt_soyad.Text;
 FCari.TCNo:=edt_tc.Text;
 FCari.VergiDairesi:=edt_vergiDaire.Text;
 FCari.VergiNo:=edt_vergino.Text;
 FCari.IL:=edt_sehir.Text;
 FCari.ILCE:=edt_ilce.Text;
 FCari.Adres:=edt_adres.Lines.Text;
 WaitingFrame.ShowWaitingFrame(Self,'Cari Kayýt...');
 try
 if FCari.SaveDB then
    HintFrame.ShowHintFrame(Self,'Kayýt Baþarýlý...')
  else
    HintFrame.ShowHintFrame(Self,'Hata...');
 finally
   HideWaitingFrame;
 end;
end;

end.
