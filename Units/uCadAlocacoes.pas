unit uCadAlocacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, uDM, DB,
  Mask, ComCtrls;

type
  TfrmCadAlocacoes = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnSair: TBitBtn;
    edtProcurar: TEdit;
    dbnAlocacao: TDBNavigator;
    dbgAlocacoes: TDBGrid;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    dblcbAtivo: TDBLookupComboBox;
    dblcbInvestidor: TDBLookupComboBox;
    dblcbStatus: TDBLookupComboBox;
    edtTipoInvest: TLabel;
    edtInvestidor: TLabel;
    edtStatus: TLabel;
    dbeAlocacao: TDBEdit;
    dbeObs: TDBEdit;
    dbeCotas: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dblcbCarteira: TDBLookupComboBox;
    Label8: TLabel;
    Label9: TLabel;
    dbeValorAlocado: TDBEdit;
    dbeValorAtualizado: TDBEdit;
    Label10: TLabel;
    dblxTipo: TDBLookupComboBox;
    Label11: TLabel;
    Label12: TLabel;
    btnLimpar: TBitBtn;
    dbPesqCarteira: TDBLookupComboBox;
    Label13: TLabel;
    dblkAtivo: TDBLookupComboBox;
    Label14: TLabel;
    dblkTipoInvest: TDBLookupComboBox;
    DTPDtAtualizacao: TDateTimePicker;
    dbeInicio: TMaskEdit;
    dbeVencto: TMaskEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtProcurarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dblkAtivoClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure dbPesqCarteiraClick(Sender: TObject);
    procedure dblkTipoInvestClick(Sender: TObject);
    procedure dbnAlocacaoClick(Sender: TObject; Button: TNavigateBtn);
    procedure dbgAlocacoesCellClick(Column: TColumn);
  private
    { Private declarations }
    function DataOk(Dt:String):Boolean;
    procedure PesquisaRegistro;
  public
    { Public declarations }
  end;

var
  frmCadAlocacoes: TfrmCadAlocacoes;
  carteira, tipoInvest, ativo : integer;
  Result : boolean;

implementation

{$R *.dfm}

procedure TfrmCadAlocacoes.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSAlocacao.Open;
  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSStatus.Open;
  DMPrincipal.ADODSCarteira.Open;
  DMPrincipal.ADODSTipInvest.Open;

  // desabilita os campos...
  dbeAlocacao.Enabled := false;
  dbeInicio.Enabled := false;
  dbeVencto.Enabled := false;
  dbeValorAlocado.Enabled := false;
  dbeValorAtualizado.Enabled := false;
  DTPDtAtualizacao.Enabled := false;
  dbeObs.Enabled := false;
  dbeCotas.Enabled := false;
  dblcbAtivo.readOnly := true;
  dblcbAtivo.Enabled := false;

  dblxTipo.readOnly := true;
  dblxTipo.Enabled := false;

  dblcbInvestidor.readOnly := true;
  dblcbInvestidor.Enabled := false;
  dblcbStatus.readOnly := true;
  dblcbStatus.Enabled := false;
  dblcbCarteira.readOnly := true;
  dblcbCarteira.Enabled := false;

  // habilita filtros de pesquisa...
  edtProcurar.Enabled := true;
  dblkAtivo.Enabled := true;
  dbPesqCarteira.Enabled := true;
  dblkTipoInvest.Enabled := true;

  dbeInicio.Text := DMPrincipal.ADODSAlocacaoDAT_ABERTURA.AsString;
  dbeVencto.Text := DMPrincipal.ADODSAlocacaoDAT_VENCIMENTO.AsString;
end;

procedure TfrmCadAlocacoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSInvestidor.Close;
  DMPrincipal.ADODSTipInvest.Close;
  DMPrincipal.ADODSStatus.Close;
  DMPrincipal.ADODSGestor.Close;
  DMPrincipal.ADODSCarteira.Close;

  DMPrincipal.ADODSAlocacao.Close;
  DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento';
  Action := caFree;

  frmCadAlocacoes := nil;
end;

procedure TfrmCadAlocacoes.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  
  // habilita filtros de pesquisa...
  edtProcurar.Enabled := true;
  dblkAtivo.Enabled := true;
  dbPesqCarteira.Enabled := true;
  dblkTipoInvest.Enabled := true;

end;

procedure TfrmCadAlocacoes.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadAlocacoes := nil;
end;

procedure TfrmCadAlocacoes.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {
  DMPrincipal.ADODSAlocacao.Close;
  DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento where dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSAlocacao.Open;
  }
  PesquisaRegistro;
end;

procedure TfrmCadAlocacoes.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSAlocacao.Open;
  DMPrincipal.ADODSAlocacao.Append;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  // desabilita filtros de pesquisa...
  edtProcurar.Enabled := false;
  dblkAtivo.Enabled := false;
  dbPesqCarteira.Enabled := false;
  dblkTipoInvest.Enabled := false;

  // habilita os campos...
  dbeAlocacao.Enabled := true;
  dbeInicio.Enabled := true;
  dbeValorAlocado.Enabled := true;
  dbeValorAtualizado.Enabled := true;
  DTPDtAtualizacao.Enabled := true;

  //DMPrincipal.ADODSAlocacao.FieldByName('dat_abertura').AsDateTime:=now;
  dbeInicio.Text := DateToStr(Date());

  dbeVencto.Enabled := true;
  dbeVencto.Text := DateToStr(Date() + 1);
  //DMPrincipal.ADODSAlocacao.FieldByName('dat_vencimento').AsDateTime:=now + 1;

  dbeObs.Enabled := true;
  dbeCotas.Enabled := true;
  dblcbAtivo.readOnly := false;
  dblcbAtivo.Enabled := true;

  dblxTipo.readOnly := false;
  dblxTipo.Enabled := true;

  dblcbInvestidor.readOnly := false;
  dblcbInvestidor.Enabled := true;
  dblcbStatus.readOnly := false;
  dblcbStatus.Enabled := true;
  dblcbCarteira.readOnly := false;
  dblcbCarteira.Enabled := true;
  dbeAlocacao.SetFocus;
end;

procedure TfrmCadAlocacoes.btnSalvarClick(Sender: TObject);
begin
  if dbeInicio.Text <> '  /  /    ' then
  begin
    if DataOk(dbeInicio.Text) then
      result := true
    else
      result := false;

    if not Result then
    begin
      ShowMessage('Data de Abertura n�o � uma data v�lida!');
      exit;
      dbeInicio.SetFocus;
    end
    else
      DMPrincipal.ADODSAlocacao.FieldByName('dat_abertura').Value := FormatDateTime('yyyy-MM-dd',StrToDate(dbeInicio.Text));
  end;

  if dbeVencto.Text <> '  /  /    ' then
  begin
    if DataOk(dbeVencto.Text) then
      result := true
    else
      result := false;

    if not Result then
    begin
      ShowMessage('Data de Vencimento n�o � uma data v�lida!');
      exit;
      dbeVencto.SetFocus;
    end
    else
      DMPrincipal.ADODSAlocacao.FieldByName('dat_vencimento').Value := FormatDateTime('yyyy-MM-dd',StrToDate(dbeVencto.Text));
  end;

  if DataOk(dateToStr(DTPDtAtualizacao.DateTime)) then
    result := true
  else
    result := false;

  if not Result then
  begin
    ShowMessage('N�o � uma data v�lida!');
    exit;
    DTPDtAtualizacao.SetFocus;
  end
  else
    DMPrincipal.ADODSAlocacao.FieldByName('dat_atualizacao').Value := FormatDateTime('yyyy-MM-dd',DTPDtAtualizacao.DateTime);
    
  //DMPrincipal.ADODSAlocacao.FieldByName('dat_atualizacao').Value := DTPDtAtualizacao.DateTime;

  // Salva...
  try
    DMPrincipal.ADODSAlocacao.Post;
    ShowMessage('Opera��o efetuada com sucesso!');
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

  // habilita filtros de pesquisa...
  edtProcurar.Enabled := true;
  dblkAtivo.Enabled := true;
  dbPesqCarteira.Enabled := true;
  dblkTipoInvest.Enabled := true;

  // desabilita os campos...
  dbeAlocacao.Enabled := false;
  dbeInicio.Enabled := false;
  dbeVencto.Enabled := false;
  dbeValorAlocado.Enabled := false;
  dbeValorAtualizado.Enabled := false;
  DTPDtAtualizacao.Enabled := false;
  dbeObs.Enabled := false;
  dbeCotas.Enabled := false;
  dblcbAtivo.readOnly := true;
  dblcbAtivo.Enabled := false;

  dblxTipo.readOnly := true;
  dblxTipo.Enabled := false;
  
  dblcbInvestidor.readOnly := true;
  dblcbInvestidor.Enabled := false;
  dblcbStatus.readOnly := true;
  dblcbStatus.Enabled := false;
  dblcbCarteira.readOnly := true;
  dblcbCarteira.Enabled := false;

  {
  DMPrincipal.ADODSAlocacao.Close;
  DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento';
  DMPrincipal.ADODSAlocacao.Open;

  dbeInicio.Text := DMPrincipal.ADODSAlocacaoDAT_ABERTURA.AsString;
  dbeVencto.Text := DMPrincipal.ADODSAlocacaoDAT_VENCIMENTO.AsString;
  }
end;

procedure TfrmCadAlocacoes.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSAlocacao.Open;
  DMPrincipal.ADODSAlocacao.Edit;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  // desabilita filtros de pesquisa...
  edtProcurar.Enabled := false;
  dblkAtivo.Enabled := false;
  dbPesqCarteira.Enabled := false;
  dblkTipoInvest.Enabled := false;

  // habilita os campos...
  dbeAlocacao.Enabled := true;
  dbeInicio.Enabled := true;
  dbeVencto.Enabled := true;
  dbeValorAlocado.Enabled := true;
  dbeValorAtualizado.Enabled := true;
  DTPDtAtualizacao.Enabled := true;
  dbeObs.Enabled := true;
  dbeCotas.Enabled := true;
  dblcbAtivo.readOnly := false;
  dblcbAtivo.Enabled := true;

  dblxTipo.readOnly := false;
  dblxTipo.Enabled := true;

  dblcbInvestidor.readOnly := false;
  dblcbInvestidor.Enabled := true;
  dblcbStatus.readOnly := false;
  dblcbStatus.Enabled := true;
  dblcbCarteira.readOnly := false;
  dblcbCarteira.Enabled := true;
  dbeAlocacao.SetFocus;
end;

procedure TfrmCadAlocacoes.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSAlocacao.Cancel;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  // habilita filtros de pesquisa...
  edtProcurar.Enabled := true;
  dblkAtivo.Enabled := true;
  dbPesqCarteira.Enabled := true;
  dblkTipoInvest.Enabled := true;

  // desabilita os campos...
  dbeAlocacao.Enabled := false;
  dbeInicio.Enabled := false;
  dbeVencto.Enabled := false;
  dbeValorAlocado.Enabled := false;
  dbeValorAtualizado.Enabled := false;
  DTPDtAtualizacao.Enabled := false;
  dbeObs.Enabled := false;
  dbeCotas.Enabled := false;
  dblcbAtivo.readOnly := true;
  dblcbAtivo.Enabled := false;

  dblxTipo.readOnly := true;
  dblxTipo.Enabled := false;

  dblcbInvestidor.readOnly := true;
  dblcbInvestidor.Enabled := false;
  dblcbStatus.readOnly := true;
  dblcbStatus.Enabled := false;
  dblcbCarteira.readOnly := true;
  dblcbCarteira.Enabled := false;

  DMPrincipal.ADODSAlocacao.Close;
  DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento';
  DMPrincipal.ADODSAlocacao.Open;

  dbeInicio.Text := DMPrincipal.ADODSAlocacaoDAT_ABERTURA.AsString;
  dbeVencto.Text := DMPrincipal.ADODSAlocacaoDAT_VENCIMENTO.AsString;
end;

procedure TfrmCadAlocacoes.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta opera��o n�o poder� ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSAlocacao.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSAlocacao.Delete;
  end;
end;

procedure TfrmCadAlocacoes.dblkAtivoClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TfrmCadAlocacoes.btnLimparClick(Sender: TObject);
begin
  edtProcurar.Clear;
  dblkAtivo.KeyValue := null;
  dbPesqCarteira.KeyValue := null;
  dblkTipoInvest.KeyValue := null;
  PesquisaRegistro;
end;

procedure TfrmCadAlocacoes.dbPesqCarteiraClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TfrmCadAlocacoes.dblkTipoInvestClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TfrmCadAlocacoes.PesquisaRegistro;
begin
  DMPrincipal.ADODSAlocacao.Close;

  // Todos...
  if (dbPesqCarteira.KeyValue <> null) and (trim(edtProcurar.Text) <> '') and (dblkAtivo.KeyValue <> null) and (dblkTipoInvest.KeyValue <> null) then
  begin
    carteira := dbPesqCarteira.KeyValue;
    tipoInvest := dblkTipoInvest.KeyValue;
    ativo := dblkAtivo.KeyValue;
    DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and i.dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39 + ' and i.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + ' and i.cod_tipoinvestimento = ' + #39 + IntToStr(tipoInvest) + #39 + 'order by cod_carteira, dat_atualizacao desc';
  end
  else
    // Carteira, descri��o e ativo...
    if (dbPesqCarteira.KeyValue <> null) and (trim(edtProcurar.Text) <> '') and (dblkAtivo.KeyValue <> null) and (dblkTipoInvest.KeyValue = null) then
    begin
      carteira := dbPesqCarteira.KeyValue;
      ativo := dblkAtivo.KeyValue;
      DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and i.dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39 + ' and i.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + 'order by cod_carteira, dat_atualizacao desc';
    end
    else
      // Carteira e descri��o...
      if (dbPesqCarteira.KeyValue <> null) and (trim(edtProcurar.Text) <> '') and (dblkAtivo.KeyValue = null) and (dblkTipoInvest.KeyValue = null) then
      begin
        carteira := dbPesqCarteira.KeyValue;
        DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and i.dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39 + 'order by cod_carteira, dat_atualizacao desc';
      end
      else
        // Carteira...
        if (dbPesqCarteira.KeyValue <> null) and (trim(edtProcurar.Text) = '') and (dblkAtivo.KeyValue = null) and (dblkTipoInvest.KeyValue = null) then
        begin
          carteira := dbPesqCarteira.KeyValue;
          DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + 'order by cod_carteira, dat_atualizacao desc';
        end
        else
          // Carteira, descri��o e tipo...
          if (dbPesqCarteira.KeyValue <> null) and (trim(edtProcurar.Text) <> '') and (dblkAtivo.KeyValue = null) and (dblkTipoInvest.KeyValue <> null) then
          begin
            carteira := dbPesqCarteira.KeyValue;
            tipoInvest := dblkTipoInvest.KeyValue;
            DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and i.dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39 + ' and i.cod_tipoinvestimento = ' + #39 + IntToStr(tipoInvest) + #39 + 'order by cod_carteira, dat_atualizacao desc';
          end
          else
            // Carteira, ativo e tipo...
            if (dbPesqCarteira.KeyValue <> null) and (trim(edtProcurar.Text) = '') and (dblkAtivo.KeyValue <> null) and (dblkTipoInvest.KeyValue <> null) then
            begin
              carteira := dbPesqCarteira.KeyValue;
              tipoInvest := dblkTipoInvest.KeyValue;
              ativo := dblkAtivo.KeyValue;
              DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and i.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + ' and i.cod_tipoinvestimento = ' + #39 + IntToStr(tipoInvest) + #39 + 'order by cod_carteira, dat_atualizacao desc';
            end
            else
              // Descri��o, ativo e tipo...
              if (dbPesqCarteira.KeyValue = null) and (trim(edtProcurar.Text) <> '') and (dblkAtivo.KeyValue <> null) and (dblkTipoInvest.KeyValue <> null) then
              begin
                tipoInvest := dblkTipoInvest.KeyValue;
                ativo := dblkAtivo.KeyValue;
                DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39 + ' and i.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + ' and i.cod_tipoinvestimento = ' + #39 + IntToStr(tipoInvest) + #39 + 'order by cod_carteira, dat_atualizacao desc';
              end
              else
                // Ativo e tipo...
                if (dbPesqCarteira.KeyValue = null) and (trim(edtProcurar.Text) = '') and (dblkAtivo.KeyValue <> null) and (dblkTipoInvest.KeyValue <> null) then
                begin
                  tipoInvest := dblkTipoInvest.KeyValue;
                  ativo := dblkAtivo.KeyValue;
                  DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + ' and i.cod_tipoinvestimento = ' + #39 + IntToStr(tipoInvest) + #39 + 'order by cod_carteira, dat_atualizacao desc';
                end
                else
                  // Carteira e ativo...
                  if (dbPesqCarteira.KeyValue <> null) and (trim(edtProcurar.Text) = '') and (dblkAtivo.KeyValue <> null) and (dblkTipoInvest.KeyValue = null) then
                  begin
                    carteira := dbPesqCarteira.KeyValue;
                    ativo := dblkAtivo.KeyValue;
                    DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and i.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + 'order by cod_carteira, dat_atualizacao desc';
                  end
                  else
                    // Ativo e descri��o...
                    if (dbPesqCarteira.KeyValue = null) and (trim(edtProcurar.Text) <> '') and (dblkAtivo.KeyValue <> null) and (dblkTipoInvest.KeyValue = null) then
                    begin
                      ativo := dblkAtivo.KeyValue;
                      DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39 + ' and i.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + 'order by cod_carteira, dat_atualizacao desc';
                    end
                    else
                      // Carteira e descri��o...
                      if (dbPesqCarteira.KeyValue <> null) and (trim(edtProcurar.Text) <> '') and (dblkAtivo.KeyValue <> null) and (dblkTipoInvest.KeyValue <> null) then
                      begin
                        carteira := dbPesqCarteira.KeyValue;
                        tipoInvest := dblkTipoInvest.KeyValue;
                        ativo := dblkAtivo.KeyValue;
                        DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and i.dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39 + 'order by cod_carteira, dat_atualizacao desc';
                      end
                      else
                        // Descri��o e tipo...
                        if (dbPesqCarteira.KeyValue = null) and (trim(edtProcurar.Text) <> '') and (dblkAtivo.KeyValue = null) and (dblkTipoInvest.KeyValue <> null) then
                        begin
                          tipoInvest := dblkTipoInvest.KeyValue;
                          DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39 + ' and i.cod_tipoinvestimento = ' + #39 + IntToStr(tipoInvest) + #39 + 'order by cod_carteira, dat_atualizacao desc';
                        end
                        else
                          // Descri��o...
                          if (dbPesqCarteira.KeyValue = null) and (trim(edtProcurar.Text) <> '') and (dblkAtivo.KeyValue = null) and (dblkTipoInvest.KeyValue = null) then
                          begin
                            DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.dsc_investimento like ' + #39 + edtProcurar.Text + '%' + #39 + 'order by cod_carteira, dat_atualizacao desc';
                          end
                          else
                            // Ativo...
                            if (dbPesqCarteira.KeyValue = null) and (trim(edtProcurar.Text) = '') and (dblkAtivo.KeyValue <> null) and (dblkTipoInvest.KeyValue = null) then
                            begin
                              ativo := dblkAtivo.KeyValue;
                              DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + 'order by cod_carteira, dat_atualizacao desc';
                            end
                            else
                            // Tipo de Investimento...
                            if (dbPesqCarteira.KeyValue = null) and (trim(edtProcurar.Text) = '') and (dblkAtivo.KeyValue = null) and (dblkTipoInvest.KeyValue <> null) then
                            begin
                              tipoInvest := dblkTipoInvest.KeyValue;
                              DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i where i.cod_tipoinvestimento = ' + #39 + IntToStr(tipoInvest) + #39 + 'order by cod_carteira, dat_atualizacao desc';
                            end
                            else
                              // Sem nenhum filtro...
                              if (dbPesqCarteira.KeyValue = null) and (trim(edtProcurar.Text) = '') and (dblkAtivo.KeyValue = null) and (dblkTipoInvest.KeyValue = null) then
                              begin
                                DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento i order by cod_carteira, dat_atualizacao desc';
                              end;

  DMPrincipal.ADODSAlocacao.Open;

  dbeInicio.Text := DMPrincipal.ADODSAlocacaoDAT_ABERTURA.AsString;
  dbeVencto.Text := DMPrincipal.ADODSAlocacaoDAT_VENCIMENTO.AsString;
  DTPDtAtualizacao.DateTime := DMPrincipal.ADODSAlocacaoDAT_ATUALIZACAO.Value;
end;

function TfrmCadAlocacoes.DataOk(Dt:String):Boolean;
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

procedure TfrmCadAlocacoes.dbnAlocacaoClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  dbeInicio.Text := DMPrincipal.ADODSAlocacaoDAT_ABERTURA.AsString;
  dbeVencto.Text := DMPrincipal.ADODSAlocacaoDAT_VENCIMENTO.AsString;
end;

procedure TfrmCadAlocacoes.dbgAlocacoesCellClick(Column: TColumn);
begin
  dbeInicio.Text := DMPrincipal.ADODSAlocacaoDAT_ABERTURA.AsString;
  dbeVencto.Text := DMPrincipal.ADODSAlocacaoDAT_VENCIMENTO.AsString;
end;

end.
