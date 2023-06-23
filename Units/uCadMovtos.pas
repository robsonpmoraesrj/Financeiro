unit uCadMovtos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, DBCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, uDM, DB, ADODB;

type
  TfrmCadMovtos = class(TForm)
    GroupBox1: TGroupBox;
    btnSair: TBitBtn;
    dbnMovto: TDBNavigator;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    Label7: TLabel;
    edtTipoInvest: TLabel;
    dblcbCarteira: TDBLookupComboBox;
    dblcbAtivo: TDBLookupComboBox;
    rbTipMovimento: TRadioGroup;
    Label3: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    dbgMovimentacoes: TDBGrid;
    Label1: TLabel;
    dbeInicio: TMaskEdit;
    dbeCotas: TDBEdit;
    dbeValorUnitario: TDBEdit;
    dbeValorAlocado: TDBEdit;
    Label2: TLabel;
    dbPesqCarteira: TDBLookupComboBox;
    Label4: TLabel;
    btnLimpar: TBitBtn;
    Label5: TLabel;
    dbeOutrasDespesas: TDBEdit;
    rbCategoria: TRadioGroup;
    dbPesqAtivo: TDBLookupComboBox;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dbnMovtoClick(Sender: TObject; Button: TNavigateBtn);
    procedure dbnMovtoEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCotasExit(Sender: TObject);
    procedure edtProcurarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgMovimentacoesCellClick(Column: TColumn);
    procedure dbPesqCarteiraClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure dbeValorAlocadoEnter(Sender: TObject);
    procedure dbeValorUnitarioExit(Sender: TObject);
    procedure dbeOutrasDespesasExit(Sender: TObject);
    procedure dbPesqAtivoClick(Sender: TObject);
  private
    { Private declarations }
    function DataOk(Dt:String):Boolean;
    procedure CalculaMovimento;
    procedure PesquisaRegistro;
    procedure PosicionaTela;
  public
    { Public declarations }
  end;

var
  frmCadMovtos: TfrmCadMovtos;
  carteira, ativo : integer;
  nro_cotas_a, vlr_alocado_a, vlr_unitario_a, vlr_outras_despesas_a : double;
  Result : boolean;

implementation

{$R *.dfm}

procedure TfrmCadMovtos.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSMovimento.Open;
  DMPrincipal.ADODSMovimento.Edit;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;
  btnSair.Enabled := false;

  dbPesqAtivo.Enabled := false;
  dbPesqCarteira.Enabled := false;

  // habilita os campos...
  dbeInicio.Enabled := true;
  //dbeValorAlocado.Enabled := true;
  dbeCotas.Enabled := true;
  dbeValorUnitario.Enabled := true;
  dbeOutrasDespesas.Enabled := true;
  dblcbAtivo.Enabled := false;
  dblCbAtivo.ReadOnly := true;

  dblcbCarteira.Enabled := true;
  dblcbCarteira.ReadOnly := false;

  rbTipMovimento.Enabled := true;
  rbCategoria.Enabled := true;

  rbTipMovimento.SetFocus;
end;

procedure TfrmCadMovtos.btnSalvarClick(Sender: TObject);
begin
  // Tip_Movimento...
  if rbTipMovimento.ItemIndex = 0 then
    DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString := 'C'
  else
    if rbTipMovimento.ItemIndex = 1 then
      DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString := 'V'
    else
      DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString := '';

  // Categoria
  if rbCategoria.ItemIndex = 0 then
    DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString := 'M'
  else
    if rbCategoria.ItemIndex = 1 then
      DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString := 'S'
    else
      if rbCategoria.ItemIndex = 2 then
        DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString := 'D'
      else
        if rbCategoria.ItemIndex = 3 then
          DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString := 'B'
        else
          if rbCategoria.ItemIndex = 4 then
            DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString := 'O';

  if DataOk(dbeInicio.Text) then
    result := true
  else
    result := false;

  if not Result then
  begin
    ShowMessage('Não é uma data válida!');
    exit;
    dbeInicio.SetFocus;
  end;

  DMPrincipal.ADODSMovimento.FieldByName('dat_movimento').Value := FormatDateTime('yyyy-MM-dd',StrToDate(dbeInicio.Text));
  DMPrincipal.ADODSMovimento.FieldByName('vlr_movimento').Value := dbeValorAlocado.Text;

  // Salva...
  try
    DMPrincipal.ADODSMovimento.Post;
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
  btnSair.Enabled := true;

  dbPesqAtivo.Enabled := true;
  dbPesqCarteira.Enabled := true;

  // desabilita os campos...
  dbeInicio.Enabled := false;
  //dbeValorAlocado.Enabled := false;
  dbeCotas.Enabled := false;
  dbeValorUnitario.Enabled := false;
  dbeOutrasDespesas.Enabled := false;
  dblcbAtivo.readOnly := true;
  dblcbAtivo.Enabled := false;
  dblcbCarteira.readOnly := true;
  dblcbCarteira.Enabled := false;
  rbTipMovimento.Enabled := false;
  rbCategoria.Enabled := false;

  DMPrincipal.ADODSMovimento.Close;
  DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento order by dat_movimento desc';
  DMPrincipal.ADODSMovimento.Open;

  dbeInicio.Text := DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString;

  PosicionaTela;

  {dbeInicio.Text :=
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,9,2)+'/'+
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,6,2)+'/'+
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,1,4);  }
end;

procedure TfrmCadMovtos.dbnMovtoClick(Sender: TObject; Button: TNavigateBtn);
begin

  // Tip_Movimento
  if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'C' then
    rbTipMovimento.ItemIndex := 0
  else
    if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'V' then
      rbTipMovimento.ItemIndex := 1
    else
      rbTipMovimento.ItemIndex := -1;

  // Categoria
  if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'M' then
    rbCategoria.ItemIndex := 0   // mercado
  else
    if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'S' then
      rbCategoria.ItemIndex := 1   // subscrição
    else
      if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'D' then
        rbCategoria.ItemIndex := 2   // desdobramento
      else
        if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'B' then
          rbCategoria.ItemIndex := 3   // bonificação
        else
          if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'O' then
            rbCategoria.ItemIndex := 4   // outros
          else
            rbCategoria.ItemIndex := -1;

  dbeInicio.Text := DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString;

  {dbeInicio.Text :=
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,9,2)+'/'+
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,6,2)+'/'+
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,1,4); }
end;

procedure TfrmCadMovtos.dbnMovtoEnter(Sender: TObject);
begin
  // Tip_Movimento
  if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'C' then
    rbTipMovimento.ItemIndex := 0
  else
    if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'V' then
      rbTipMovimento.ItemIndex := 1
    else
      rbTipMovimento.ItemIndex := -1;

  // Categoria
  if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'M' then
    rbCategoria.ItemIndex := 0   // mercado
  else
    if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'S' then
      rbCategoria.ItemIndex := 1   // subscrição
    else
      if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'D' then
        rbCategoria.ItemIndex := 2   // desdobramento
      else
        if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'B' then
          rbCategoria.ItemIndex := 3   // bonificação
        else
          if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'O' then
            rbCategoria.ItemIndex := 4   // outros
          else
            rbCategoria.ItemIndex := -1;
end;

procedure TfrmCadMovtos.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSMovimento.CommandText := DMPrincipal.ADODSMovimento.CommandText; //+ ' order by dat_movimento desc';
  DMPrincipal.ADODSMovimento.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSCarteira.Open;
  DMPrincipal.ADOQPesqCarteira.Open;

  // Tip_Movimento
  if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'C' then
    rbTipMovimento.ItemIndex := 0
  else
    if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'V' then
      rbTipMovimento.ItemIndex := 1
    else
      rbTipMovimento.ItemIndex := -1;

  // Categoria
  if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'M' then
    rbCategoria.ItemIndex := 0   // mercado
  else
    if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'S' then
      rbCategoria.ItemIndex := 1   // subscrição
    else
      if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'D' then
        rbCategoria.ItemIndex := 2   // desdobramento
      else
        if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'B' then
          rbCategoria.ItemIndex := 3   // bonificação
        else
          if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'O' then
            rbCategoria.ItemIndex := 4   // outros
          else
            rbCategoria.ItemIndex := -1;

  // desabilita os campos...
  dbeInicio.Enabled := false;
  //dbeValorAlocado.Enabled := false;
  dbeCotas.Enabled := false;
  dbeValorUnitario.Enabled := false;
  dbeOutrasDespesas.Enabled := false;
  dblcbAtivo.readOnly := true;
  dblcbAtivo.Enabled := false;
  dblcbCarteira.readOnly := true;
  dblcbCarteira.Enabled := false;
  rbTipMovimento.Enabled := false;
  rbCategoria.Enabled := false;

  dbeInicio.Text := DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString;

  {dbeInicio.Text :=
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,9,2)+'/'+
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,6,2)+'/'+
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,1,4); }

  //carteira := DMPrincipal.ADODSMovimentoCOD_CARTEIRA.AsInteger;
end;

procedure TfrmCadMovtos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSMovimento.Close;
  DMPrincipal.ADODSAtivo.Close;
  DMPrincipal.ADODSCarteira.Close;
  DMPrincipal.ADOQPesqCarteira.Close;

  DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento order by dat_movimento desc';
  Action := caFree;

  frmCadMovtos := nil;
end;

procedure TfrmCadMovtos.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  dbPesqAtivo.Enabled := true;
  dbPesqCarteira.Enabled := true;
  dbPesqAtivo.Enabled := true;
end;

procedure TfrmCadMovtos.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSMovimento.Open;
  DMPrincipal.ADODSMovimento.Append;
  
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;
  btnSair.Enabled := false;

  dbPesqAtivo.Enabled := false;
  dbPesqCarteira.Enabled := false;

  // habilita os campos...
  dbeInicio.Enabled := true;
  //dbeValorAlocado.Enabled := true;
  dbeCotas.Enabled := true;
  dbeValorUnitario.Enabled := true;
  dbeOutrasDespesas.Enabled := true;
  dblcbAtivo.Enabled := true;
  dblcbCarteira.Enabled := true;
  rbTipMovimento.Enabled := true;
  rbCategoria.Enabled := true;

  dbeInicio.Text := DateToStr(Date());
  dbeOutrasDespesas.Text := '0';

  dbeCotas.Enabled := true;
  dbeValorUnitario.Enabled := true;
  dbeOutrasDespesas.Enabled := true;
  dblcbAtivo.readOnly := false;
  dblcbAtivo.Enabled := true;
  dblcbCarteira.readOnly := false;

  dblcbCarteira.SetFocus;
end;

procedure TfrmCadMovtos.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSMovimento.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;
  btnSair.Enabled := true;

  dbPesqAtivo.Enabled := true;
  dbPesqCarteira.Enabled := true;

  // desabilita os campos...
  dbeInicio.Enabled := false;
  //dbeValorAlocado.Enabled := false;
  dbeCotas.Enabled := false;
  dbeValorUnitario.Enabled := false;
  dbeOutrasDespesas.Enabled := false;
  dblcbAtivo.readOnly := true;
  dblcbAtivo.Enabled := false;
  dblcbCarteira.readOnly := true;
  dblcbCarteira.Enabled := false;
  rbTipMovimento.Enabled := false;
  rbCategoria.Enabled := false;

  DMPrincipal.ADODSMovimento.Close;
  DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento order by dat_movimento desc';
  DMPrincipal.ADODSMovimento.Open;

  dbeInicio.Text := DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString;

  PosicionaTela;

  {dbeInicio.Text :=
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,9,2)+'/'+
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,6,2)+'/'+
  Copy(DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString,1,4);  }
end;

procedure TfrmCadMovtos.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSMovimento.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSMovimento.Delete;
  end;
end;

procedure TfrmCadMovtos.dbeCotasExit(Sender: TObject);
begin
  if trim(dbeValorUnitario.Text) = '' then
    dbeValorUnitario.Text := '0';
  CalculaMovimento;
  dbeValorAlocado.Text := FloatToStr(vlr_alocado_a);
end;


procedure TfrmCadMovtos.CalculaMovimento;
begin
  // calcula o número de cotas negociadas...
  if (trim(dbeCotas.Text) <> '') then
    nro_cotas_a := StrToFloat(dbeCotas.Text)
  else
    nro_cotas_a := 0;

  dbeCotas.Text := FloatToStr(nro_cotas_a);

  if (StrToFloat(dbeCotas.Text) >= 0) and (StrToFloat(dbeValorUnitario.Text) >= 0) then
  begin
    vlr_unitario_a := StrToFloat(dbeValorUnitario.Text);
    vlr_alocado_a :=  vlr_unitario_a * nro_cotas_a;
  end
  else
    vlr_alocado_a := 0;

  if (trim(dbeOutrasDespesas.Text) <> '') then
    vlr_outras_despesas_a := StrToFloat(dbeOutrasDespesas.Text);

  if (vlr_alocado_a > 0) then
    vlr_alocado_a := vlr_alocado_a + vlr_outras_despesas_a;
end;

function TfrmCadMovtos.DataOk(Dt:String):Boolean;
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

procedure TfrmCadMovtos.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  PesquisaRegistro;
end;

procedure TfrmCadMovtos.dbgMovimentacoesCellClick(Column: TColumn);
begin
  // Tip_Movimento
  if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'C' then
    rbTipMovimento.ItemIndex := 0
  else
    if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'V' then
      rbTipMovimento.ItemIndex := 1
    else
      rbTipMovimento.ItemIndex := -1;

  // Categoria
  if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'M' then
    rbCategoria.ItemIndex := 0   // mercado
  else
    if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'S' then
      rbCategoria.ItemIndex := 1   // subscrição
    else
      if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'D' then
        rbCategoria.ItemIndex := 2   // desdobramento
      else
        if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'B' then
          rbCategoria.ItemIndex := 3   // bonificação
        else
          if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'O' then
            rbCategoria.ItemIndex := 4   // outros
          else
            rbCategoria.ItemIndex := -1;

  dbeInicio.Text := DMPrincipal.ADODSMovimentoDAT_MOVIMENTO.AsString;
end;

procedure TfrmCadMovtos.dbPesqCarteiraClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TfrmCadMovtos.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadMovtos := nil;
end;

procedure TfrmCadMovtos.btnLimparClick(Sender: TObject);
begin
  dbPesqAtivo.KeyValue := null;
  dbPesqCarteira.KeyValue := null;
  PesquisaRegistro;
end;

procedure TfrmCadMovtos.PesquisaRegistro;
begin
  DMPrincipal.ADODSMovimento.Close;

  if (dbPesqCarteira.KeyValue <> null) and (dbPesqAtivo.KeyValue <> null) then
  begin
    carteira := dbPesqCarteira.KeyValue;
    ativo := dbPesqAtivo.KeyValue;
    DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento m, t_ativo a where m.cod_ativo = a.cod_ativo and m.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and a.cod_ativo = ' + #39 + IntToStr(ativo) + #39;
  end
  else
    if (dbPesqCarteira.KeyValue = null) and (dbPesqAtivo.KeyValue <> null) then
    begin
      ativo := dbPesqAtivo.KeyValue;
      DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento m, t_ativo a where m.cod_ativo = a.cod_ativo and a.cod_ativo = ' + #39 + IntToStr(ativo) + #39
    end
    else
      if (dbPesqCarteira.KeyValue <> null) and (dbPesqAtivo.KeyValue = null) then
      begin
        carteira := dbPesqCarteira.KeyValue;
        DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento m, t_ativo a where m.cod_ativo = a.cod_ativo and m.cod_carteira = ' + #39 + IntToStr(carteira) + #39;
      end
      else
        DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento';

  DMPrincipal.ADODSMovimento.CommandText := DMPrincipal.ADODSMovimento.CommandText + ' order by dat_movimento desc';      
  DMPrincipal.ADODSMovimento.Open;
end;

procedure TfrmCadMovtos.dbeValorAlocadoEnter(Sender: TObject);
begin
  CalculaMovimento;
end;

procedure TfrmCadMovtos.dbeValorUnitarioExit(Sender: TObject);
begin
  if trim(dbeCotas.Text) = '' then
    dbeCotas.Text := '0';
  CalculaMovimento;
  dbeValorAlocado.Text := FloatToStr(vlr_alocado_a);
end;

procedure TfrmCadMovtos.dbeOutrasDespesasExit(Sender: TObject);
begin
  if trim(dbeOutrasDespesas.Text) = '' then
    dbeOutrasDespesas.Text := '0';
  CalculaMovimento;
  dbeValorAlocado.Text := FloatToStr(vlr_alocado_a);
end;

procedure TfrmCadMovtos.PosicionaTela;
begin
  // Tip_Movimento
  if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'C' then
    rbTipMovimento.ItemIndex := 0
  else
    if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'V' then
      rbTipMovimento.ItemIndex := 1
    else
      rbTipMovimento.ItemIndex := -1;

  // Categoria
  if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'M' then
    rbCategoria.ItemIndex := 0   // mercado
  else
    if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'S' then
      rbCategoria.ItemIndex := 1   // subscrição
    else
      if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'D' then
        rbCategoria.ItemIndex := 2   // desdobramento
      else
        if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'B' then
          rbCategoria.ItemIndex := 3   // bonificação
        else
          if DMPrincipal.ADODSMovimento.FieldByName('cat_movimento').AsString = 'O' then
            rbCategoria.ItemIndex := 4   // outros
          else
            rbCategoria.ItemIndex := -1;
end;

procedure TfrmCadMovtos.dbPesqAtivoClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

end.
