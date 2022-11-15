unit Genel;

interface
 uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, Generics.Collections, uSkinItems, uSkinFireMonkeyPullLoadPanel,
  uSkinCustomListType, uSkinVirtualListType, uSkinListBoxType,
  uDrawPicture,
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
    FBakiye:Extended;
    function GetValue(const Index: Integer): TValue; override;
    procedure SetValue(const Index: Integer; const Value: TValue); override;
  public

    property CariID  :TValue Index 0 read GetValue write SetValue;
    property CariAdi :TValue Index 1 read GetValue write SetValue;
    property CariTel :TValue Index 2 read GetValue write SetValue;
    property CariILI :TValue Index 3 read GetValue write SetValue;
    property CariIlce:TValue Index 4 read GetValue write SetValue;
    property CariBakiye:TValue Index 5 read GetValue write SetValue;
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
 uses DBOpak,Help.DB,Help.uni,uGraphicCommon,uUIFunction,UIConsts,StrUtils,FMX.DialogService,sdk,DateUtils;


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
      3:Result:=Self.Detail1;
      4:Result:=Self.Detail2;
      5:Result:=FBakiye;
    end;
end;

procedure TCari.SetValue(const Index: Integer; const Value: TValue);
begin
    case Index of
     0:Self.Tag:=Value.AsInteger;
     1:Self.Caption:=Value.AsString;
     2:Self.Detail:=Value.AsString;
     3:Self.Detail1:=Value.AsString;
     4:Self.Detail2:=Value.AsString;
     5:begin FBakiye:=Value.AsExtended; Self.Detail6:=Cur2Str(FBakiye); end;

    end;
end;

{ TCariListe }


procedure TCariListe.LoadDB(const AFiltre: string; AClearFiltre: Boolean);
begin
  prop.Items.BeginUpdate;
prop.Items.Clear();

  try
   cn._DoEof('select ID,KOD,ADI,CEPTEL1,IL,ILCE from TBLCARISB order by IL,ILCE',
 procedure (dt:TDataSet)
 begin
     with Self.AddNewItem do
       begin
         CariID:=dt._I['ID'];
         CariAdi:=dt._S['ADI'];
         CariTel:=dt._S['CEPTEL1'];
         CariILI:=dt._S['IL'];;
         CariIlce:=dt._S['ILCE'];
         //CariBakiye:=dt._S['GrupRengi'];
         //CariILI:=SkinThemeColor1;
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
