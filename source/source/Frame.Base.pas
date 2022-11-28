unit Frame.Base;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinLabelType, uSkinFireMonkeyLabel, uSkinPanelType, uSkinFireMonkeyPanel,
  uSkinFireMonkeyControl, uSkinCalloutRectType,DBOpak;

type
  TFBase = class(TFrame)
    rect_back: TSkinFMXCalloutRect;
    rect_orta: TSkinFMXCalloutRect;
    pnlToolBar: TSkinFMXPanel;
    lbl_Info: TSkinFMXLabel;
  private
    { Private declarations }
  public
      procedure AfterConstruction; override;

    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TFBase }

procedure TFBase.AfterConstruction;
begin
  inherited AfterConstruction;
  lbl_Info.Caption:=Format('M Ý K O T E K (%s v.%s)',[cAppName,cAppVersiyon]);

end;

end.
