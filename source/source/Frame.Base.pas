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
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
