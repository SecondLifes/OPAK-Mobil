unit Genel;

interface
 uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, Generics.Collections, uSkinItems, uSkinFireMonkeyPullLoadPanel,
  uSkinCustomListType, uSkinVirtualListType, uSkinListBoxType,
  uDrawPicture, System.UIConsts,
  uSkinFireMonkeyListBox, System.Rtti, Data.DB, MemDS, DBAccess, Uni;


type
 {$REGION 'BaseClass'}

   IGetOrSetValue = interface
      ['{827136D8-7933-4EBA-ACB1-5791232EC5E2}']
      function GetValue(const Index: Integer): TValue;
      procedure SetValue(const Index: Integer; const Value: TValue);
      procedure UpdateItemValue;
    end;

    TItemBase = class(TSkinListBoxItem, IGetOrSetValue)
    strict private
    private
      OnUpdateItem: TProc<TItemBase>;
    public
      function GetValue(const Index: Integer): TValue; virtual; abstract;
      procedure SetValue(const Index: Integer; const Value: TValue); virtual; abstract;
      procedure UpdateItemValue; virtual; abstract;
      procedure AfterConstruction; override;
    end;

   TBaseLoader<T: class> = class
    private
      //TListBoxProperties;
      //propViwer: TListViewProperties;

    public
       FrameValue:IGetOrSetValue;
       prop: TVirtualListProperties;

      constructor Create(AProp: TVirtualListProperties;const AFrameValue:IGetOrSetValue=nil);
      procedure Clear(const ALoadDB:Boolean=False); virtual;
      function GetProp<C:class>:C;
      procedure DoUpdateItem(AItems: TItemBase); virtual;
      procedure LoadDB(const AFiltre: string = ''; AClearFiltre: Boolean = False); virtual;
      function GetIdx(const AIndex:Integer):T;
      function AddNewItem: T;
      function Selected: T;
      //function EOF( const AProc:TProc<T>):T;
      function FindTag(const ATag:Integer): T;
      //function FindTag1: T;
      procedure AfterConstruction; override;

    end;

 {$ENDREGION}

 TCari = class(TItemBase)
  private
    FBorc,FAlacak:Extended;
    FIL,FILCE:string;
    function GetValue(const Index: Integer): TValue; override;
    procedure SetValue(const Index: Integer; const Value: TValue); override;
    procedure UpdateItemValue; override;
  public

    property CariID  :TValue Index 0 read GetValue write SetValue;
    property CariAdi :TValue Index 1 read GetValue write SetValue;
    property CariTel :TValue Index 2 read GetValue write SetValue;
    property CariILI :TValue Index 3 read GetValue write SetValue;
    property CariIlce:TValue Index 4 read GetValue write SetValue;
    property CariBorc:TValue Index 5 read GetValue write SetValue;
    property CariAlacak:TValue Index 6 read GetValue write SetValue;
    property CariBakiye:TValue Index 7 read GetValue;

  end;


   TCariListe = Class(TBaseLoader<TCari>)
   public
     procedure LoadDB(const AFiltre: string = ''; AClearFiltre: Boolean = False); override;
     //procedure ClearDrum;
   End;


  TPropHelp = class helper for TVirtualListProperties
    procedure FilterTag1(const ATag:Integer);
    function FindTag<T: TBaseSkinItem>(const ATag: Integer; const ADefault: Integer = 1): T;
  end;

    var
    CariList:TCariListe;
  //intrface
 //  ISepet:IGetOrSetValue;

 implementation
 uses DBOpak,sdk,Help.DB,Help.uni,uGraphicCommon,uUIFunction,StrUtils,FMX.DialogService,DateUtils;


  function cn: TUniConnection;
    begin
      //if DB.cn_db.Connected then
      Result := DB.cn_db;


    end;
    { TPropHelp }

procedure TPropHelp.FilterTag1(const ATag: Integer);
var
 i:integer;
begin
   Self.Items.BeginUpdate;

   for i := 0 to Items.Count -1 do
     Items.Items[i].Visible:=(Items.Items[i].Tag1=ATag) or (ATag =-1);

   Self.Items.EndUpdate();
end;

function TPropHelp.FindTag<T>(const ATag, ADefault: Integer): T;
var
  i: Integer;
begin

  for i := 0 to self.Items.Count - 1 do
  begin
    if self.Items.Items[i].Tag = ATag then
      Exit(self.Items.Items[i] as T);
  end;
  Result := T(self.Items.Items[0]);

end;

{ TItemBase }

 {$REGION 'Base Class'}

   procedure TItemBase.AfterConstruction;
   begin
    inherited AfterConstruction;
    OnUpdateItem := nil;
   end;

   { TBaseLoader<T> }

   function TBaseLoader<T>.AddNewItem: T;
   begin
    Result := prop.Items.Add as T;
    TItemBase(Result).OnUpdateItem := Self.DoUpdateItem;
   end;

   procedure TBaseLoader<T>.AfterConstruction;
   begin


   end;

   procedure TBaseLoader<T>.Clear(const ALoadDB: Boolean);
   begin

     prop.Items.BeginUpdate;
     prop.Items.Clear();
     if ALoadDB then LoadDB();
     prop.Items.EndUpdate();


   end;



constructor TBaseLoader<T>.Create(AProp: TVirtualListProperties;const AFrameValue:IGetOrSetValue=nil);
   begin
    //TSkinVirtualList(prop).Parent

     AProp.Items.BeginUpdate;
     AProp.Items.Clear();
     AProp.Items.EndUpdate(True);

    FrameValue:=AFrameValue;
    prop := AProp;
    AProp.Items.SkinItemClass := TBaseSkinItemClass(T);
   end;

   procedure TBaseLoader<T>.DoUpdateItem(AItems: TItemBase);
   begin

   end;





function TBaseLoader<T>.FindTag(const ATag: Integer): T;
   var
    i:Integer;
begin
   Result:=nil;
   for i := prop.Items.Count -1 downto 0 do
    if prop.Items.Items[i].Tag = ATag then
    begin
    Result:= prop.Items.Items[i] as T;
      exit ;
    end;


end;

function TBaseLoader<T>.GetIdx(const AIndex: Integer): T;
   begin
    Result:=nil;
     if prop.Items.Count>=AIndex then      
    Result:=prop.Items.Items[AIndex] as T ;
   end;

   function TBaseLoader<T>.GetProp<C>: C;
   begin
    Result:=prop as c;
   end;

   procedure TBaseLoader<T>.LoadDB(const AFiltre: string; AClearFiltre: Boolean);
   begin

   end;

   function TBaseLoader<T>.Selected: T;
   begin
    Result := prop.InteractiveItem as T;
   end;

 {$ENDREGION}




{ TCari }
   (*
    property CariID  :TValue Index 0 read GetValue write SetValue;
    property CariAdi :TValue Index 1 read GetValue write SetValue;
    property CariTel :TValue Index 2 read GetValue write SetValue;
    property CariILI :TValue Index 3 read GetValue write SetValue;
    property CariIlce:TValue Index 4 read GetValue write SetValue;
    property CariBakiye:TValue Index 5 read GetValue write SetValue;
    *)
function TCari.GetValue(const Index: Integer): TValue;
begin
    case Index of
      0:Result:=Self.Tag;
      1:Result:=Self.Caption;
      2:Result:=Self.Detail;
      3:Result:=FIL;
      4:Result:=FILCE;
      5:Result:=FBorc;
      6:Result:=FAlacak;
      7:Result:=FBorc-FAlacak;
    end;
end;

procedure TCari.SetValue(const Index: Integer; const Value: TValue);
begin
    case Index of
     0:Self.Tag:=Value.AsInteger;
     1:Self.Caption:=Value.AsString;
     2:Self.Detail:=Value.AsString;
     3:FIL:=Value.AsString;
     4:FILCE:=Value.AsString;
     5:FBorc:=Value.AsExtended;
     6:FAlacak:=Value.AsExtended;

    end;
end;

procedure TCari.UpdateItemValue;
var
TempStr:string;
begin
 TempStr:='';
 if not FIL.IsEmpty and not FILCE.IsEmpty then TempStr:='/';
Self.Detail1:=FIL+TempStr+FILCE;
Self.Detail6:=Cur2Str(CariBakiye.AsExtended);
     if CariBakiye.AsExtended > 0 then Color:=claTomato
else if CariBakiye.AsExtended < 0 then Color:=claYellowgreen;

end;

{ TCariListe }


procedure TCariListe.LoadDB(const AFiltre: string; AClearFiltre: Boolean);
var
 s,TempStr:string;
begin
  prop.Items.BeginUpdate;
  prop.Items.Clear();
  s:='SELECT C.ID, C.KOD,C.ADI,C.CARIADI,C.CARISOYADI,C.CEPTEL1,C.IL,C.ILCE,'+
  'SUM(HR.BORC) AS BORC,SUM(HR.ALACAK) AS ALACAK FROM dbo.TBLCARIHAR HR INNER JOIN TBLCARISB C ON (HR.CARIID = C.ID)'+sLineBreak+
  'WHERE TIPI IN(''Alýcý'',''Satýcý'',''Alýcý ve Satýcý'',''Perakende'')';
  if not AFiltre.IsEmpty then
  begin
    s:=Concat('DECLARE @flt VARCHAR(MAX) ='+QuotedStr('%'+AFiltre.Trim+'%')+'; ',sLineBreak,s,sLineBreak,
    'and KOD LIKE @flt or ADI LIKE @flt or CEPTEL1 LIKE @flt or CARIADI LIKE @flt or CARISOYADI LIKE @flt');
  end;

  //Alýcý,Satýcý,Alýcý ve Satýcý,Perakende,Toptan,Muhtelif,Masraf
  s:=Concat(s,sLineBreak,'GROUP BY C.ID,C.KOD,C.ADI,C.CARIADI,C.CARISOYADI,C.CEPTEL1,C.IL,C.ILCE ORDER BY IL,ILCE,ADI');
  try
   cn._DoEof(s,
 procedure (dt:TDataSet)
 begin
     with Self.AddNewItem do
       begin

         CariID:=dt._I['ID'];
         TempStr:=tr_TR(dt._S['CARIADI'].Trim,TR_Case.TR_ilk)+' '+tr_TR(dt._S['CARISOYADI'].Trim,TR_Case.TR_ilk);
         if not TempStr.Trim.IsEmpty then TempStr:='-('+TempStr+')';
         CariAdi:=dt._S['ADI'].Trim+TempStr;
         CariTel:=dt._S['CEPTEL1'];
         CariILI:=dt._S['IL'].Trim;;
         CariIlce:=dt._S['ILCE'].Trim;
         CariBorc:=dt._D['BORC'];
         CariAlacak:=dt._D['ALACAK'];
         UpdateItemValue;



       end;
 end

);
  finally
    prop.Items.EndUpdate();
 end;

end;

initialization

finalization

end.
