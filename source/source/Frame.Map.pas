unit Frame.Map;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics, FMX.TMSFNCGraphicsTypes,
  FMX.TMSFNCMapsCommonTypes, uSkinFireMonkeyControl, uSkinPanelType,
  uSkinFireMonkeyPanel, FMX.TMSFNCCustomControl, FMX.TMSFNCWebBrowser,
  FMX.TMSFNCMaps, FMX.TMSFNCCustomComponent, FMX.TMSFNCCloudBase,
  FMX.TMSFNCLocation, FMX.TMSFNCGoogleMaps, FMX.Controls.Presentation,
  FMX.TMSFNCMapKit,Generics.Collections, System.Sensors,DBOpak,
  System.Sensors.Components, uSkinButtonType, uSkinFireMonkeyButton,
  uSkinCalloutRectType,OMR.Cari;

type
 //TIconType =(Current)
  //TMaker = class(TTMSFNCGoogleMapsMarker) public end;

  TFrame_Map = class(TForm)
    Location1: TTMSFNCLocation;
    LocationSensor1: TLocationSensor;
    btn_konum: TSkinFMXButton;
    rect_back: TSkinFMXCalloutRect;
    rect_orta: TSkinFMXCalloutRect;
    pnl_ToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    btn_kayet: TSkinFMXButton;
    SkinFMXButton1: TSkinFMXButton;
    tmr1: TTimer;
    Maps1: TTMSFNCGoogleMaps;
    procedure Maps1MarkerClick(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure btn_konumClick(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure btnReturnClick(Sender: TObject);
    procedure btn_kayetClick(Sender: TObject);
    procedure Maps1MarkerDragEnd(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure SkinFMXButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
    FCari:TCari;
    FCariMaplist:TDictionary<Cardinal,TTMSFNCGoogleMapsMarker>;
    FSelectMap:TTMSFNCGoogleMapsMarker;
 
      function AddOrSetMarker(const ACariID:Integer; ATitle: string; ALatitude,ALongitude: Double; AIconName: string='LogoMavi'):TTMSFNCGoogleMapsMarker; overload;
      function AddOrSetMarker(const ACariID:Integer; ATitle, ALatitude,ALongitude: string; AIconName: string='LogoMavi'):TTMSFNCGoogleMapsMarker;overload;

  public
    { Public declarations }
      FLastMaker:TTMSFNCGoogleMapsMarker;
      procedure AfterConstruction; override;
      destructor Destroy; override;
      function AddOrSetCari(const ADef:Boolean=True):TTMSFNCGoogleMapsMarker;
  end;


  TTMSFNCGoogleMapsMarkerHelp = class helper for TTMSFNCGoogleMapsMarker
   function Edit(const ADef:Boolean=True):TTMSFNCGoogleMapsMarker;
   function SetZoom:TTMSFNCGoogleMapsMarker; 

  end;

   function ShowMap(const ACari:TCari=nil):TFrame_Map;


implementation
uses uUIFunction,WaitingFrame,HintFrame, Frame.Login,OpenViewUrl,FMX.DialogService;
var
  Frame_Map:TFrame_Map=nil;
const

LogoKirmizi = 'data:image/png;base64,'
  + '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';
LogoMavi = 'data:image/png;base64,'
  + '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'
  + 'UVORK5CYII=';

{$R *.fmx}

function ShowMap(const ACari:TCari=nil):TFrame_Map;
begin


  if Frame_Map=nil then 
  begin
   Frame_Map:=TFrame_Map.Create(Application);

      var d1:=StrToFloatDef(ACari.Enlem,0,FormatEN);
      var d2:=StrToFloatDef(ACari.Boylam,0,FormatEN);
     if (d1<>0) or (d2<>0) then
      begin
       Frame_Map.Maps1.Options.DefaultLatitude:=d1;
       Frame_Map.Maps1.Options.DefaultLongitude:=d2;
      end;
        with Frame_Map do
        begin
          // Maps1.APIKey:= 'AIzaSyBgaViyAXc833dpBZH1m6EWjlPhND04RN8';
           Maps1.OnMarkerClick:= Maps1MarkerClick;
          // Maps1.Options.Locale:= 'tr-TR';
           Maps1.Options.ShowMapTypeControl:= False;
           Maps1.Options.ShowKeyboardShortcuts:=False;
           Maps1.OnMarkerDragEnd:= Maps1MarkerDragEnd;
           Maps1.Options.DefaultZoomLevel:= 17.000000000000000000;

        end;


  end;
  Frame_Map.FCari:=ACari;
  Frame_Map.FLastMaker:=nil;
  Result:=Frame_Map;

  Frame_Map.Show;





end;



function TFrame_Map.AddOrSetMarker(const ACariID: Integer; ATitle: string;
  ALatitude, ALongitude: Double; AIconName: string): TTMSFNCGoogleMapsMarker;
begin
 try
    Maps1.BeginUpdate;

   if FCariMaplist.TryGetValue(ACariID,Result) then
      begin
       Maps1.Markers.Delete(Result.Index);
       FCariMaplist.Remove(ACariID);
      end;

    Result:=Maps1.AddMarker(ALatitude, ALongitude, ATitle,LogoKirmizi);
    Result.IconURL:='http://maps.google.com/mapfiles/kml/paddle/M.png';
    Result.Clickable:=True;
    Result.Draggable:=False;
    //Result.IconWidth :=32;
    //Result.IconHeight:=32;
    Result.DefaultIconSize:=False;

    FCariMaplist.Add(ACariID,Result);

 finally
  //Maps1.SetCenterCoordinate(Result.Coordinate.ToRec);
  tmr1.Enabled:=True;
  Maps1.EndUpdate;

 
 end;
end;

function TFrame_Map.AddOrSetMarker(const ACariID: Integer; ATitle, ALatitude, ALongitude, AIconName: string): TTMSFNCGoogleMapsMarker;
var
 d1 ,d2:Double;
begin

   d1:=StrToFloatDef(ALatitude,0,FormatEN);
   d2:=StrToFloatDef(ALongitude,0,FormatEN);
   if (d1=0) or (d2=0) then begin Result:=nil; Exit; end;

   Result:=AddOrSetMarker(ACariID,ATitle,d1,d2,AIconName);
end;

function TFrame_Map.AddOrSetCari(const ADef: Boolean): TTMSFNCGoogleMapsMarker;
begin
   if FCari=nil then Exit;
   Maps1.BeginUpdate;
   try

     Result:=AddOrSetMarker(FCari.CariID,FCari.Unvani,FCari.Enlem,FCari.Boylam);
     if Result=nil then Exit;

     FLastMaker:=Result;
     Result.Edit(ADef);
   finally
     Maps1.EndUpdate;
   end;

end;



procedure TFrame_Map.AfterConstruction;
begin
  inherited AfterConstruction;
 FCariMaplist:=TDictionary<Cardinal,TTMSFNCGoogleMapsMarker>.Create;
end;

procedure TFrame_Map.btnReturnClick(Sender: TObject);
begin
 Close;
end;

destructor TFrame_Map.Destroy;
begin
  FCariMaplist.Free;
  inherited Destroy;
end;

procedure TFrame_Map.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if FLastMaker<>nil then FLastMaker.Edit(False);
 Maps1.CloseAllPopups;
 
end;

procedure TFrame_Map.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  LocationSensor1.Active:=False;
  FCari.Enlem  := NewLocation.Latitude.ToString(ffGeneral, 8, 5, FormatEN);
  FCari.Boylam := NewLocation.Longitude.ToString(ffGeneral, 8, 5, FormatEN);

  AddOrSetCari(True);


  //Maps1.ShowPopup(FLastMaker.Coordinate.ToRec,'');
  btn_konum.Enabled:=True;


end;


  //lbl1.Text:=Format('%.6f,%.6f', [ACoordinate.Latitude, ACoordinate.Longitude], TFormatSettings.Create('en-US'));
  //SetCenterCoordinate(AEventData.Coordinate.ToRec);
  //lbl1.Text:=Format('%.6f,%.6f', [AEventData.Coordinate.Latitude, AEventData.Coordinate.Longitude], TFormatSettings.Create('en-US'));


procedure TFrame_Map.Maps1MarkerClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
var  s: string;
begin
 (*
  s := '';
  case AEventData.Marker.DataInteger of
    1: s := '<b>Chongqing</b><br><img width="200" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/SkylineOfChongqing.jpg/2880px-SkylineOfChongqing.jpg"/>';
    2: s := '<b>Mount Tambora</b><br><img width="200" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Mount_Tambora_Volcano%2C_Sumbawa_Island%2C_Indonesia.jpg/1920px-Mount_Tambora_Volcano%2C_Sumbawa_Island%2C_Indonesia.jpg"/>';
    3: s := '<b>Highway 10</b><br><iframe src="https://giphy.com/embed/10pk8d1EoR7HrO" width="200" height="200" frameBorder="0" class="giphy-embed"></iframe>';
    4: s := '<b>Central Park</b>';
  end;
  s := '<b>Highway 10</b><br><iframe src="https://giphy.com/embed/10pk8d1EoR7HrO" width="200" height="200" frameBorder="0" class="giphy-embed"></iframe>';
  s := s + '<br>Longitude: <i>'+ AEventData.Marker.Longitude.ToString +'</i><br>Latitude: <i>'+ AEventData.Marker.Latitude.ToString +'</i>';
  *)
    if FCari=nil then Exit;
    
    FSelectMap:=AEventData.Marker as TTMSFNCGoogleMapsMarker;
    s:='<b>'+FCari.Unvani+'</b><br>'
    +FCari.Adi+' '+FCari.SoyAdi+'<br>'
    +'<b>Alacak:</b><i>'+Cur2Str(FCari.Alacak)+'</i><br>'
    +'<b>Borç  :</b><i>'+Cur2Str(FCari.Borc)+'</i><br>'
    +'<b>Bakiye:</b><i>'+Cur2Str(FCari.Bakiye)+'</i><br>'
    //+'<b>YolTarifi</b>'
    ;
    
    Maps1.ShowPopup(AEventData.Marker.Coordinate.ToRec, s);

end;

procedure TFrame_Map.Maps1MarkerDragEnd(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
 AEventData.Marker.Coordinate:=AEventData.Coordinate;
end;

procedure TFrame_Map.SkinFMXButton1Click(Sender: TObject);
begin
  if FSelectMap=nil then exit;
  OpenNavigation(FSelectMap.Coordinate.Latitude.ToString(ffGeneral, 8, 5, FormatEN)+','+FSelectMap.Coordinate.Longitude.ToString(ffGeneral, 8, 5, FormatEN));
end;

procedure TFrame_Map.tmr1Timer(Sender: TObject);
begin
 tmr1.Enabled:=false;
 if FLastMaker<>nil then FLastMaker.SetZoom;
 
end;

procedure TFrame_Map.btn_kayetClick(Sender: TObject);
begin
 if (FCari<>nil) and (FLastMaker<>nil) then
  begin
   FCari.Enlem  := FLastMaker.Coordinate.Latitude.ToString(ffGeneral, 8, 5, FormatEN);
   FCari.Boylam := FLastMaker.Coordinate.Longitude.ToString(ffGeneral, 8, 5, FormatEN);
   if FCari.SaveDBKonum then
    HintFrame.ShowHintFrame(Self,'Konum Kayýt Edildi.');
  end;
end;

procedure TFrame_Map.btn_konumClick(Sender: TObject);
begin
 {$IFDEF ANDROID}
   LocationSensor1.Active := True;
   btn_konum.Enabled:=false;
    {$ELSE}
   LocationSensor1.Active := False
 {$ENDIF}
end;

{ TTMSFNCGoogleMapsMarkerHelp }


function TTMSFNCGoogleMapsMarkerHelp.Edit(const ADef: Boolean):TTMSFNCGoogleMapsMarker;
begin
  Result:=Self;
  if ADef then
   begin
    Self.Draggable:=True;
    Self.IconURL:='http://maps.google.com/mapfiles/kml/paddle/M.png';//LogoKirmizi;
   end
   else
   begin
    Self.IconURL:='http://maps.google.com/mapfiles/kml/pushpin/red-pushpin.png';
    Self.Draggable:=False;
   end;

  //DEFAULT_ICONURL;
  //https://mapmarker.io/documentation
  //http://kml4earth.appspot.com/icons.html
  //http://maps.google.com/mapfiles/kml/paddle/M.png
end;

function TTMSFNCGoogleMapsMarkerHelp.SetZoom: TTMSFNCGoogleMapsMarker;
begin
 Result:=Self;
 Frame_Map.Maps1.SetCenterCoordinate(Coordinate.ToRec);
 Frame_Map.Maps1.SetZoomLevel(17);
end;

end.
