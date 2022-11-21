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
  uSkinMultiColorLabelType, uSkinFireMonkeyMultiColorLabel,
  uUIFunction,
  FMX.VirtualKeyboard;

type
  TFCariler = class(TFBase,IFrameVirtualKeyboardEvent)
    edt_search: TSkinFMXEdit;
    list_urun: TSkinFMXListBox;
    DesignerPanel_pnl: TSkinFMXItemDesignerPanel;
    pnl_PullDownPanel1: TSkinFMXPullLoadPanel;
    lbl_Load: TSkinFMXLabel;
    imgLoad: TSkinFMXImage;
    lbl_bakiye: TSkinFMXLabel;
    SkinFMXImage1: TSkinFMXImage;
    lbl_TEL: TSkinFMXLabel;
    lbl_unvan: TSkinFMXLabel;
    lbl_ili: TSkinFMXLabel;
    SkinFMXPanel1: TSkinFMXPanel;
    Timer1: TTimer;
    pnlVirtualKeyboard: TSkinFMXPanel;
    ClearEditButton1: TClearEditButton;
    btnReturn: TSkinFMXButton;
    procedure list_urunClickItem(AItem: TSkinItem);
    procedure edt_searchChangeTracking(Sender: TObject);
    procedure lbl_TELClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ClearEditButton1Click(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoFiltre(const AFiltre:string);
     procedure DoVirtualKeyboardShow(KeyboardVisible: Boolean; const Bounds: TRect);
     procedure DoVirtualKeyboardHide(KeyboardVisible: Boolean; const Bounds: TRect);
  public
    procedure BackFrame;
  procedure AfterConstruction; override;
    { Public declarations }
  end;

var
  FCariler: TFCariler;

implementation
  uses Genel,Form.Satis,Frame.Cari,WaitingFrame;
{$R *.fmx}

procedure TFCariler.AfterConstruction;
begin
  inherited AfterConstruction;
  if Self.Tag=-1 then exit;
  
  Self.Tag:=-1;

    TThread.CreateAnonymousThread(
    procedure()
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure()
        begin
           WaitingFrame.ShowWaitingFrame(F_Satis,'Lütfen Bekleyiniz.');
          //TThread.Sleep(3000);

        end);

    end).Start;


  Self.pnlVirtualKeyboard.Height:=0;
  CariList:=TCariListe.create(list_urun.Prop);
  CariList.ClearNew(true);

      TThread.CreateAnonymousThread(
    procedure()
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure()
        begin
            WaitingFrame.HideWaitingFrame;

        end);

    end).Start;


 // HideVirtualKeyboard;



end;

procedure TFCariler.BackFrame;
begin
    HideFrame(Self,hfcttBeforeReturnFrame);
    ReturnFrame();
end;

procedure TFCariler.btnReturnClick(Sender: TObject);
begin
  BackFrame;

end;

procedure TFCariler.ClearEditButton1Click(Sender: TObject);
begin
  DoFiltre('');

end;

procedure TFCariler.DoFiltre(const AFiltre: string);
var
 AType:Byte;
 s:string;
 i,j:Integer;

begin
  s:=Trim(AFiltre);

  //if s.IsEmpty then exit;
  Self.list_urun.Properties.Items.BeginUpdate;
  try
   CariList.LoadDB(s);

  finally
    Self.list_urun.VertScrollBar.Prop.Position:=0;
    Self.list_urun.Properties.Items.EndUpdate;
  end;


end;

procedure TFCariler.DoVirtualKeyboardHide(KeyboardVisible: Boolean;
  const Bounds: TRect);
begin
 Self.pnlVirtualKeyboard.Height:=0;
end;

procedure TFCariler.DoVirtualKeyboardShow(KeyboardVisible: Boolean;
  const Bounds: TRect);
begin
   //{$IFDEF ANDROID}
      if Bounds.Height-GetGlobalVirtualKeyboardFixer.VirtualKeyboardHideHeight>Self.pnlVirtualKeyboard.Height then
      begin
      Self.pnlVirtualKeyboard.Height:=RectHeight(Bounds)-GetGlobalVirtualKeyboardFixer.VirtualKeyboardHideHeight;
      end;
 // {$ENDIF};
end;

procedure TFCariler.edt_searchChangeTracking(Sender: TObject);
begin
Timer1.Enabled:=False;
Timer1.Enabled:=True;

end;

procedure TFCariler.lbl_TELClick(Sender: TObject);
begin

 //F_Satis.MakeCallPhone(TSkinFMXLabel(Sender).Text);

end;

procedure TFCariler.list_urunClickItem(AItem: TSkinItem);
begin



  if self.Tag = TCariItem(AItem).CariID.AsInteger  then Exit;

   self.Tag:=TCariItem(AItem).CariID.AsInteger;
   FormCari(TCariItem(AItem).CariID.AsInteger);



end;

procedure TFCariler.Timer1Timer(Sender: TObject);
begin
    DoFiltre(edt_Search.Text);
    Timer1.Enabled:=false;
end;

end.
