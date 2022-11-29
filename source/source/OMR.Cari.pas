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
    FAciklama: TStrings;
    FEnlem: string;
    FBoylam: string;
    FTelefon: string;
    FEMail: string;
  private
    FCariTipi: string;


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
    property CariTipi:string read FCariTipi write FCariTipi;

    property Unvani:string read FUnvani write FUnvani;
    property Adi:string read FAdi write FAdi;
    property SoyAdi:string read FSoyAdi write FSoyAdi;
    property Telefon:string read FTelefon write FTelefon;
    property TCNo:string read FTCNo write FTCNo;

    property IL:string read FIL write FIL;
    property ILCE:string read FILCE write FILCE;
    property Adres:string read FAdres write FAdres;
    property EMail:string read FEMail write FEMail;
    //property Cadde:string read FCadde write FCadde;
    //property Bina:string read FBina write FBina;
    //property KapiNo:string read FKapiNo write FKapiNo;

    property VergiDairesi:string read FVergiDairesi write FVergiDairesi;
    property VergiNo:string read FVergiNo write FVergiNo;

    property Borc:Extended read FBorc write FBorc;
    property Alacak:Extended read FAlacak write FAlacak;


    property Aciklama:TStrings read FAciklama write FAciklama;
    property Enlem:string read FEnlem write FEnlem;
    property Boylam:string read FBoylam write FBoylam;
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
    FCariID:=-1;
    FCariTipi:='Alýcý';
    FUnvani:='';
    FAdi:='';
    FSoyAdi:='';
    FCariKodu:='';
    FIL:='';
    FILCE:='';
    //FCadde,FBina,FKapiNo: string;
    FAdres:='';
    FVergiDairesi:='';
    FVergiNo:='';
    FTCNo:='';
    FBorc:=0;
    FAlacak:=0;
    FAciklama.Text:='';
    FEnlem:='';
    FBoylam:='';
    FTelefon:='';
    FEMail:='';
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
 arg:TArray<string>;
begin
  FCariID:=ACariID;
  if FCariID = 0 then
    begin
      Clear;
      Exit;
    end;

  SQL:='SELECT C.ID, C.KOD,C.ADI,C.CARIADI,C.CARISOYADI,C.CEPTEL1,C.IL,C.ILCE,C.ADRES,C.VERGI_DAIRESI,C.VERGINO,C.KIMLIKNO,C.EMAIL,C.ACIKLAMA,C.ACIKLAMA10,TIPI, '+
'  SUM(HR.BORC) AS BORC,SUM(HR.ALACAK) AS ALACAK FROM dbo.TBLCARIHAR HR RIGHT JOIN TBLCARISB C ON (HR.CARIID = C.ID) '+
'  WHERE C.ID='+inttostr(ACariID)+' AND COALESCE(HR.KAYITTIPI,0) = 0 AND COALESCE(HR.ISLEMTIPI,0) IN (0,1) AND COALESCE(HR.DONEM,'+Config.Donem+')='+Config.Donem+
//'  --TIPI IN(''Alýcý'',''Satýcý'',''Alýcý ve Satýcý'',''Perakende'') and '+
'  GROUP BY C.ID,C.KOD,C.ADI,C.CARIADI,C.CARISOYADI,C.CEPTEL1,C.IL,C.ILCE,C.ADRES,C.VERGI_DAIRESI,C.VERGINO,C.KIMLIKNO,C.EMAIL,C.ACIKLAMA,C.ACIKLAMA10,TIPI ORDER BY IL,ILCE,ADI';


  DB.cn_db._DoEof(SQL,
  procedure (dt:TDataSet)
  begin
    FCariID:=dt._I['ID'];
    FCariKodu:=dt._S['KOD'];
    FCariTipi:=dt._S['TIPI'];
    FUnvani:=dt._S['ADI'];
    FAdi:=dt._S['CARIADI'];
    FSoyAdi:=dt._S['CARISOYADI'];
    FTelefon:=dt._S['CEPTEL1'];
    FTCNo:=dt._S['KIMLIKNO'];
    FIL:=dt._S['IL'];
    FILCE:=dt._S['ILCE'];
    FAdres:=dt._S['ADRES'];
    FEMail:=dt._S['EMAIL'];
    arg:=dt._S['ACIKLAMA10'].Split([',']);
    if Length(arg)>0 then
    begin
      FEnlem:=arg[0]; FBoylam:=arg[1];
    end;




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
  s,AKonum:string;
begin
  Result:=False;
  if FCariID<1 then
  begin
    s:='INSERT INTO dbo.TBLCARISB (TIPI,KOD) VALUES ('+QuotedStr('Alýcý')+',CONVERT(VARCHAR(32), HashBytes(''MD5'', CONVERT(varchar(255), NEWID())), 2));'+sLineBreak+
    'select SCOPE_IDENTITY() as ID;';

    FCariID:=DB.cn_db._sqlResults(s,-2,'ID');
    FCariKodu:='Yeni Cari';
    FCariTipi:='Alýcý';
  end;
  if FCariID<1 then Exit;

  if (not FEnlem.IsEmpty) and (not FBoylam.IsEmpty) then
  AKonum:=',ACIKLAMA10='+QuotedStr(FEnlem+','+FBoylam) else AKonum:='';

  s:='UPDATE dbo.TBLCARISB SET '+
     ' ADI='+QuotedStr(FUnvani)+
     ',CARIADI='+QuotedStr(FAdi)+
     ',CARISOYADI='+QuotedStr(FSoyAdi)+
     ',TIPI='+QuotedStr(FCariTipi)+
     ',CEPTEL1='+QuotedStr(FTelefon)+
     ',KIMLIKNO='+QuotedStr(TCNo)+
     ',IL='+QuotedStr(FIL)+
     ',ILCE='+QuotedStr(FILCE)+
     //',CADDE='+QuotedStr(FUnvani)+
     ',ADRES='+QuotedStr(FAdres)+
     ',EMAIL='+QuotedStr(FEMail)+
     ',VERGI_DAIRESI='+QuotedStr(VergiDairesi)+
     ',VERGINO='+QuotedStr(FVergiNo)+
     ',ACIKLAMA='+QuotedStr(FAciklama.Text)+
       AKonum+
     ' WHERE ID = '+IntToStr(FCariID);

 try
     TDialogService.ShowMessage(AKonum);
     DB.cn_db.ExecSQL(s);
     Result:=True;
 except
    Result:=False;
 end;

end;



end.
