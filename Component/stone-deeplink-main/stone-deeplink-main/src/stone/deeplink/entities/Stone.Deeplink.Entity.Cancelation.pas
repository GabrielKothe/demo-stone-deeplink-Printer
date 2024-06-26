unit Stone.Deeplink.Entity.Cancelation;

interface

uses
  Stone.Deeplink.Contract.Entity.Cancelation,
  Stone.Deeplink.Types,
  Stone.Deeplink.Enum.EditableAmountType;

type

  TStoneDeeplinkCancelationEntity = class(TInterfacedObject, IStoneDeeplinkCancelationEntity)
  strict private
    { strict private declarations }
    constructor Create;
  private
    { private declarations }
    FAmount: TStoneDeeplinkAmount;
    FATK: string;
    FEditableAmount: TStoneDeeplinkEditableAmountType;
    FReturnScheme: string;
  protected
    { protected declarations }
  public
    { public declarations }
    function GetAmount: TStoneDeeplinkAmount;
    procedure SetAmount(const AAmount: TStoneDeeplinkAmount);
    function GetATK: string;
    procedure SetATK(const AATK: string);
    function GetEditableAmount: TStoneDeeplinkEditableAmountType;
    procedure SetEditableAmount(const AEditableAmount: TStoneDeeplinkEditableAmountType);
    function GetReturnScheme: string;
    procedure SetReturnScheme(const AReturnScheme: string);
    class function New: IStoneDeeplinkCancelationEntity;
  end;

implementation

{ TStoneDeeplinkCancelationEntity }

constructor TStoneDeeplinkCancelationEntity.Create;
begin

end;

function TStoneDeeplinkCancelationEntity.GetAmount: TStoneDeeplinkAmount;
begin
  Result := FAmount;
end;

function TStoneDeeplinkCancelationEntity.GetATK: string;
begin
  Result := FATK;
end;

function TStoneDeeplinkCancelationEntity.GetEditableAmount: TStoneDeeplinkEditableAmountType;
begin
  Result := FEditableAmount;
end;

function TStoneDeeplinkCancelationEntity.GetReturnScheme: string;
begin
  Result := FReturnScheme;
end;

class function TStoneDeeplinkCancelationEntity.New: IStoneDeeplinkCancelationEntity;
begin
  Result := Self.Create;
end;

procedure TStoneDeeplinkCancelationEntity.SetAmount(const AAmount: TStoneDeeplinkAmount);
begin
  FAmount := AAmount;
end;

procedure TStoneDeeplinkCancelationEntity.SetATK(const AATK: string);
begin
  FATK := AATK;
end;

procedure TStoneDeeplinkCancelationEntity.SetEditableAmount(const AEditableAmount: TStoneDeeplinkEditableAmountType);
begin
  FEditableAmount := AEditableAmount;
end;

procedure TStoneDeeplinkCancelationEntity.SetReturnScheme(const AReturnScheme: string);
begin
  FReturnScheme := AReturnScheme;
end;

end.
