unit uCadMetas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, uDM;

type
  TfrmCadMetas = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnSair: TBitBtn;
    edtProcurar: TEdit;
    dbnMetas: TDBNavigator;
    dbgMetas: TDBGrid;
    Label2: TLabel;
    dbeNome: TDBEdit;
    Label6: TLabel;
    dblcbSituacao: TDBLookupComboBox;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    Label3: TLabel;
    Label5: TLabel;
    dbeInicial: TMaskEdit;
    dbeFinal: TMaskEdit;
    Label7: TLabel;
    dbeValorInicial: TDBEdit;
    Label8: TLabel;
    dbeValorFinal: TDBEdit;
    Label9: TLabel;
    dbeValorAtual: TDBEdit;
    Label10: TLabel;
    dbeAtualizacao: TMaskEdit;
    Label11: TLabel;
    Label4: TLabel;
    dbeObservacao: TDBEdit;
    dbePctAtingido: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtProcurarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgMetasCellClick(Column: TColumn);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbnMetasClick(Sender: TObject; Button: TNavigateBtn);
    procedure dbeValorFinalExit(Sender: TObject);
    procedure dbeValorAtualExit(Sender: TObject);
  private
    { Private declarations }
    function DataOk(Dt:String):Boolean;
    procedure CalculaMeta;
    //procedure PesquisaRegistro;
  public
    { Public declarations }
  end;

var
  frmCadMetas: TfrmCadMetas;
  Result : boolean;
  carteira : integer;
  valor_atual, valor_final, pct_atual : double;

implementation

{$R *.dfm}

procedure TfrmCadMetas.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSMeta.Open;
  DMPrincipal.ADODSSitMeta.Open;

  dbeNome.Enabled := false;
  dblcbSituacao.Enabled := false;
  dbeInicial.Enabled := false;
  dbeFinal.Enabled := false;
  dbeValorInicial.Enabled := false;
  dbeValorFinal.Enabled := false;
  dbeValorAtual.Enabled := false;
  //dbePctAtingido.Enabled := false;
  dbeAtualizacao.Enabled := false;
  dbeObservacao.Enabled := false;

  dbeInicial.Text := DMPrincipal.ADODSMetaDAT_INICIAL.AsString;
  dbeFinal.Text := DMPrincipal.ADODSMetaDAT_FINAL.AsString;
  dbeAtualizacao.Text := DMPrincipal.ADODSMetaDAT_ATUALIZACAO.AsString;
  dbePctAtingido.Text := DMPrincipal.ADODSMetaPCT_ATINGIDO.AsString;
end;

procedure TfrmCadMetas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSMeta.Close;
  DMPrincipal.ADODSSitMeta.Close;

  DMPrincipal.ADODSMeta.Close;
  DMPrincipal.ADODSMeta.CommandText := 'select * from t_meta';
  Action := caFree;

  frmCadMetas := nil;
end;

procedure TfrmCadMetas.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
end;

procedure TfrmCadMetas.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadMetas := nil;
end;

procedure TfrmCadMetas.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DMPrincipal.ADODSMeta.Close;
  DMPrincipal.ADODSMeta.CommandText := 'select * from t_meta where dsc_meta like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSMeta.Open;
end;

procedure TfrmCadMetas.dbgMetasCellClick(Column: TColumn);
begin
  dbeInicial.Text := DMPrincipal.ADODSMetaDAT_INICIAL.AsString;
  dbeFinal.Text := DMPrincipal.ADODSMetaDAT_FINAL.AsString;
  dbeAtualizacao.Text := DMPrincipal.ADODSMetaDAT_ATUALIZACAO.AsString;
  dbePctAtingido.Text := DMPrincipal.ADODSMetaPCT_ATINGIDO.AsString;
end;

procedure TfrmCadMetas.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSMeta.Open;
  DMPrincipal.ADODSMeta.Append;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.Enabled := true;
  dblcbSituacao.Enabled := true;
  dbeInicial.Enabled := true;
  dbeFinal.Enabled := true;
  dbeValorInicial.Enabled := true;
  dbeValorFinal.Enabled := true;
  dbeValorAtual.Enabled := true;
  //dbePctAtingido.Enabled := true;
  dbeAtualizacao.Enabled := true;
  dbeObservacao.Enabled := true;

  dbeAtualizacao.Text := DateToStr(Date());

  dbeInicial.Clear;
  dbeFinal.Clear;
  dbeAtualizacao.Clear;
  dbePctAtingido.Clear;

  dbeNome.SetFocus;
end;

procedure TfrmCadMetas.btnSalvarClick(Sender: TObject);
begin

  if DataOk(dbeInicial.Text) then
    result := true
  else
    result := false;

  if not Result then
  begin
    ShowMessage('Não é uma data válida!');
    exit;
    dbeInicial.SetFocus;
  end;

  if DataOk(dbeFinal.Text) then
    result := true
  else
    result := false;

  if not Result then
  begin
    ShowMessage('Não é uma data válida!');
    exit;
    dbeFinal.SetFocus;
  end;

  if DataOk(dbeAtualizacao.Text) then
    result := true
  else
    result := false;

  if not Result then
  begin
    ShowMessage('Não é uma data válida!');
    exit;
    dbeAtualizacao.SetFocus;
  end;

  DMPrincipal.ADODSMeta.FieldByName('dat_inicial').Value := FormatDateTime('yyyy-MM-dd',StrToDate(dbeInicial.Text));
  DMPrincipal.ADODSMeta.FieldByName('dat_final').Value := FormatDateTime('yyyy-MM-dd',StrToDate(dbeFinal.Text));
  DMPrincipal.ADODSMeta.FieldByName('dat_atualizacao').Value := FormatDateTime('yyyy-MM-dd',StrToDate(dbeAtualizacao.Text));
  DMPrincipal.ADODSMeta.FieldByName('pct_atingido').AsFloat := StrToFloat(dbePctAtingido.Text);
  //DMPrincipal.ADODSMeta.FieldByName('pct_atingido').AsFloat := pct_atual;

  // Salva...
  try
    DMPrincipal.ADODSMeta.Post;
    ShowMessage('Operação efetuada com sucesso!');
  except
      on E:exception do
        begin
          ShowMessage('Erro ao inserir registro');
          exit;
        end;
  end;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.Enabled := false;
  dblcbSituacao.Enabled := false;
  dbeInicial.Enabled := false;
  dbeFinal.Enabled := false;
  dbeValorInicial.Enabled := false;
  dbeValorFinal.Enabled := false;
  dbeValorAtual.Enabled := false;
  //dbePctAtingido.Enabled := false;
  dbeAtualizacao.Enabled := false;
  dbeObservacao.Enabled := false;

  DMPrincipal.ADODSMeta.Close;
  DMPrincipal.ADODSMeta.CommandText := 'select * from t_meta';
  DMPrincipal.ADODSMeta.Open;

  dbeInicial.Text := DMPrincipal.ADODSMetaDAT_INICIAL.AsString;
  dbeFinal.Text := DMPrincipal.ADODSMetaDAT_FINAL.AsString;
  dbeAtualizacao.Text := DMPrincipal.ADODSMetaDAT_ATUALIZACAO.AsString;
  dbePctAtingido.Text := DMPrincipal.ADODSMetaPCT_ATINGIDO.AsString;
end;

procedure TfrmCadMetas.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSMeta.Open;
  DMPrincipal.ADODSMeta.Edit;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.Enabled := true;
  dblcbSituacao.Enabled := true;
  dbeInicial.Enabled := true;
  dbeFinal.Enabled := true;
  dbeValorInicial.Enabled := true;
  dbeValorFinal.Enabled := true;
  dbeValorAtual.Enabled := true;
  //dbePctAtingido.Enabled := true;
  dbeAtualizacao.Enabled := true;
  dbeObservacao.Enabled := true;

  dbeNome.SetFocus;
end;

procedure TfrmCadMetas.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSMeta.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.Enabled := false;
  dblcbSituacao.Enabled := false;
  dbeInicial.Enabled := false;
  dbeFinal.Enabled := false;
  dbeValorInicial.Enabled := false;
  dbeValorFinal.Enabled := false;
  dbeValorAtual.Enabled := false;
  //dbePctAtingido.Enabled := false;
  dbeAtualizacao.Enabled := false;
  dbeObservacao.Enabled := false;

  DMPrincipal.ADODSMeta.Close;
  DMPrincipal.ADODSMeta.CommandText := 'select * from t_meta';
  DMPrincipal.ADODSMeta.Open;

  dbeInicial.Text := DMPrincipal.ADODSMetaDAT_INICIAL.AsString;
  dbeFinal.Text := DMPrincipal.ADODSMetaDAT_FINAL.AsString;
  dbeAtualizacao.Text := DMPrincipal.ADODSMetaDAT_ATUALIZACAO.AsString;
  dbePctAtingido.Text := DMPrincipal.ADODSMetaPCT_ATINGIDO.AsString;
end;

procedure TfrmCadMetas.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSMeta.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSMeta.Delete;
  end;
end;

function TfrmCadMetas.DataOk(Dt:String):Boolean;
var
  Dia,Mes:Byte;
  Ano:Integer;
      function AnoBissesto(Year :Integer): boolean ;
      begin
         AnoBissesto:=(ano mod 4=0) and ( ano mod 100 <> 0) or (ano Mod 400 =0);
      end;
begin
 Result:=False;
 if length(Trim(Dt)) = 10 then
 begin
        Dia:=StrToIntDef(Copy(Dt,1,2),0);
        Mes:=StrToIntDef(Copy(Dt,4,2),0);
        Ano:=StrToInt(Copy(Dt,7,4));
        if ( (Mes in [1,3,5,7,8,10,12]) and (Dia in [1..31]) ) or
           ( (Mes in [4,6,9,11]) and (Dia in [1..30])        ) or
           ( (Mes = 2) and  (     AnoBissesto(Ano))  and  (Dia in [1..29]) )  or
           ( (Mes = 2) and  (not  AnoBissesto(Ano))  and  (Dia in [1..28]) )
        then
        Result:=True;
 end;
end;

procedure TfrmCadMetas.dbnMetasClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  dbeInicial.Text := DMPrincipal.ADODSMetaDAT_INICIAL.AsString;
  dbeFinal.Text := DMPrincipal.ADODSMetaDAT_FINAL.AsString;
  dbeAtualizacao.Text := DMPrincipal.ADODSMetaDAT_ATUALIZACAO.AsString;
  dbePctAtingido.Text := DMPrincipal.ADODSMetaPCT_ATINGIDO.AsString;
end;

procedure TfrmCadMetas.CalculaMeta;
var valor,valornovo:String;
begin
  // calcula meta atingida...

  //FormatFloat('###,##0.00',StrToFloat(dbeValorAtual.Text))

  if (trim(dbeValorAtual.Text) <> '') then
  begin
    valornovo := StringReplace(dbeValorAtual.Text,'.','',[rfReplaceAll]);
    //valornovo := StringReplace(valornovo,',','.',[rfReplaceAll]);
    //valor_atual := StrToFloat(FormatFloat('###,##0.00',StrToFloat(dbeValorAtual.Text)));
    valor_atual := StrToFloat(valornovo);
  end
  else
  begin
    valor_atual := 0;
  end;

  if (trim(dbeValorFinal.Text) <> '') then
  begin
    valornovo := StringReplace(dbeValorFinal.Text,'.','',[rfReplaceAll]);
    valor_final := StrToFloat(valornovo);
  end
  else
  begin
    valor_final := 0;
  end;

  pct_atual := (valor_atual * 100) / valor_final;

  dbePctAtingido.Text := FloatToStr(pct_atual);

end;

procedure TfrmCadMetas.dbeValorFinalExit(Sender: TObject);
begin
  if (trim(dbeValorFinal.Text) <> '') then
    CalculaMeta;
end;

procedure TfrmCadMetas.dbeValorAtualExit(Sender: TObject);
begin
  if (trim(dbeValorAtual.Text) <> '') then
    CalculaMeta;
end;

end.
