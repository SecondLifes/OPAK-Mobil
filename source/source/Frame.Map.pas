unit Frame.Map;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics, FMX.TMSFNCGraphicsTypes,
  FMX.TMSFNCMapsCommonTypes, uSkinFireMonkeyControl, uSkinPanelType,
  uSkinFireMonkeyPanel, FMX.TMSFNCCustomControl, FMX.TMSFNCWebBrowser,
  FMX.TMSFNCMaps, FMX.TMSFNCCustomComponent, FMX.TMSFNCCloudBase,
  FMX.TMSFNCLocation, FMX.TMSFNCGoogleMaps, FMX.Controls.Presentation;

type
  TFrame_Map = class(TFrame)
    pnl_ust: TSkinFMXPanel;
    Maps1: TTMSFNCGoogleMaps;
    Location1: TTMSFNCLocation;
    lbl1: TLabel;
    procedure Maps1GetCenterCoordinate(Sender: TObject;
      ACoordinate: TTMSFNCMapsCoordinateRec);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frame_Map:TFrame_Map;

implementation

{$R *.fmx}

procedure TFrame_Map.Maps1GetCenterCoordinate(Sender: TObject;
  ACoordinate: TTMSFNCMapsCoordinateRec);
begin
lbl1.Text:=Format('%.6f,%.6f', [ACoordinate.Latitude, ACoordinate.Longitude], TFormatSettings.Create('en-US'));

end;

end.
