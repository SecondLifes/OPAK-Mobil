unit OMR.Cari;

interface
 uses System.SysUtils;

 Type
  TCari = class
  strict private
    FCariID: Integer;
    FUnvani: string;
    FAdi: string;
    FSoyAdi: string;
    FCariKodu: string;
    FIL: string;
    FILCE: string;
    //FCadde,FBina,FKapiNo: string;
    FAdres: string;
    FVergiDairesi: string;
    FVergiNo: string;
    FTCNo: string;
    FBorc: Extended;
    FAlacak: Extended;
  private


  public
    function Bakiye:Extended;
    constructor Create(const ACariID:Cardinal=0);
    //destructor Destroy; override;
    procedure Clear;
    procedure LoadDB(const ACariID:Cardinal=0);
    function SaveDB:Boolean;

    property CariID:Integer read FCariID;
    property CariKodu:string read FCariKodu;

    property Unvani:string read FUnvani write FUnvani;
    property Adi:string read FAdi write FAdi;
    property SoyAdi:string read FSoyAdi write FSoyAdi;
    property TCNo:string read FTCNo write FTCNo;

    property IL:string read FIL write FIL;
    property ILCE:string read FILCE write FILCE;
    property Adres:string read FAdres write FAdres;
    //property Cadde:string read FCadde write FCadde;
    //property Bina:string read FBina write FBina;
    //property KapiNo:string read FKapiNo write FKapiNo;

    property VergiDairesi:string read FVergiDairesi write FVergiDairesi;
    property VergiNo:string read FVergiNo write FVergiNo;

    property Borc:Extended read FBorc write FBorc;
    property Alacak:Extended read FAlacak write FAlacak;





  end;

implementation
 uses DBOpak,Data.DB,Help.uni,Help.DB,Help.Str,FMX.DialogService;
{ TCari }

function TCari.Bakiye: Extended;
begin
  Result:=FBorc-FAlacak;
end;



procedure TCari.Clear;
begin

end;

constructor TCari.Create(const ACariID: Cardinal);
begin
  FCariID:=0;
  if FCariID>0 then LoadDB(ACariID);

end;


procedure TCari.LoadDB(const ACariID: Cardinal);
begin
  FCariID:=CariID;
  DB.cn_db._DoEof('select ID,KOD,ADI,CARIADI,CARISOYADI,KIMLIKNO,IL,ILCE,'+//CADDE,BINA,KAPINO,'+
  'ADRES,VERGI_DAIRESI,VERGINO from TBLCARISB where ID='+inttostr(ACariID),
  procedure (dt:TDataSet)
  begin
    FCariID:=dt._I['ID'];
    FCariKodu:=dt._S['KOD'];
    FUnvani:=dt._S['ADI'];
    FAdi:=dt._S['CARIADI'];
    FSoyAdi:=dt._S['CARISOYADI'];
    FTCNo:=dt._S['KIMLIKNO'];
    FIL:=dt._S['IL'];
    FILCE:=dt._S['ILCE'];
    FAdres:=dt._S['ADRES'];
    //FCadde:=dt._S['CADDE'];
    //FBina:=dt._S['BINA'];
    //FKapiNo:=dt._S['KAPINO'];
    FVergiDairesi:=dt._S['VERGI_DAIRESI'];
    FVergiNo:=dt._S['VERGINO'];
  end
  );

end;

function TCari.SaveDB:Boolean;
var
  s:string;
begin
  Result:=False;
  s:='UPDATE dbo.TBLCARISB SET '+
     ' ADI='+QuotedStr(FUnvani)+
     ',CARIADI='+QuotedStr(FAdi)+
     ',CARISOYADI='+QuotedStr(FSoyAdi)+
     ',KIMLIKNO='+QuotedStr(TCNo)+
     ',IL='+QuotedStr(FIL)+
     ',ILCE='+QuotedStr(FILCE)+
     //',CADDE='+QuotedStr(FUnvani)+
     ',ADRES='+QuotedStr(FAdres)+
     ',VERGI_DAIRESI='+QuotedStr(VergiDairesi)+
     ',VERGINO='+QuotedStr(FVergiNo)+
     'WHERE ID = '+IntToStr(FCariID);
     
 try

     DB.cn_db.ExecSQL(s);
     Result:=True;
 except
    Result:=False;
 end;

end;

end.
