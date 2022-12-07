unit Frame.Note;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Frame.Base, uSkinLabelType, uSkinFireMonkeyLabel, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinFireMonkeyControl, uSkinCalloutRectType,
  uSkinMaterial, FMX.Edit, FMX.Controls.Presentation, uSkinFireMonkeyEdit,
  uSkinButtonType, uSkinFireMonkeyButton, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, uSkinFireMonkeyMemo
  ,uSkinItems
  ;

type
  TF_Note = class(TFBase)
    SkinFMXPanel1_Material: TSkinPanelDefaultMaterial;
    pnl_4: TSkinFMXPanel;
    pnl_2: TSkinFMXPanel;
    btn_login: TSkinFMXButton;
    btnReturn: TSkinFMXButton;
    btn_kayet: TSkinFMXButton;
    edt_Not: TSkinFMXMemo;
    lbl_tarih: TSkinFMXLabel;
    lbl_user: TSkinFMXLabel;
    procedure btnReturnClick(Sender: TObject);
    procedure btn_kayetClick(Sender: TObject);
  private
  FList:TBaseSkinItems;
  FItems:TSkinItem;
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure NoteEdit(const AList:TBaseSkinItems; const itm:TSkinItem = nil);


implementation
uses DBOpak,uUIFunction;
var
  F_Note: TF_Note;

{$R *.fmx}


  procedure NoteEdit(const AList:TBaseSkinItems; const itm:TSkinItem = nil);
  begin

    ShowFrame(TFrame(F_Note),TF_Note,Application.MainForm,nil,nil,nil,Application);
    F_Note.FList :=AList;
    F_Note.FItems:=itm;
    if itm<>nil then
     begin
       F_Note.lbl_tarih.Caption:=itm.Caption;
       F_Note.lbl_user.Caption:=itm.Detail;
       F_Note.edt_Not.Lines.Text:=itm.Detail1;
     end
     else
     begin
       F_Note.lbl_tarih.Caption:=DateToStr(Now);
       F_Note.lbl_user.Caption:=Config.UserName;
       F_Note.edt_Not.Lines.Text:=''
     end;


  end;

procedure TF_Note.btnReturnClick(Sender: TObject);
begin
  ClearOnReturnFrameEvent(Self);

  HideFrame;//();
  ReturnFrame();

end;

procedure TF_Note.btn_kayetClick(Sender: TObject);
begin
  if FItems=nil then
  FItems:=FList.Add as TSkinItem;
  FItems.Caption:=lbl_tarih.Caption.Trim;
  FItems.Detail:=lbl_user.Caption.Trim;
  FItems.Detail1:=Trim(StringReplace(edt_Not.Lines.Text,sLineBreak,' ',[rfReplaceAll]));
  btnReturnClick(nil)
end;

end.
