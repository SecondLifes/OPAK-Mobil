unit Form.Cariler;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Frame.Base, uSkinLabelType, uSkinFireMonkeyLabel, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinFireMonkeyControl, uSkinCalloutRectType,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit,DBOpak, uDrawCanvas,
  uSkinItems, uSkinScrollControlType, uSkinCustomListType, uSkinVirtualListType,
  uSkinListBoxType, uSkinFireMonkeyListBox, uSkinButtonType,
  uSkinFireMonkeyButton, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinImageType, uSkinFireMonkeyImage,
  uSkinPullLoadPanelType, uSkinFireMonkeyPullLoadPanel,
  uSkinMultiColorLabelType, uSkinFireMonkeyMultiColorLabel;

type
  TFCariler = class(TFBase)
    edt_search: TSkinFMXEdit;
    list_urun: TSkinFMXListBox;
    DesignerPanel_pnl: TSkinFMXItemDesignerPanel;
    pnl_PullDownPanel1: TSkinFMXPullLoadPanel;
    lbl_Load: TSkinFMXLabel;
    imgLoad: TSkinFMXImage;
    lbl_bakiye: TSkinFMXLabel;
    SkinFMXMultiColorLabel2: TSkinFMXMultiColorLabel;
    SkinFMXImage1: TSkinFMXImage;
    lbl_TEL: TSkinFMXLabel;
    lbl_unvan: TSkinFMXLabel;
    procedure list_urunClickItem(AItem: TSkinItem);
    procedure edt_searchChangeTracking(Sender: TObject);
    procedure lbl_TELClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoFiltre(const AFiltre:string);
  public
  procedure AfterConstruction; override;
    { Public declarations }
  end;

var
  FCariler: TFCariler;

implementation
  uses Genel,Form.Satis;
{$R *.fmx}

procedure TFCariler.AfterConstruction;
begin
  inherited AfterConstruction;

  CariList:=TCariListe.create(list_urun.Prop);
  CariList.Clear(true);

 // HideVirtualKeyboard;



end;

procedure TFCariler.DoFiltre(const AFiltre: string);
var
 AType:Byte;
 s:string;
 i,j:Integer;

begin
  s:=Trim(AFiltre);

  if s.IsEmpty then exit;
  Self.list_urun.Properties.Items.BeginUpdate;
  try
   CariList.LoadDB(s);

  finally
    Self.list_urun.VertScrollBar.Prop.Position:=0;
    Self.list_urun.Properties.Items.EndUpdate;
  end;


end;

procedure TFCariler.edt_searchChangeTracking(Sender: TObject);
begin
  DoFiltre(edt_Search.Text);
end;

procedure TFCariler.lbl_TELClick(Sender: TObject);
begin

 F_Satis.MakeCallPhone(TSkinFMXLabel(Sender).Text);

end;

procedure TFCariler.list_urunClickItem(AItem: TSkinItem);
begin
  inherited;
ShowMessage('Deneme')
end;

end.
