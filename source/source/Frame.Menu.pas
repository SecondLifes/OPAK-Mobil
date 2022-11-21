unit Frame.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Frame.Base, uSkinLabelType, uSkinFireMonkeyLabel, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinFireMonkeyControl, uSkinCalloutRectType, DBOpak,
  uDrawCanvas, uSkinItems, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView,
  uSkinItemDesignerPanelType, uSkinFireMonkeyItemDesignerPanel, uSkinImageType,
  uSkinFireMonkeyImage, uSkinPullLoadPanelType, uSkinFireMonkeyPullLoadPanel,
  uSkinMaterial;

type
  TFMenu = class(TFBase)
    lbl_masa_Material: TSkinLabelDefaultMaterial;
    list_masalar: TSkinFMXListView;
    pnl_PullDownPanel: TSkinFMXPullLoadPanel;
    lbl_Load: TSkinFMXLabel;
    imgLoad: TSkinFMXImage;
    ListItemDefault: TSkinFMXItemDesignerPanel;
    lbl_baslik: TSkinFMXLabel;
    SkinFMXImage1: TSkinFMXImage;
    procedure list_masalarClickItem(AItem: TSkinItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMenu: TFMenu;

implementation

uses
  Form.Cariler, FMX.DialogService, uUIFunction, WaitingFrame, System.Rtti,
  System.IOUtils, HintFrame, Help.DB, Help.uni
  {$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.GraphicsContentViewText,
    Androidapi.JNI.Net, AndroidApi.Jni.JavaTypes
  {$ENDIF}
;
{$R *.fmx}

procedure TFMenu.list_masalarClickItem(AItem: TSkinItem);
begin

   case AItem.tag1 of
    1:ShowFrame(TFrame(FCariler), TFCariler, Application.MainForm, nil, nil, nil, Application);
  end;

end;

end.

