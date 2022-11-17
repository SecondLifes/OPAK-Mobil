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
  uSkinFireMonkeyMemo
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
    btnPublish: TSkinFMXButton;
    edt_Adi: TSkinFMXEdit;
    ClearEditButton2: TClearEditButton;
    edt_soyad: TSkinFMXEdit;
    ClearEditButton3: TClearEditButton;
    edt_tc: TSkinFMXEdit;
    ClearEditButton4: TClearEditButton;
    edt_sehir: TSkinFMXComboEdit;
    edt_ilce: TSkinFMXEdit;
    ClearEditButton5: TClearEditButton;
    btnReturn: TSkinFMXButton;
    edt_vergiDaire: TSkinFMXEdit;
    ClearEditButton9: TClearEditButton;
    edt_vergino: TSkinFMXEdit;
    ClearEditButton10: TClearEditButton;
    edt_adres: TSkinFMXMemo;
    procedure btnReturnClick(Sender: TObject);
    procedure btnPublishClick(Sender: TObject);
  private
    FCari:TCari;
    procedure LoadCari(const ACariID:Cardinal);
    procedure SaveCari;
    procedure BackFrame;
    procedure Clear;
    { Private declarations }
  public
      procedure AfterConstruction; override;
      destructor Destroy; override;


    { Public declarations }

  end;

//var
//  F_Cari: TF_Cari;

 procedure FormCari(const ACariID:Integer);

implementation
uses uUIFunction,HintFrame,WaitingFrame;
  var
   FForm_Cari:TFForm_Cari;
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
  FCari:=TCari.Create(0);
end;

procedure TFForm_Cari.BackFrame;
begin

     HideFrame(Self,hfcttBeforeReturnFrame);
     //ReturnFrame();
     Clear;
end;

procedure TFForm_Cari.btnPublishClick(Sender: TObject);
begin
  SaveCari;

end;

procedure TFForm_Cari.btnReturnClick(Sender: TObject);
begin
 BackFrame;
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

procedure TFForm_Cari.LoadCari(const ACariID: Cardinal);
begin
 FCari.LoadDB(ACariID);
 edt_Unvani.Text:=FCari.Unvani;
 edt_Adi.Text:=FCari.Adi;
 edt_soyad.Text:=FCari.SoyAdi;
 edt_tc.Text:=FCari.TCNo;
 edt_vergiDaire.Text:=FCari.VergiDairesi;
 edt_vergino.Text:=FCari.VergiNo;
 edt_sehir.Text:=FCari.IL;
 edt_ilce.Text:=FCari.ILCE;
 edt_adres.Lines.Text:=FCari.Adres;
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
