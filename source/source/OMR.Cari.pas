unit OMR.Cari;

interface
 uses System.SysUtils,Data.DB,System.Classes;


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
    FAciklama: TStrings;


  public
    function Bakiye:Extended;
    constructor Create(const ACariID:Cardinal=0);
    destructor Destroy; override;
    procedure Clear;
    procedure LoadDB(const ACariID:Cardinal=0);
    function SaveDB:Boolean;

    procedure IletisimSil(const AId:Integer);
  //select ID,GOREVI,YETKILI,TELEFON,CEPTEL from TBLCARITELEFONSB where CARIID=1491
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

    property Aciklama:TStrings read FAciklama write FAciklama;
  end;

implementation
 uses DBOpak,Help.uni,Help.DB,Help.Str,FMX.DialogService;
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
  FAciklama:=TStringList.Create;
  if FCariID>0 then LoadDB(ACariID);


end;


destructor TCari.Destroy;
begin
  FAciklama.Free;
  inherited Destroy;
end;

procedure TCari.IletisimSil(const AId: Integer);
begin
 DB.cn_db.ExecSql('DELETE FROM TBLCARITELEFONSB where ID='+IntToStr(AId));
end;

procedure TCari.LoadDB(const ACariID: Cardinal);
var
 SQL:string;
begin
  FCariID:=CariID;
  SQL:='SELECT C.ID, C.KOD,C.ADI,C.CARIADI,C.CARISOYADI,C.CEPTEL1,C.IL,C.ILCE,C.ADRES,C.VERGI_DAIRESI,C.VERGINO,C.KIMLIKNO,C.ACIKLAMA, '+
'  SUM(HR.BORC) AS BORC,SUM(HR.ALACAK) AS ALACAK FROM dbo.TBLCARIHAR HR INNER JOIN TBLCARISB C ON (HR.CARIID = C.ID) '+
'  WHERE C.ID='+inttostr(ACariID)+' AND HR.KAYITTIPI = 0 AND HR.ISLEMTIPI IN (0,1) AND HR.DONEM='+Config.Donem+
//'  --TIPI IN(''Alýcý'',''Satýcý'',''Alýcý ve Satýcý'',''Perakende'') and '+
'  GROUP BY C.ID,C.KOD,C.ADI,C.CARIADI,C.CARISOYADI,C.CEPTEL1,C.IL,C.ILCE,C.ADRES,C.VERGI_DAIRESI,C.VERGINO,C.KIMLIKNO,C.ACIKLAMA ORDER BY IL,ILCE,ADI';


  DB.cn_db._DoEof(SQL,
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
    FBorc:=dt._D['BORC'];
    FAlacak:=dt._D['ALACAK'];
    FAciklama.Text:=dt._S['ACIKLAMA'];
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
     ',ACIKLAMA='+QuotedStr(FAciklama.Text)+
     'WHERE ID = '+IntToStr(FCariID);
     
 try

     DB.cn_db.ExecSQL(s);
     Result:=True;
 except
    Result:=False;
 end;

end;



end.
