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
  uSkinItemDesignerPanelType, uSkinFireMonkeyItemDesignerPanel, System.Sensors,
  System.Sensors.Components, FMX.WebBrowser, Data.DB, MemDS, DBAccess, Uni
  ,uTimerTask, uSkinScrollBoxContentType, uSkinFireMonkeyScrollBoxContent,uUIFunction,FMX.VirtualKeyboard,
  FMX.ListBox, uSkinFireMonkeyComboBox, FMX.Maps,Generics.Collections,
  FMX.Layouts;

type
  TFForm_Cari = class(TFBase)//IFrameVirtualKeyboardEvent
    imglistTabIcon: TSkinImageList;
    pcMain: TSkinFMXPageControl;
    Msg_Count: TSkinFMXNotifyNumberIcon;
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
    btn_YetkilCall: TSkinFMXButton;
    btn_YetkiliDel: TSkinFMXButton;
    btn_new_iletisim: TSkinFMXButton;
    btn_yetkiliEdit: TSkinFMXButton;
    list_mesajlar: TSkinFMXListBox;
    list_msg_designer: TSkinFMXItemDesignerPanel;
    msg_tarih: TSkinFMXLabel;
    msg_conted: TSkinFMXLabel;
    list_msg_menu: TSkinFMXItemDesignerPanel;
    btn_not_sil: TSkinFMXButton;
    btn_not_edit: TSkinFMXButton;
    msg_user: TSkinFMXLabel;
    list_shop: TSkinFMXListBox;
    list_shop_designer: TSkinFMXItemDesignerPanel;
    shop_Kod: TSkinFMXLabel;
    shop_tarih: TSkinFMXLabel;
    Shop_urun: TSkinFMXLabel;
    SkinFMXPanel2: TSkinFMXPanel;
    shop_adet_fyt: TSkinFMXLabel;
    shop_fiyat: TSkinFMXLabel;
    TimerTaskEvent1: TTimerTaskEvent;
    tmr: TTimer;
    edt_tel: TSkinFMXEdit;
    ClearEditButton6: TClearEditButton;
    Contend: TSkinFMXScrollBoxContent;
    SkinFMXPanel1_Material: TSkinPanelDefaultMaterial;
    pnl_1: TSkinFMXPanel;
    pnl_2: TSkinFMXPanel;
    pnl_3: TSkinFMXPanel;
    pnl_4: TSkinFMXPanel;
    pnl_5: TSkinFMXPanel;
    pnl_6: TSkinFMXPanel;
    pnl_7: TSkinFMXPanel;
    pnl_8: TSkinFMXPanel;
    pnl_9: TSkinFMXPanel;
    pnl_10: TSkinFMXPanel;
    pnl_VirtualKeyboard: TSkinFMXPanel;
    btn_new_not: TSkinFMXButton;
    pnl_11: TSkinFMXPanel;
    edt_mail: TSkinFMXEdit;
    ClearEditButton7: TClearEditButton;
    pnl_12: TSkinFMXPanel;
    com_cari_tipi: TSkinFMXComboBox;
    SkinFMXButton1: TSkinFMXButton;
    procedure btnReturnClick(Sender: TObject);
    procedure btn_kayetClick(Sender: TObject);
    procedure lbl_iletisim_telClick(Sender: TObject);
    procedure pcMainChanging(Sender: TObject; NewIndex: Integer;
      var AllowChange: Boolean);
    procedure btn_new_iletisimClick(Sender: TObject);
    procedure btn_not_silClick(Sender: TObject);
    procedure btn_not_editClick(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
    procedure pnl_4DblClick(Sender: TObject);
    procedure SkinFMXButton1Click(Sender: TObject);
  private
    procedure LoadCari(const ACariID:Cardinal);
    procedure SaveCari;

    procedure Clear;
    procedure MesajLoad;
    procedure MesajSave;
    procedure ClearALL;
    procedure ShopListLoad;
    { Private declarations }
    procedure DoVirtualKeyboardShow(KeyboardVisible: Boolean; const Bounds: TRect);
    procedure DoVirtualKeyboardHide(KeyboardVisible: Boolean; const Bounds: TRect);
  public

      FCari:TCari;
      FGeocoder: TGeocoder;
      procedure BackFrame;

      procedure AfterConstruction; override;
      //constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;


    { Public declarations }

  end;

  var
   FForm_Cari:TFForm_Cari;

 procedure FormCari(const ACariID:Integer);

implementation
uses Form.Satis,Form.Cariler,HintFrame,WaitingFrame,MessageBoxFrame,
Frame.iletisim,Genel,Help.uni,Help.DB,System.Threading,FMX.DialogService,Frame.Map,OpenViewUrl;

{$R *.fmx}

  procedure FormCari(const ACariID:Integer);
  begin

    ShowFrame(TFrame(FForm_Cari),TFForm_Cari,Application.MainForm,nil,nil,nil,Application);
    HideVirtualKeyboard;
    WaitingFrame.ShowWaitingFrame( 'Yükleniyor...');
    FForm_Cari.tmr.Tag:=ACariID;
    FForm_Cari.tmr.Enabled:=True;


  end;


{ TF_Cari }

procedure TFForm_Cari.AfterConstruction;
begin
  inherited AfterConstruction;

  Self.pnl_VirtualKeyboard.Height:=0;

  btn_new_iletisim.Visible:=DBOpak.Config.Yetki.YetkiliEkle;
  btn_yetkiliEdit.Visible:=DBOpak.Config.Yetki.YetkiliDuzenle;
  btn_YetkiliDel.Visible:=DBOpak.Config.Yetki.YetkiliSil;

  btn_not_edit.Visible:=DBOpak.Config.Yetki.NotDuzenle;
  btn_not_sil.Visible:=DBOpak.Config.Yetki.NotSil;

  btn_new_iletisim.Visible:=False;
  btn_new_not.Visible:=False;

  pcMain.Prop.ActivePageIndex:=0;

  iletisimListe:=TIletisimListe.Create(list_iletisim.Prop);
  iletisimListe.ClearNew(false);
  FCari:=TCari.Create(0);
end;

procedure TFForm_Cari.BackFrame;
begin
     HideFrame(Self,hfcttBeforeReturnFrame);
     ReturnFrame();///FCariler
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
var
  FItem:TIletisim;
begin
   ViewIletisim(nil);
end;

procedure TFForm_Cari.Clear;
begin
  FCari.Clear;

end;



procedure TFForm_Cari.ClearALL;
begin
  list_shop.Prop.BeginUpdate;
  list_shop.Prop.Items.Clear();
  list_shop.Prop.EndUpdate;
  list_mesajlar.Prop.BeginUpdate;
  list_mesajlar.Prop.Items.Clear();
  list_mesajlar.Prop.EndUpdate;
end;

destructor TFForm_Cari.Destroy;
begin

  FCari.Free;
  inherited Destroy;
end;

procedure TFForm_Cari.DoVirtualKeyboardHide(KeyboardVisible: Boolean;
  const Bounds: TRect);
begin
Contend.Height:=Contend.Height-Self.pnl_VirtualKeyboard.Height;
 Self.pnl_VirtualKeyboard.Height:=0;
end;

procedure TFForm_Cari.DoVirtualKeyboardShow(KeyboardVisible: Boolean; const Bounds: TRect);
var
  AFixTop:Double;
begin
  (*
  if Bounds.Height-GetGlobalVirtualKeyboardFixer.VirtualKeyboardHideHeight>Self.pnl_VirtualKeyboard.Height then
  begin
    Self.pnl_VirtualKeyboard.Height:=RectHeight(Bounds)-GetGlobalVirtualKeyboardFixer.VirtualKeyboardHideHeight;
    AFixTop:=Self.pnlLogin.Top+Self.edtPass.Top+Self.edtPass.Height-Self.pnl_VirtualKeyboard.Top;
    Self.sbClient.VertScrollBar.Properties.Position:=AFixTop;
  end;
*)

 //{$IFDEF ANDROID}
   if Bounds.Height-GetGlobalVirtualKeyboardFixer.VirtualKeyboardHideHeight>Self.pnl_VirtualKeyboard.Height then
      Self.pnl_VirtualKeyboard.Height:=RectHeight(Bounds)-GetGlobalVirtualKeyboardFixer.VirtualKeyboardHideHeight;
    Contend.Height:=Contend.Height+ Self.pnl_VirtualKeyboard.Height;
 // {$ENDIF};
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
              DoMessage(Self,'İletişim Bilgisi silinsin mi ?',
              itm.Caption+sLineBreak+itm.Detail+sLineBreak+tel+sLineBreak+cep,
                                  TMsgDlgType.mtInformation,
                                  'Hayır'+','+'Evet',
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

 //ClearALL;
 pcMain.Prop.ActivePageIndex:=2;
 FCari.LoadDB(ACariID);

 lbl_cariid.Text:=FCari.CariID.ToString;
 lbl_cari_kod.Text:=FCari.CariKodu;
 com_cari_tipi.Text:=FCari.CariTipi;
 edt_Unvani.Text:=FCari.Unvani;
 edt_Adi.Text:=FCari.Adi;
 edt_soyad.Text:=FCari.SoyAdi;
 edt_tel.Text:= FCari.Telefon;
 edt_tc.Text:=FCari.TCNo;
 edt_mail.Text:=FCari.EMail;
 edt_vergiDaire.Text:=FCari.VergiDairesi;
 edt_vergino.Text:=FCari.VergiNo;
 edt_sehir.Text:=FCari.IL;
 edt_ilce.Text:=FCari.ILCE;
 edt_adres.Lines.Text:=FCari.Adres;
 lbl_alacak.Text:=Cur2Str(FCari.Alacak);
 lbl_borc.Text:=Cur2Str(FCari.Borc);
 lbl_bakiye.Text:=Cur2Str(FCari.Bakiye);

 iletisimListe.LoadDB(ACariID.ToString,True);
 MesajLoad;
 ShopListLoad;




     TThread.CreateAnonymousThread(
    procedure()
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure()
        begin
             //ShowMessage('');
             FCariler.Tag:=0;

         end);

    end).Start;

 exit;
 if FCari.Bakiye>0 then
 lbl_bakiye.SelfOwnMaterialToDefault.DrawCaptionParam.DrawFont.FontColor.Color:=DB.SkinTheme.SkinThemeColor2
 else
 lbl_bakiye.SelfOwnMaterialToDefault.DrawCaptionParam.DrawFont.FontColor.Color:=DB.SkinTheme.SkinThemeColor;
end;

procedure TFForm_Cari.MesajLoad;
var
 s:string;
 arg:TArray<string>;
 itm:TRealSkinItem;
begin
     list_mesajlar.Prop.BeginUpdate;
     list_mesajlar.Prop.Items.Clear();
     if not FCari.Aciklama.text.IsEmpty then
      begin

         for s in FCari.Aciklama do
          begin
            arg:=s.Split(['|']);
             itm:=list_mesajlar.Prop.Items.Add;

                 if Length(arg)>1 then
                 begin
                   itm.Caption:=arg[0];
                   itm.Detail:=arg[1];
                   itm.Detail1:=arg[2];
                 end else
                 begin
                   itm.Caption:=DateToStr(Now);
                   itm.Detail:='Eski Kayıt';
                   itm.Detail1:=s;
                 end;

          end;

      end;
     Msg_Count.Prop.Number:=list_mesajlar.Prop.Items.Count;
   list_mesajlar.Prop.EndUpdate;
end;

procedure TFForm_Cari.MesajSave;
 var
  i:Integer;
  itm:TRealSkinItem;
begin
  FCari.Aciklama.BeginUpdate;
  FCari.Aciklama.Clear;
  for i := 0 to list_mesajlar.Prop.Items.Count -1 do
    begin
     itm:=list_mesajlar.Prop.Items[i];
     FCari.Aciklama.Add(itm.Caption.Trim+'|'+itm.Detail.Trim+'|'+itm.Detail1.Trim);
    end;
  FCari.Aciklama.EndUpdate;
end;



procedure TFForm_Cari.pcMainChanging(Sender: TObject; NewIndex: Integer;
  var AllowChange: Boolean);
begin
btn_kayet.Visible:=(NewIndex in [0,2,4]);

btn_new_iletisim.Visible:=((NewIndex=1) and (Config.Yetki.YetkiliEkle));
btn_new_not.Visible:=((NewIndex=2) and (Config.Yetki.NotEkle));

 if NewIndex = 4 then
  begin
   AllowChange:=False;
   ShowMap(FCari).AddOrSetCari(True);

  end;

end;

procedure TFForm_Cari.pnl_4DblClick(Sender: TObject);
begin
 DB.MakeCallPhone(FCari.Telefon);
end;

procedure TFForm_Cari.SaveCari;
var
 i:Integer;
begin
 WaitingFrame.ShowWaitingFrame(Self,'Cari Kayıt...');
 FCari.CariTipi:=com_cari_tipi.Text;
 FCari.Unvani:=edt_Unvani.Text;
 FCari.Adi:=edt_Adi.Text;
 FCari.SoyAdi:=edt_soyad.Text;
 FCari.Telefon:=edt_tel.Text;
 FCari.EMail:=edt_mail.Text;
 FCari.TCNo:=edt_tc.Text;
 FCari.VergiDairesi:=edt_vergiDaire.Text;
 FCari.VergiNo:=edt_vergino.Text;
 FCari.IL:=edt_sehir.Text;
 FCari.ILCE:=edt_ilce.Text;
 FCari.Adres:=edt_adres.Lines.Text;
 MesajSave;

 try
  i:=FCari.CariID;
 if FCari.SaveDB then
    HintFrame.ShowHintFrame(Self,'Kayıt Başarılı...')
  else
    HintFrame.ShowHintFrame(Self,'Hata...');
    if i<1 then
    begin
      lbl_cariid.Text:=FCari.CariID.ToString;
      lbl_cari_kod.Text:=FCari.CariKodu;
    end;
 finally
   HideWaitingFrame;
 end;
end;

procedure TFForm_Cari.ShopListLoad;
var
 itm:TSkinItem;
begin
 list_shop.Prop.BeginUpdate;
 list_shop.Prop.Items.Clear();
 DB.cn_db._DoEof('SELECT TARIH,VADE_TARIH,MIKTAR,KDVDAHILFIYAT,NETTOPLAM,STOKKOD ,STOKADI '+
 'FROM VW_CARIDETAYHAR where STOKHARID is not null and CARIID = '+IntToStr(FCari.CariID)+' order by TARIH',
 procedure (dt:TDataSet)
 begin
     itm:=list_shop.Prop.Items.Add;
     itm.Caption:=dt._S['STOKKOD'];
     itm.Detail:=dt._S['STOKADI'];
     itm.Detail1:=dt._S['VADE_TARIH'];
     itm.Detail2:=dt._S['MIKTAR']+'x'+Cur2Str(dt._D['KDVDAHILFIYAT']);
     itm.Detail3:=Cur2Str(dt._D['NETTOPLAM']);
 end
 );

 list_shop.Prop.EndUpdate;
end;

procedure TFForm_Cari.SkinFMXButton1Click(Sender: TObject);
begin

 //OpenNavigation(FCari.Enlem+','+FCari.Boylam);
end;

procedure TFForm_Cari.btn_not_silClick(Sender: TObject);
begin
  list_mesajlar.Prop.Items.BeginUpdate;
  if list_mesajlar.Prop.InteractiveItem<>nil then
     list_mesajlar.Prop.InteractiveItem.Destroy;
  Msg_Count.Prop.Number:=list_mesajlar.Prop.Items.Count;
  list_mesajlar.Prop.Items.EndUpdate();
end;

procedure TFForm_Cari.btn_not_editClick(Sender: TObject);
var
 itm:TSkinItem;
 i:Integer;
 TempStr:string;
begin
   i:=TFmxObject(Sender).Tag;
   if i>1 then
     begin
         itm :=list_mesajlar.Prop.InteractiveItem;
         if itm=nil then exit;
         list_mesajlar.Prop.StopItemPanDrag;
         TempStr:=itm.Detail1;
     end;

  DoMessage(Self,DateToStr(Now),Config.UserName,TMsgDlgType.mtInformation,'İptal,Kaydet',
  procedure (Aobj:TObject;ADrum:Boolean;AStr1,AStr2:string)
  begin
   if ADrum then
    begin
     if i=1 then
      begin
       itm:=list_mesajlar.Prop.Items.Add;
       Msg_Count.Prop.Number:=list_mesajlar.Prop.Items.Count;
      end;


     itm.Caption:=DateToStr(Now);
     itm.Detail:=Config.UserName;
     itm.Detail1:=AStr1;
    end;
  end,1
  );

          GlobalMessageBoxFrame.pnlInput1.Caption:='Mesaj';
          GlobalMessageBoxFrame.edtInput1.Text:=TempStr;
          GlobalMessageBoxFrame.edtInput1.TextPrompt:='';
          GlobalMessageBoxFrame.edtInput1.FilterChar:='';
          GlobalMessageBoxFrame.edtInput1.KeyboardType:=TVirtualKeyboardType.Default;
          GlobalMessageBoxFrame.btnDec1.Visible:=False;
          GlobalMessageBoxFrame.btnInc1.Visible:=False;
end;

procedure TFForm_Cari.tmrTimer(Sender: TObject);
begin

    FForm_Cari.LoadCari(tmr.Tag);
    WaitingFrame.HideWaitingFrame;
    tmr.Tag:=0;
    tmr.Enabled:=False;
end;







end.
