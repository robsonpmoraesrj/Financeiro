unit uCadCambio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDM, StdCtrls, DBCtrls, Mask, ExtCtrls, Buttons, Grids, DBGrids;

type
  TfrmCadCambio = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btnSair: TBitBtn;
    dbnCambio: TDBNavigator;
    mskeCambioP: TMaskEdit;
    dbPesqCarteira: TDBLookupComboBox;
    btnLimpar: TBitBtn;
    dbgCambio: TDBGrid;
    Label2: TLabel;
    mskeSolicitacao: TMaskEdit;
    edtTipoInvest: TLabel;
    dblcbProprietario: TDBLookupComboBox;
    Label4: TLabel;
    dblcbSituacao: TDBLookupComboBox;
    Label5: TLabel;
    dbeValorCotacao: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mskeCambio: TMaskEdit;
    dblcbCarteira: TDBLookupComboBox;
    Label3: TLabel;
    dbeDescricao: TDBEdit;
    Label12: TLabel;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    dbPesqProprietario: TDBLookupComboBox;
    dbeValorAporte_BR: TDBEdit;
    dbeTaxas: TDBEdit;
    Label13: TLabel;
    edtValorFinal: TEdit;
    Label14: TLabel;
    mskeAtualizacao: TMaskEdit;
    Label15: TLabel;
    dbeValorAporte_US: TEdit;
    procedure btnSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbnCambioClick(Sender: TObject; Button: TNavigateBtn);
    procedure dbgCambioCellClick(Column: TColumn);
    procedure dbeValorAporte_BRExit(Sender: TObject);
    procedure dbeTaxasExit(Sender: TObject);
    procedure dbeValorCotacaoExit(Sender: TObject);
    procedure mskeCambioPExit(Sender: TObject);
    procedure dbPesqProprietarioClick(Sender: TObject);
    procedure dbPesqCarteiraClick(Sender: TObject);
  private
    { Private declarations }
    function DataOk(Dt:String):Boolean;
    procedure CalculaValores;
    procedure PesquisaRegistro;
  public
    { Public declarations }
  end;

var
  frmCadCambio: TfrmCadCambio;
  Result : boolean;
  carteira, proprietario : integer;
  aporte_br, taxas, vlr_total, cotacao_us, aporte_us: double;

implementation

{$R *.dfm}

procedure TfrmCadCambio.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadCambio := nil;
end;

procedure TfrmCadCambio.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio';
  DMPrincipal.ADODSCambio.CommandText := DMPrincipal.ADODSCambio.CommandText + ' order by dat_cambio desc';
  DMPrincipal.ADODSCambio.Open;

  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSCarteira.Open;
  DMPrincipal.ADOQPesqCarteira.Open;
  DMPrincipal.ADODSStatus.Open;

  mskeSolicitacao.Enabled := false;
  mskeCambio.Enabled := false;
  mskeAtualizacao.Enabled := false;

  dblcbProprietario.Enabled := false;
  dblcbCarteira.Enabled := false;
  dblcbSituacao.Enabled := false;

  dbeValorAporte_BR.Enabled := false;
  dbeValorAporte_US.Enabled := false;
  dbeTaxas.Enabled := false;
  edtValorFinal.Enabled := false;
  dbeValorCotacao.Enabled := false;
  dbeDescricao.Enabled := false;

  mskeSolicitacao.Text := DMPrincipal.ADODSCambioDAT_SOLICITACAO.AsString;
  mskeCambio.Text := DMPrincipal.ADODSCambioDAT_CAMBIO.AsString;
  mskeAtualizacao.Text := DMPrincipal.ADODSCambioDAT_CADASTRO.AsString;
  edtValorFinal.Text := DMPrincipal.ADODSCambioVLR_FINAL_BR.AsString;
  dbeValorAporte_US.Text := DMPrincipal.ADODSCambioVLR_APORTE_US.AsString;

  //edtValorTotal.Text := DMPrincipal.ADODSCambioVLR_FINAL_BR.AsString;
end;

procedure TfrmCadCambio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSCambio.Close;
  DMPrincipal.ADODSInvestidor.Close;
  DMPrincipal.ADODSCarteira.Close;
  //DMPrincipal.ADOQPesqCarteira.Close;
  DMPrincipal.ADODSStatus.Close;

  DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio';
  Action := caFree;

  frmCadCambio := nil;
end;

procedure TfrmCadCambio.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  dbPesqProprietario.Enabled := true;
  dbPesqCarteira.Enabled := true;
  mskeCambioP.Enabled := true;
end;

procedure TfrmCadCambio.btnLimparClick(Sender: TObject);
begin
  DMPrincipal.ADODSCambio.Close;
  DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio';

  mskeCambioP.Clear;
  mskeCambio.Clear;

  dbPesqProprietario.KeyValue := null;
  dbPesqCarteira.KeyValue := null;

  mskeCambio.Text := DMPrincipal.ADODSCambioDAT_CAMBIO.AsString;
  mskeSolicitacao.Text := DMPrincipal.ADODSCambioDAT_SOLICITACAO.AsString;
  mskeAtualizacao.Text := DMPrincipal.ADODSCambioDAT_CADASTRO.AsString;

  DMPrincipal.ADODSCambio.Close;

  DMPrincipal.ADODSCambio.CommandText := DMPrincipal.ADODSCambio.CommandText + ' order by dat_cambio desc';
  DMPrincipal.ADODSCambio.Open;

  //edtValorTotal.Text := DMPrincipal.ADOQProventosVALOR_TOTAL.AsString;
  mskeSolicitacao.Text := DMPrincipal.ADODSCambioDAT_SOLICITACAO.AsString;
  mskeCambio.Text := DMPrincipal.ADODSCambioDAT_CAMBIO.AsString;
  mskeAtualizacao.Text := DMPrincipal.ADODSCambioDAT_CADASTRO.AsString;

  edtValorFinal.Text := DMPrincipal.ADODSCambio.FieldByName('vlr_final_br').AsString;
  dbeValorAporte_US.Text := DMPrincipal.ADODSCambio.FieldByName('vlr_aporte_us').AsString;
end;

procedure TfrmCadCambio.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSCambio.Append;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  mskeCambioP.Enabled := false;
  dbPesqCarteira.Enabled := false;
  dblcbProprietario.Enabled := false;

  mskeSolicitacao.Enabled := true;
  mskeCambio.Enabled := true;
  mskeAtualizacao.Enabled := true;

  dblcbProprietario.Enabled := true;
  dblcbCarteira.Enabled := true;
  dblcbSituacao.Enabled := true;

  dbeValorAporte_BR.Enabled := true;
  dbeValorAporte_US.Enabled := true;
  dbeTaxas.Enabled := true;
  edtValorFinal.Enabled := true;
  dbeValorCotacao.Enabled := true;
  dbeDescricao.Enabled := true;

  mskeSolicitacao.Clear;
  mskeCambio.Clear;
  mskeAtualizacao.Clear;
  edtValorFinal.Clear;

  mskeSolicitacao.SetFocus;

  mskeAtualizacao.Text := DateToStr(Date());
end;

procedure TfrmCadCambio.btnSalvarClick(Sender: TObject);
begin

  if DataOk(mskeSolicitacao.Text) then
    result := true
  else
    result := false;

  if not Result then
  begin
    ShowMessage('Não é uma data válida!');
    exit;
    mskeSolicitacao.SetFocus;
  end;

  if DataOk(mskeCambio.Text) then
    result := true
  else
    result := false;

  if not Result then
  begin
    ShowMessage('Não é uma data válida!');
    exit;
    mskeCambio.SetFocus;
  end;

  if trim(dblcbSituacao.Text) = '' then
  begin
    ShowMessage('Informe a situação!');
    exit;
    dblcbSituacao.SetFocus;
  end;

  DMPrincipal.ADODSCambio.FieldByName('dat_solicitacao').Value := FormatDateTime('yyyy-MM-dd',StrToDate(mskeSolicitacao.Text));
  DMPrincipal.ADODSCambio.FieldByName('dat_cambio').Value := FormatDateTime('yyyy-MM-dd',StrToDate(mskeCambio.Text));
  DMPrincipal.ADODSCambio.FieldByName('dat_cadastro').Value := FormatDateTime('yyyy-MM-dd',StrToDate(mskeAtualizacao.Text));
  DMPrincipal.ADODSCambio.FieldByName('vlr_final_br').Value := edtValorFinal.Text;
  DMPrincipal.ADODSCambio.FieldByName('vlr_aporte_us').Value := dbeValorAporte_US.Text;

  // Salva...
  try
    DMPrincipal.ADODSCambio.Post;
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

  mskeCambioP.Enabled := true;
  dbPesqCarteira.Enabled := true;
  dblcbProprietario.Enabled := true;

  mskeSolicitacao.Enabled := false;
  mskeCambio.Enabled := false;
  mskeAtualizacao.Enabled := false;

  dblcbProprietario.Enabled := false;
  dblcbCarteira.Enabled := false;
  dblcbSituacao.Enabled := false;

  dbeValorAporte_BR.Enabled := false;
  dbeValorAporte_US.Enabled := false;
  dbeTaxas.Enabled := false;
  edtValorFinal.Enabled := false;
  dbeValorCotacao.Enabled := false;
  dbeDescricao.Enabled := false;

  mskeCambioP.Enabled := true;
  dbPesqProprietario.Enabled := true;
  dbPesqCarteira.Enabled := true;

  DMPrincipal.ADODSCambio.Close;
  DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio';
  DMPrincipal.ADODSCambio.CommandText := DMPrincipal.ADODSCambio.CommandText + ' order by dat_cambio desc';
  DMPrincipal.ADODSCambio.Open;

  mskeSolicitacao.Text := DMPrincipal.ADODSCambioDAT_SOLICITACAO.AsString;
  mskeCambio.Text := DMPrincipal.ADODSCambioDAT_CAMBIO.AsString;
  mskeAtualizacao.Text := DMPrincipal.ADODSCambioDAT_CADASTRO.AsString;

  DMPrincipal.ADODSCambio.Close;
  DMPrincipal.ADODSCambio.CommandText := DMPrincipal.ADODSCambio.CommandText + ' order by dat_cambio desc';
  DMPrincipal.ADODSCambio.Open;
  //edtValorTotal.Text := DMPrincipal.ADOQProventosVALOR_TOTAL.AsString;

  mskeCambioP.Clear;
  dbPesqProprietario.KeyValue := null;
  dbPesqCarteira.KeyValue := null;
end;

procedure TfrmCadCambio.btnAlterarClick(Sender: TObject);
begin
  //DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio';
  //DMPrincipal.ADODSCambio.CommandText := DMPrincipal.ADODSCambio.CommandText + ' order by dat_cambio desc';
  //DMPrincipal.ADODSCambio.Open;
  DMPrincipal.ADODSCambio.Edit;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  mskeCambioP.Enabled := false;
  dbPesqCarteira.Enabled := false;
  dblcbProprietario.Enabled := false;

  mskeSolicitacao.Enabled := true;
  mskeCambio.Enabled := true;
  mskeAtualizacao.Enabled := true;

  dblcbProprietario.Enabled := true;
  dblcbCarteira.Enabled := true;
  dblcbSituacao.Enabled := true;

  dbeValorAporte_BR.Enabled := true;
  dbeValorAporte_US.Enabled := true;
  dbeTaxas.Enabled := true;
  edtValorFinal.Enabled := true;
  dbeValorCotacao.Enabled := true;
  dbeDescricao.Enabled := true;

  mskeSolicitacao.SetFocus;
end;

procedure TfrmCadCambio.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSCambio.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  mskeCambioP.Enabled := true;
  dbPesqCarteira.Enabled := true;
  dblcbProprietario.Enabled := true;

  mskeSolicitacao.Enabled := false;
  mskeCambio.Enabled := false;
  mskeAtualizacao.Enabled := false;

  dblcbProprietario.Enabled := false;
  dblcbCarteira.Enabled := false;
  dblcbSituacao.Enabled := false;

  dbeValorAporte_BR.Enabled := false;
  dbeValorAporte_US.Enabled := false;
  dbeTaxas.Enabled := false;
  edtValorFinal.Enabled := false;
  dbeValorCotacao.Enabled := false;
  dbeDescricao.Enabled := false;

  mskeCambioP.Enabled := true;
  dbPesqProprietario.Enabled := true;
  dbPesqCarteira.Enabled := true;

  DMPrincipal.ADODSCambio.Close;
  DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio';
  DMPrincipal.ADODSCambio.CommandText := DMPrincipal.ADODSCambio.CommandText + ' order by dat_cambio desc';
  DMPrincipal.ADODSCambio.Open;

  mskeSolicitacao.Text := DMPrincipal.ADODSCambioDAT_SOLICITACAO.AsString;
  mskeCambio.Text := DMPrincipal.ADODSCambioDAT_CAMBIO.AsString;
  mskeAtualizacao.Text := DMPrincipal.ADODSCambioDAT_CADASTRO.AsString;

  edtValorFinal.Text := DMPrincipal.ADODSCambio.FieldByName('vlr_final_br').AsString;
  dbeValorAporte_US.Text := DMPrincipal.ADODSCambio.FieldByName('vlr_aporte_us').AsString;

end;

procedure TfrmCadCambio.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSCambio.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSCambio.Delete;
  end;
end;

procedure TfrmCadCambio.dbnCambioClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  mskeSolicitacao.Text := DMPrincipal.ADODSCambioDAT_SOLICITACAO.AsString;
  mskeCambio.Text := DMPrincipal.ADODSCambioDAT_CAMBIO.AsString;
  mskeAtualizacao.Text := DMPrincipal.ADODSCambioDAT_CADASTRO.AsString;
  edtValorFinal.Text := DMPrincipal.ADODSCambioVLR_FINAL_BR.AsString;
  dbeValorAporte_US.Text := DMPrincipal.ADODSCambioVLR_APORTE_US.AsString;
end;

procedure TfrmCadCambio.dbgCambioCellClick(Column: TColumn);
begin
  mskeSolicitacao.Text := DMPrincipal.ADODSCambioDAT_SOLICITACAO.AsString;
  mskeCambio.Text := DMPrincipal.ADODSCambioDAT_CAMBIO.AsString;
  mskeAtualizacao.Text := DMPrincipal.ADODSCambioDAT_CADASTRO.AsString;
  edtValorFinal.Text := DMPrincipal.ADODSCambioVLR_FINAL_BR.AsString;
  dbeValorAporte_US.Text := DMPrincipal.ADODSCambioVLR_APORTE_US.AsString;
end;

procedure TfrmCadCambio.PesquisaRegistro;
begin
  DMPrincipal.ADODSCambio.Close;

  mskeSolicitacao.Clear;
  mskeCambio.Clear;
  mskeAtualizacao.Clear;
  edtValorFinal.Clear;
  dbeValorAporte_US.Clear;

  if (dbPesqCarteira.KeyValue <> null) and (dbPesqProprietario.KeyValue <> null) and (mskeCambioP.Text <> '  /  /    ') then
  begin
    carteira := dbPesqCarteira.KeyValue;
    proprietario := dbPesqProprietario.KeyValue;
    DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio c, t_carteira t, t_proprietario p where c.cod_carteira = t.cod_carteira and c.cod_proprietario = p.cod_proprietario and c.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and c.cod_proprietario = ' + #39 + IntToStr(proprietario) + #39 + 'and c.dat_cambio = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCambioP.Text)) + #39;
  end
  else
    if (dbPesqCarteira.KeyValue <> null) and (dbPesqProprietario.KeyValue <> null) and (mskeCambioP.Text = '  /  /    ') then
    begin
      carteira := dbPesqCarteira.KeyValue;
      proprietario := dbPesqProprietario.KeyValue;
      DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio c, t_carteira t, t_proprietario p where c.cod_carteira = t.cod_carteira and c.cod_proprietario = p.cod_proprietario and c.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and c.cod_proprietario = ' + #39 + IntToStr(proprietario) + #39;
    end
    else
      if (dbPesqCarteira.KeyValue <> null) and (dbPesqProprietario.KeyValue = null) and (mskeCambioP.Text = '  /  /    ') then
      begin
        carteira := dbPesqCarteira.KeyValue;
        DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio c, t_carteira t, t_proprietario p where c.cod_carteira = t.cod_carteira and c.cod_proprietario = p.cod_proprietario and c.cod_carteira = ' + #39 + IntToStr(carteira) + #39;
      end
      else
        if (dbPesqCarteira.KeyValue = null) and (dbPesqProprietario.KeyValue <> null) and (mskeCambioP.Text <> '  /  /    ') then
        begin
          proprietario := dbPesqProprietario.KeyValue;
          DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio c, t_carteira t, t_proprietario p where c.cod_carteira = t.cod_carteira and c.cod_proprietario = p.cod_proprietario and c.cod_proprietario = ' + #39 + IntToStr(proprietario) + #39 + 'and c.dat_cambio = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCambioP.Text)) + #39;
        end
        else
          if (dbPesqCarteira.KeyValue <> null) and (dbPesqProprietario.KeyValue = null) and (mskeCambioP.Text <> '  /  /    ') then
          begin
            carteira := dbPesqCarteira.KeyValue;
            DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio c, t_carteira t, t_proprietario p where c.cod_carteira = t.cod_carteira and c.cod_proprietario = p.cod_proprietario and c.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and c.dat_cambio = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCambioP.Text)) + #39;
          end
          else
            if (dbPesqCarteira.KeyValue = null) and (dbPesqProprietario.KeyValue = null) and (mskeCambioP.Text <> '  /  /    ') then
            begin
              DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio c, t_carteira t, t_proprietario p where c.cod_carteira = t.cod_carteira and c.cod_proprietario = p.cod_proprietario and c.dat_cambio = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCambioP.Text)) + #39;
            end
            else
              if (dbPesqCarteira.KeyValue = null) and (dbPesqProprietario.KeyValue <> null) and (mskeCambioP.Text = '  /  /    ') then
              begin
                proprietario := dbPesqProprietario.KeyValue;
                DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio c, t_carteira t, t_proprietario p where c.cod_carteira = t.cod_carteira and c.cod_proprietario = p.cod_proprietario and c.cod_proprietario = ' + #39 + IntToStr(proprietario) + #39;
              end
              else
                if (dbPesqCarteira.KeyValue = null) and (dbPesqProprietario.KeyValue = null) and (mskeCambioP.Text = '  /  /    ') then
                begin
                  DMPrincipal.ADODSCambio.CommandText := 'select * from t_cambio c, t_carteira t, t_proprietario p where c.cod_carteira = t.cod_carteira and c.cod_proprietario = p.cod_proprietario' + #39;
                end;

  DMPrincipal.ADODSCambio.CommandText := DMPrincipal.ADODSCambio.CommandText + ' order by dat_cambio desc';
  DMPrincipal.ADODSCambio.Open;

  //edtValorTotal.Text := DMPrincipal.ADOQProventosVALOR_TOTAL.AsString;
  mskeSolicitacao.Text := DMPrincipal.ADODSCambioDAT_SOLICITACAO.AsString;
  mskeCambio.Text := DMPrincipal.ADODSCambioDAT_CAMBIO.AsString;
  mskeAtualizacao.Text := DMPrincipal.ADODSCambioDAT_CADASTRO.AsString;

  edtValorFinal.Text := DMPrincipal.ADODSCambio.FieldByName('vlr_final_br').AsString;
  dbeValorAporte_US.Text := DMPrincipal.ADODSCambio.FieldByName('vlr_aporte_us').AsString;  
end;

function TfrmCadCambio.DataOk(Dt:String):Boolean;
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

procedure TfrmCadCambio.CalculaValores;
begin
  // calcula valor líquido do câmbio...
  if (trim(dbeValorAporte_BR.Text) <> '') then
  begin
    aporte_br := StrToFloat(StringReplace(dbeValorAporte_BR.Text, '.', '', [rfReplaceAll]));
    //aporte_br := StrToFloat(dbeValorAporte_BR.Text);
  end
  else
    aporte_br := 0;

  dbeValorAporte_BR.Text := FloatToStr(aporte_br);

  if (trim(dbeTaxas.Text) <> '') then
  begin
    taxas := StrToFloat(StringReplace(dbeTaxas.Text, '.', '', [rfReplaceAll]));
    //taxas := StrToFloat(dbeTaxas.Text);
  end
  else
    taxas := 0;

  if (StrToFloat(dbeValorAporte_BR.Text) >= 0) and (StrToFloat(dbeTaxas.Text) >= 0) then
  begin
    vlr_total :=  aporte_br - taxas;
  end
  else
    vlr_total := 0;

  edtValorFinal.Text := FloatToStr(vlr_total);

  // calcula o valor final em dólar...
  if (trim(dbeValorCotacao.Text) <> '') then
  begin
    cotacao_us := StrToFloat(StringReplace(dbeValorCotacao.Text, '.', '', [rfReplaceAll]));
    //cotacao_us := StrToFloat(dbeValorCotacao.Text);
  end
  else
    cotacao_us := 0;

  if cotacao_us > 0 then
    aporte_us := vlr_total/cotacao_us
  else
    aporte_us := 0;

  dbeValorAporte_US.Text := FloatToStr(aporte_us);
  dbeValorAporte_US.Text := FormatFloat('###,###,##0.00',StrToFloat(dbeValorAporte_US.Text));
end;

procedure TfrmCadCambio.dbeValorAporte_BRExit(Sender: TObject);
begin
  if (trim(dbeValorAporte_BR.Text) <> '') and (trim(dbeTaxas.Text) <> '') then
    CalculaValores;
end;

procedure TfrmCadCambio.dbeTaxasExit(Sender: TObject);
begin
  if (trim(dbeValorAporte_BR.Text) <> '') and (trim(dbeTaxas.Text) <> '') then
    CalculaValores;
end;

procedure TfrmCadCambio.dbeValorCotacaoExit(Sender: TObject);
begin
  if (trim(edtValorFinal.Text) <> '') and (trim(dbeValorCotacao.Text) <> '') then
    CalculaValores;
end;

procedure TfrmCadCambio.mskeCambioPExit(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TfrmCadCambio.dbPesqProprietarioClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TfrmCadCambio.dbPesqCarteiraClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

end.
