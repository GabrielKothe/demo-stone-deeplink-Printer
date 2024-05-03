unit View.Main;

interface

uses
  Stone.Deeplink,
  Stone.Deeplink.Component.Application,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Platform,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Objects,
  FMX.Layouts,
  FMX.Edit,
  FMX.ComboEdit,
  FMX.ListBox, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FMX.WebBrowser,
  Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Datasnap.DBClient,
  Datasnap.DSConnect, Data.SqlExpr, Data.FMTBcd, json, FMX.ExtCtrls;

type
  TMainView = class(TForm)
    StoneDeeplink: TStoneDeeplink;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    LayoutCancelation: TLayout;
    ButtonCancelation: TButton;
    LayoutCancelationATK: TLayout;
    TextCancelationATK: TText;
    EditCancelationATK: TEdit;
    LayoutCancelationAmount: TLayout;
    TextCancelationAmount: TText;
    EditCancelationAmount: TEdit;
    LayoutPayment: TLayout;
    ButtonPayment: TButton;
    LayoutPaymentAmount: TLayout;
    TextAmount: TText;
    EditPaymentAmount: TEdit;
    LayoutPaymentTransactionType: TLayout;
    TextPaymentTransactionType: TText;
    ComboBoxPaymentTransactionType: TComboBox;
    LayoutPaymentInstallmentType: TLayout;
    TextPaymentInstallmentType: TText;
    ComboBoxPaymentInstallmentType: TComboBox;
    LayoutPaymentInstallmentCount: TLayout;
    TextPaymentInstallmentCount: TText;
    ComboBoxPaymentInstallmentCount: TComboBox;
    LayoutPaymentEditableAmount: TLayout;
    TextPaymentEditableAmount: TText;
    SwitchPaymentEditableAmount: TSwitch;
    MemoOutput: TMemo;
    procedure ButtonPaymentClick(Sender: TObject);
    procedure ButtonCancelationClick(Sender: TObject);
    procedure StoneDeeplinkPaymentSuccess(const Sender: TObject;
      const APaymentReturn: IStoneDeeplinkPaymentReturnEntity);
    procedure StoneDeeplinkPaymentError(const Sender: TObject;
      const ACode: Integer; const AMessage: string);
    procedure StoneDeeplinkCancelationError(const Sender: TObject;
      const AReason, AResponseCode: string);
    procedure StoneDeeplinkCancelationSuccess(const Sender: TObject;
      const ACancelationReturn: IStoneDeeplinkCancelationReturnEntity);
    procedure EditAmountTap(Sender: TObject; const Point: TPointF);
    procedure EditAmountTyping(Sender: TObject);
    procedure EditAmountClick(Sender: TObject);
    procedure EditCancelationATKChange(Sender: TObject);
    procedure EditCancelationATKTyping(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
{$IFDEF ANDROID}
    procedure RePrint(TYPE_CUSTOMER: string);
    procedure SendPrint(Texto, ImageBase64: string);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
{$ENDIF}
  private
    { Private declarations }
    procedure LoadTransactionType;
    procedure LoadInstallmentType;
    procedure LoadInstallmentCount;
    procedure ResetAmount(const AEdit: TEdit);
    procedure FormatEditAmount(const AEdit: TEdit);
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

uses
{$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net,
{$ENDIF}
  System.Math,
  System.TypInfo,
  Stone.Deeplink.Enum.InstallmentType,
  Stone.Deeplink.Enum.TransactionType,
  Stone.Deeplink.Enum.EditableAmountType,
  Stone.Deeplink.Helper.Enum.InstallmentType,
  Stone.Deeplink.Helper.Enum.TransactionType,
  Stone.Deeplink.Helper.AmountType, System.NetEncoding,
  Stone.Deeplink.Types;

{$R *.fmx}

procedure TMainView.ButtonPaymentClick(Sender: TObject);
begin
  StoneDeeplink.ExecuteCallbacks := true;
  StoneDeeplink.CallPayment
    (TStoneDeeplinkPaymentEntityBuilder.New.SetInstallmentType
    (TStoneDeeplinkInstallmentType(ComboBoxPaymentInstallmentType.ItemIndex))
    .SetInstallmentCount(ComboBoxPaymentInstallmentCount.Selected.Text.
    ToInteger).SetAmount(TStoneDeeplinkAmount.FromString(EditPaymentAmount.Text)
    ).SetTransactionType(TStoneDeeplinkTransactionType
    (ComboBoxPaymentTransactionType.ItemIndex))
    .SetEditableAmount(TStoneDeeplinkEditableAmountType
    (SwitchPaymentEditableAmount.IsChecked.ToInteger)).Build);
end;

procedure TMainView.Button1Click(Sender: TObject);
begin
{$IFDEF ANDROID}
  RePrint('CLIENT');
{$ENDIF}
end;

procedure TMainView.Button2Click(Sender: TObject);
var
  ImageBase64: string;
begin
{$IFDEF ANDROID}
  ImageBase64 :=
    'iVBORw0KGgoAAAANSUhEUgAAAHcAAAAuCAAAAAA309lpAAACMklEQVRYw91YQXLDIAyUMj027Us606f6RL7lJP0I'
    + 'se/bg7ERSLLdZkxnyiVGIK0AoRVh0J+0l2ZITCAmSus8tYNNv9wUl8Xn2A6XZec8ts' +
    'K9lN0zEaFBCxMc0M3IoHawBAAxffLx9/frY1kkEV0/iYjC8bjjmSRuCrHjcXMoS9zD4/nqePNf10v2whrkDRjL'
    + 'R4t8BWPXbdyRmccDgBMZUXDiiv2DeSK4sKwWrfgIda8V/6L6blZvLMARTescAohCD7xlcsItjYXEXHn2LIESz'
    + 'O3mDARPYTJXwiQ/VgWFobsYGKRdRy5x6/1QuAPpKdq89MiTS1x9EBXuYJyVZd46p6nd' +
    'XVwAqfwJpd4C20uLk/LsUIilQ5Q11A4tuIU8Ti4bi8oz6lNX8iD8rNUdXDm3iMs81le4pUOLOJrGatzBx1VqVR'
    + 'SU8qAdNRc855GwHxcFblQbYTvqx3M0ZxZnZeBq+UoayI0h3y7QPMhOyQA9JMkO9aMIqs6Rmrw73T6ey9anvD'
    + 'X5kbinvT2PW7yYzj8ogrcYqBOJjNxc21d5EjmH0e/iaqUV9dXj3Y' +
    'gYtkvCjbjaqs5O+85MxVvwTcZdhR5YuFbckCSfNkHUolTcE9Cq9iQfXtV62bo9nUBIm8AXedPidimVFIjZCdYlT'
    + 'w4W8RtsatKC7Bt7D4t5tMle9qPD+y4uyL81FS/UnnVu3eMzhuj3G7CqzkHF77ISsaoraSsqVnRhq3rSZ+F5Ur//b'
    + '5zOOVoAwDc6szxdC+PYAAAAAABJRU5ErkJggg==';
  SendPrint('Teste', ImageBase64);
{$ENDIF}
end;

procedure TMainView.Button3Click(Sender: TObject);
begin
{$IFDEF ANDROID}
  RePrint('MERCHANT');
{$ENDIF}
end;

procedure TMainView.ButtonCancelationClick(Sender: TObject);
begin
StoneDeeplink.ExecuteCallbacks := true;
  StoneDeeplink.CallCancelation
    (TStoneDeeplinkCancelationEntityBuilder.New.SetAmount
    (TStoneDeeplinkAmount.FromString(EditCancelationAmount.Text))
    .SetATK(EditCancelationATK.Text).SetEditableAmount
    (TStoneDeeplinkEditableAmountType.Uneditable).Build);
end;

procedure TMainView.EditAmountTap(Sender: TObject; const Point: TPointF);
begin
  EditAmountClick(Sender);
end;

procedure TMainView.EditAmountTyping(Sender: TObject);
begin
  FormatEditAmount(TEdit(Sender));
end;

procedure TMainView.EditCancelationATKChange(Sender: TObject);
begin
  ButtonCancelation.Enabled := not EditCancelationATK.Text.IsEmpty;
end;

procedure TMainView.EditCancelationATKTyping(Sender: TObject);
begin
  EditCancelationATKChange(Sender);
end;

procedure TMainView.FormatEditAmount(const AEdit: TEdit);
begin
  AEdit.Text := FormatCurr('##0.00',
    ('0' + AEdit.Text.Replace('.', EmptyStr).Replace(',', EmptyStr))
    .ToDouble / 100);
  AEdit.CaretPosition := AEdit.Text.Length;
end;

procedure TMainView.FormCreate(Sender: TObject);
begin
  ResetAmount(EditPaymentAmount);
  ResetAmount(EditCancelationAmount);
  LoadTransactionType;
  LoadInstallmentType;
  LoadInstallmentCount;
end;

procedure TMainView.EditAmountClick(Sender: TObject);
begin
  ResetAmount(TEdit(Sender));
end;

procedure TMainView.LoadInstallmentCount;
var
  LStoneDeeplinkInstallmentCount: TStoneDeeplinkInstallmentCount;
begin
  ComboBoxPaymentInstallmentCount.Clear;
  for LStoneDeeplinkInstallmentCount := Low(TStoneDeeplinkInstallmentCount)
    to High(TStoneDeeplinkInstallmentCount) do
    ComboBoxPaymentInstallmentCount.Items.Add
      (Byte(LStoneDeeplinkInstallmentCount).ToString);
  ComboBoxPaymentInstallmentCount.ItemIndex :=
    ComboBoxPaymentInstallmentCount.Items.IndexOf
    (Low(LStoneDeeplinkInstallmentCount).ToString);
end;

procedure TMainView.LoadInstallmentType;
var
  LStoneDeeplinkInstallmentType: TStoneDeeplinkInstallmentType;
begin
  ComboBoxPaymentInstallmentType.Clear;
  for LStoneDeeplinkInstallmentType := Low(TStoneDeeplinkInstallmentType)
    to High(TStoneDeeplinkInstallmentType) do
    ComboBoxPaymentInstallmentType.Items.Add
      (LStoneDeeplinkInstallmentType.ToString);
  ComboBoxPaymentInstallmentType.ItemIndex :=
    ComboBoxPaymentInstallmentType.Items.IndexOf
    (TStoneDeeplinkInstallmentType.None.ToString);
end;

procedure TMainView.LoadTransactionType;
var
  LStoneDeeplinkTransactionType: TStoneDeeplinkTransactionType;
begin
  ComboBoxPaymentTransactionType.Clear;
  for LStoneDeeplinkTransactionType := Low(TStoneDeeplinkTransactionType)
    to High(TStoneDeeplinkTransactionType) do
    ComboBoxPaymentTransactionType.Items.Add
      (LStoneDeeplinkTransactionType.ToString);
  ComboBoxPaymentTransactionType.ItemIndex :=
    ComboBoxPaymentTransactionType.Items.IndexOf
    (TStoneDeeplinkTransactionType.Debit.ToString);
end;

{$IFDEF ANDROID}

procedure TMainView.SendPrint(Texto, ImageBase64: string);
var
  Intent: JIntent;
  UriBuilder: JUri_Builder;
  jsonArray: TJSONArray;
  jsonObject: TJSONObject;
  jsonString: string;

  imgStream: TMemoryStream;
  Bytes: TBytes; // Array de bytes
  Imagem: TBitmap;
  ImagemBase64: string;
  ImagemRedimensionada: TBitmap;
begin
//Para a impressão funcionar a POS deve estar na versao bundle 7.4.5
// https://stone-partnerprogram.helpjuice.com/pt_BR/terminais/atualiza%C3%A7%C3%A3o-do-bundle-de-apps-stone-debug

  Try
    jsonArray := TJSONArray.Create;

    //tipos de textos
    jsonObject := TJSONObject.Create;
    jsonObject.AddPair('type', 'text');
    jsonObject.AddPair('content', Texto);
    jsonObject.AddPair('align', 'center');
    jsonObject.AddPair('size', 'big');
    jsonArray.AddElement(jsonObject);

    jsonObject := TJSONObject.Create;
    jsonObject.AddPair('type', 'text');
    jsonObject.AddPair('content', Texto);
    jsonObject.AddPair('align', 'right');
    jsonObject.AddPair('size', 'medium');
    jsonArray.AddElement(jsonObject);

    jsonObject := TJSONObject.Create;
    jsonObject.AddPair('type', 'text');
    jsonObject.AddPair('content', Texto);
    jsonObject.AddPair('align', 'left');
    jsonObject.AddPair('size', 'small');
    jsonArray.AddElement(jsonObject);

    jsonObject := TJSONObject.Create;
    jsonObject.AddPair('type', 'line');
    jsonObject.AddPair('content', Texto);
    jsonArray.AddElement(jsonObject);


    // Adiciona o quinto objeto com imagem em base64
    jsonObject := TJSONObject.Create;
    jsonObject.AddPair('type', 'image');
    jsonObject.AddPair('imagePath', ImageBase64);
    jsonArray.AddElement(jsonObject);

    jsonString := jsonArray.ToString;

    // Libera o recurso do array JSON
    jsonArray.Free;

    UriBuilder := TJUri_Builder.JavaClass.init;
    UriBuilder.authority(StringToJString('print'));
    UriBuilder.scheme(StringToJString('printer-app'));
    UriBuilder.appendQueryParameter(StringToJString('SCHEME_RETURN'),
      StringToJString('demo_stone_deeplink'));
    UriBuilder.appendQueryParameter(StringToJString('SHOW_FEEDBACK_SCREEN'),
      StringToJString('true'));
    UriBuilder.appendQueryParameter(StringToJString('PRINTABLE_CONTENT'),
      StringToJString(jsonString));

    Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
      UriBuilder.Build);
    Intent.addFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NEW_TASK);
    SharedActivity.startActivity(Intent);
  Except
    on E: Exception do
      ShowMessage(E.Message);
  End;

end;

procedure TMainView.RePrint(TYPE_CUSTOMER: string);
var
  Intent: JIntent;
  UriBuilder: JUri_Builder;
begin
  StoneDeeplink.ExecuteCallbacks := true;
  try
    UriBuilder := TJUri_Builder.JavaClass.init;
    UriBuilder.authority(StringToJString('reprint'));
    UriBuilder.scheme(StringToJString('reprinter-app'));
    UriBuilder.appendQueryParameter(StringToJString('SCHEME_RETURN'),
      StringToJString('demo_stone_deeplink'));
    UriBuilder.appendQueryParameter(StringToJString('SHOW_FEEDBACK_SCREEN'),
      StringToJString('true'));
    UriBuilder.appendQueryParameter(StringToJString('ATK'),
      StringToJString(EditCancelationATK.Text));
    UriBuilder.appendQueryParameter(StringToJString('TYPE_CUSTOMER'),
      StringToJString(TYPE_CUSTOMER));

    Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
      UriBuilder.Build);
    Intent.addFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NEW_TASK);
    SharedActivity.startActivity(Intent);
  Except
    on E: Exception do
      ShowMessage(E.Message);
  End;
end;
{$ENDIF}

procedure TMainView.ResetAmount(const AEdit: TEdit);
begin
  AEdit.Text := FormatCurr('##0.00', 0);
  AEdit.CaretPosition := AEdit.Text.Length;
end;

procedure TMainView.StoneDeeplinkCancelationError(const Sender: TObject;
  const AReason, AResponseCode: string);
begin
  StoneDeeplink.ExecuteCallbacks := false;
  ShowMessage(Format('[reason: %s] [response_code: %s] Error when canceling',
    [AReason, AResponseCode]));
end;

procedure TMainView.StoneDeeplinkCancelationSuccess(const Sender: TObject;
  const ACancelationReturn: IStoneDeeplinkCancelationReturnEntity);
begin
  StoneDeeplink.ExecuteCallbacks := false;
  MemoOutput.Lines.Add('CANCELATION');
  MemoOutput.Lines.Add('ATK:                         ' +
    ACancelationReturn.GetATK.ToString);
  MemoOutput.Lines.Add('CANCELED AMOUNT:             ' +
    ACancelationReturn.GetCanceledAmount.ToFormatCurr);
  MemoOutput.Lines.Add('PAYMENT TYPE:                ' +
    ACancelationReturn.GetPaymentType.ToString);
  MemoOutput.Lines.Add('TRANSACTION AMOUNT:          ' +
    ACancelationReturn.GetTransactionAmount.ToFormatCurr);
  MemoOutput.Lines.Add('AUTHORIZATION CODE:          ' +
    ACancelationReturn.GetAuthorizationCode.ToString);
  MemoOutput.Lines.Add('REASON:                      ' +
    ACancelationReturn.GetReason);
  MemoOutput.Lines.Add('RESPONSE CODE:               ' +
    ACancelationReturn.GetResponseCode);
  MemoOutput.Lines.Add
    ('------------------------------------------------------------');
end;

procedure TMainView.StoneDeeplinkPaymentError(const Sender: TObject;
  const ACode: Integer; const AMessage: string);
begin
  StoneDeeplink.ExecuteCallbacks := false;
  ShowMessage(Format('[code: %s] [message: %s] Error when making payment',
    [ACode.ToString, AMessage]));
end;

procedure TMainView.StoneDeeplinkPaymentSuccess(const Sender: TObject;
  const APaymentReturn: IStoneDeeplinkPaymentReturnEntity);
begin
  StoneDeeplink.ExecuteCallbacks := false;
  EditCancelationATK.Text := APaymentReturn.GetATK;
  EditCancelationAmount.Text := APaymentReturn.GetAmount.ToFormatCurr;

  MemoOutput.Lines.Add('PAYMENT');
  MemoOutput.Lines.Add('AMOUNT:                      ' +
    APaymentReturn.GetAmount.ToFormatCurr);
  MemoOutput.Lines.Add('CARDHOLDER NAME:             ' +
    APaymentReturn.GetCardholderName);
  MemoOutput.Lines.Add('ITK:                         ' + APaymentReturn.GetITK);
  MemoOutput.Lines.Add('ATK:                         ' + APaymentReturn.GetATK);
  MemoOutput.Lines.Add('AUTHORIZATION DATETIME:      ' +
    DateTimeToStr(APaymentReturn.GetAuthorizationDateTime));
  MemoOutput.Lines.Add('BRAND:                       ' +
    APaymentReturn.GetBrand);
  MemoOutput.Lines.Add('AUTHORIZATION CODE:          ' +
    APaymentReturn.GetAuthorizationCode);
  MemoOutput.Lines.Add('TYPE:                        ' +
    APaymentReturn.GetType.ToString);
  MemoOutput.Lines.Add
    ('------------------------------------------------------------');
end;

end.
