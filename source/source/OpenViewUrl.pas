unit OpenViewUrl;

interface

uses System.Sensors;

// URLEncode is performed on the URL
// so you need to format it   protocol://path
function OpenURL(const URL: string; const DisplayError: Boolean = False): Boolean;
function OpenNavigation(const Q: string): Boolean; overload;
function OpenNavigation(const Q: string; const Coord: TLocationCoord2D): Boolean; overload;

implementation

uses
  IdURI, SysUtils, Classes, FMX.Dialogs
{$IFDEF ANDROID}
  , FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net, Androidapi.JNI.JavaTypes, Androidapi.Helpers;
{$ELSE}
{$IFDEF IOS}
  , iOSapi.Foundation, FMX.Helpers.iOS, Macapi.Helpers;
{$ELSE};
{$ENDIF IOS}
{$ENDIF ANDROID}


function OpenURL(const URL: string; const DisplayError: Boolean = False): Boolean;
{$IFDEF ANDROID}
var
  Intent: JIntent;
begin
// There may be an issue with the geo: prefix and URLEncode.
// will need to research
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
    //TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(URL))));
    TJnet_Uri.JavaClass.parse(StringToJString(URL)));
  try
    SharedActivity.startActivity(Intent);
    exit(true);
  except
    on e: Exception do
    begin
      if DisplayError then ShowMessage('Error: ' + e.Message);
      exit(false);
    end;
  end;
end;
{$ELSE}
{$IFDEF IOS}
var
  NSU: NSUrl;
begin
  // iOS doesn't like spaces, so URL encode is important.
  // NSU := StrToNSUrl(TIdURI.URLEncode(URL));
  NSU := StrToNSUrl(URL);
  if SharedApplication.canOpenURL(NSU) then
    exit(SharedApplication.openUrl(NSU))
  else
  begin
    if DisplayError then
      ShowMessage('Error: Opening "' + URL + '" not supported.');
    exit(false);
  end;
end;
{$ELSE}
begin
  raise Exception.Create('Not supported!');
end;
{$ENDIF IOS}
{$ENDIF ANDROID}



function OpenNavigation(const Q: string): Boolean;
var Coord: TLocationCoord2D;
begin
  Coord.Latitude := 0.0;
  Coord.Longitude := 0.0;
  OpenNavigation(Q, Coord);
end;


function OpenNavigation(const Q: string; const Coord: TLocationCoord2D): Boolean;
var
  CoordString: String;
begin
  //Open in Google Maps
  {$IFDEF ANDROID}
  exit(OpenURL('http://maps.google.com/?q=' + Q));
  {$ELSE}

  //In iOS, if Google Maps is installed, use it, otherwise, use Apple Maps
  //If we have coordinates, use them as the start address
  {$IFDEF IOS}
  //Get a string of the longitute and latitute seperated by a comma if set
  if (Coord.Latitude <> 0.0) or (Coord.Longitude <> 0.0) then
  begin
    CoordString := Coord.Latitude.ToString + ',' + Coord.Longitude.ToString;
  end
  else begin
    CoordString := '';
  end;
  if not OpenURL('comgooglemaps://?daddr=' + Q) then
  begin
    if (0.0 < CoordString.Length) then
    begin
      exit(OpenURL('http://maps.apple.com/?daddr=' + Q + '&saddr=loc:' + CoordString));
    end
    else begin
      exit(OpenURL('http://maps.apple.com/?daddr=' + Q));
    end;
  end
  else begin
    exit(true);
  end;
  {$ELSE}
  //Unsupported platform
  exit(false);
  {$ENDIF IOS}
  {$ENDIF ANDROID}
end;


end.
