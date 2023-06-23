unit uCadMovimentacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, Grids, DBGrids, uDM, Mask,
  DB, ADODB;

type
  TfrmCadMovimentacoes = class(TForm)
    GroupBox1: TGroupBox;
    btnSair: TBitBtn;
    dbnAlocacao: TDBNavigator;
    dbgMovimentacoes: TDBGrid;
    Label7: TLabel;
    dblcbCarteira: TDBLookupComboBox;
    edtTipoInvest: TLabel;
    Label6: TLabel;
    dbeCotas: TDBEdit;
    Label8: TLabel;
    dbeValorAlocado: TDBEdit;
    Label3: TLabel;
    dbeInicio: TDBEdit;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    rbTipMovimento: TRadioGroup;
    Label1: TLabel;
    edtProcurar: TEdit;
    dblcbAtivo: TDBLookupComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dblkCarteiraCClick(Sender: TObject);
    procedure dblkInvestimentoCClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtProcurarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblcbCarteiraClick(Sender: TObject);
    procedure dbnAlocacaoClick(Sender: TObject; Button: TNavigateBtn);
    procedure dbnAlocacaoEnter(Sender: TObject);
  private
    { Private declarations }
    procedure preenchePesquisa();
  public
    { Public declarations }
  end;

var
  frmCadMovimentacoes: TfrmCadMovimentacoes;

implementation

{$R *.dfm}

procedure TfrmCadMovimentacoes.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSMovimento.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSCarteira.Open;

  //dbeInicio.Clear;
  //dbeCotas.Clear;
  //dbeValorAlocado.Clear;

  if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'C' then
    rbTipMovimento.ItemIndex := 0
  else
    if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'V' then
      rbTipMovimento.ItemIndex := 1
    else
      rbTipMovimento.ItemIndex := -1;

  // desabilita os campos...
  dbeInicio.Enabled := false;
  dbeValorAlocado.Enabled := false;
  dbeCotas.Enabled := false;
  dblcbAtivo.readOnly := true;
  dblcbAtivo.Enabled := false;
  dblcbCarteira.readOnly := true;
  dblcbCarteira.Enabled := false;
  rbTipMovimento.Enabled := false;
end;

procedure TfrmCadMovimentacoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSMovimento.Close;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSCarteira.Close;

  //DMPrincipal.ADODSMovimento.Close;
  //DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento';
  Action := caFree;

  frmCadMovimentacoes := nil;
end;

procedure TfrmCadMovimentacoes.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
end;

procedure TfrmCadMovimentacoes.dblkCarteiraCClick(Sender: TObject);
begin
  preenchePesquisa;
end;

procedure TfrmCadMovimentacoes.dblkInvestimentoCClick(Sender: TObject);
begin
  preenchePesquisa;
end;

procedure TfrmCadMovimentacoes.preenchePesquisa();
begin

  DMPrincipal.ADODSMovimento.Close;
  {
  if (dblkCarteira.Text <> '') and (dblkInvestimento.Text <> '') then
  begin
    DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento where cod_carteira = ' + quotedstr(dblkCarteira.KeyValue) + ' and cod_investimento = ' + quotedstr(dblkInvestimento.KeyValue);
  end
  else
    if (dblkCarteira.Text <> '') and (dblkInvestimento.Text = '') then
    begin
      DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento where cod_carteira = ' + quotedstr(dblkCarteira.KeyValue);
    end
    else
      if (dblkCarteira.Text = '') and (dblkInvestimento.Text <> '') then
      begin
        DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento where cod_investimento = ' + quotedstr(dblkInvestimento.KeyValue);
      end;
  }
  DMPrincipal.ADODSMovimento.Open;
end;

procedure TfrmCadMovimentacoes.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadMovimentacoes := nil;
end;

procedure TfrmCadMovimentacoes.BitBtn1Click(Sender: TObject);
begin
  preenchePesquisa;
end;

procedure TfrmCadMovimentacoes.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSMovimento.Open;
  DMPrincipal.ADODSMovimento.Append;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;
  btnSair.Enabled := false;

  // habilita os campos...
  dbeInicio.Enabled := true;
  dbeValorAlocado.Enabled := true;
  dbeCotas.Enabled := true;
  dblcbAtivo.Enabled := true;
  dblcbCarteira.Enabled := true;
  rbTipMovimento.Enabled := true;

  DMPrincipal.ADODSMovimento.FieldByName('dat_movimento').AsDateTime := now;

  dbeCotas.Enabled := true;
  dblcbAtivo.readOnly := false;
  dblcbAtivo.Enabled := true;
  dblcbCarteira.readOnly := false;
  dblcbCarteira.Enabled := true;
  dblcbCarteira.SetFocus;
end;

procedure TfrmCadMovimentacoes.btnSalvarClick(Sender: TObject);
begin

  // Validar existência do investimento...
  if (dblcbCarteira.Text <> '') and (dblcbAtivo.Text <> '') then
  begin
    DMPrincipal.ADOQMovto.Close;
    DMPrincipal.ADOQMovto.SQL.Add('select * from t_investimento where ');
    DMPrincipal.ADOQMovto.SQL.Add(' cod_carteira = ' + quotedstr(dblcbCarteira.KeyValue));
    DMPrincipal.ADOQMovto.SQL.Add(' and cod_ativo = ' + quotedstr(dblcbAtivo.KeyValue));

    DMPrincipal.ADOQMovto.Active;

    if not DMPrincipal.ADOQMovto.Eof then
    begin
      showmessage('Investimento inexistente para a carteira informada!');
      Exit;
    end;

  end
  else
    if (dblcbCarteira.Text <> '') and (dblcbAtivo.Text = '') then
    begin
      DMPrincipal.ADOQMovto.Close;
      DMPrincipal.ADOQMovto.SQL.Add('select count(*) from t_investimento ti where 1 = 1 ');
      DMPrincipal.ADOQMovto.SQL.Add(' and ti.cod_carteira = ' + quotedstr(dblcbCarteira.KeyValue));
      DMPrincipal.ADOQMovto.Open;

      if not DMPrincipal.ADOQMovto.Eof then
      begin
        showmessage('Investimento inexistente para a carteira informada!');
        Exit;
      end

    end
    else
      if (dblcbCarteira.Text = '') and (dblcbAtivo.Text <> '') then
      begin
        DMPrincipal.ADOQMovto.Close;
        DMPrincipal.ADOQMovto.SQL.Add('select count(*) from t_investimento ti where 1 = 1 ');
        DMPrincipal.ADOQMovto.SQL.Add(' and ti.cod_ativo = ' + quotedstr(dblcbAtivo.KeyValue));
        DMPrincipal.ADOQMovto.Open;

        if not DMPrincipal.ADOQMovto.Eof then
        begin
          showmessage('Investimento inexistente!');
          Exit;
        end

      end
      else
        if (dblcbCarteira.Text = '') and (dblcbAtivo.Text = '') then
        begin
          showmessage('É necessário informar Carteira e/ou Investimento!');
          Exit;
        end;
  // Fim da validação...

  if rbTipMovimento.ItemIndex = 0 then
    DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString := 'C'
  else
    if rbTipMovimento.ItemIndex = 1 then
      DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString := 'V'
    else
      DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString := '';

  DMPrincipal.ADODSMovimento.Post;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;
  btnSair.Enabled := true;

  // desabilita os campos...
  dbeInicio.Enabled := false;
  dbeValorAlocado.Enabled := false;
  dbeCotas.Enabled := false;
  dblcbAtivo.readOnly := true;
  dblcbAtivo.Enabled := false;
  dblcbCarteira.readOnly := true;
  dblcbCarteira.Enabled := false;
  rbTipMovimento.Enabled := false;

  //rbTipMovimento.ItemIndex := 0;

  //DMPrincipal.ADODSMovimento.Close;
  //DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento order by dat_movimento desc';
  //DMPrincipal.ADODSMovimento.Open;
end;

procedure TfrmCadMovimentacoes.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSMovimento.Open;
  DMPrincipal.ADODSMovimento.Edit;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;
  btnSair.Enabled := false;

  // habilita os campos...
  dbeInicio.Enabled := true;
  dbeValorAlocado.Enabled := true;
  dbeCotas.Enabled := true;
  dblcbAtivo.Enabled := false;
  dblCbAtivo.ReadOnly := true;
  dblcbCarteira.Enabled := false;
  dblcbCarteira.ReadOnly := true;
  rbTipMovimento.Enabled := true;
  rbTipMovimento.SetFocus;
end;

procedure TfrmCadMovimentacoes.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSMovimento.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;
  btnSair.Enabled := true;

  // desabilita os campos...
  dbeInicio.Enabled := false;
  dbeValorAlocado.Enabled := false;
  dbeCotas.Enabled := false;
  dblcbAtivo.readOnly := true;
  dblcbAtivo.Enabled := false;
  dblcbCarteira.readOnly := true;
  dblcbCarteira.Enabled := false;
  rbTipMovimento.Enabled := false;

  //DMPrincipal.ADODSMovimento.Close;
  //DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento';
  //DMPrincipal.ADODSMovimento.Open;
end;

procedure TfrmCadMovimentacoes.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSMovimento.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSMovimento.Delete;
  end;
end;

procedure TfrmCadMovimentacoes.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DMPrincipal.ADODSMovimento.Close;
  DMPrincipal.ADODSMovimento.CommandText := 'select * from t_movimento where nom_carteira like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSMovimento.Open;
end;

procedure TfrmCadMovimentacoes.dblcbCarteiraClick(Sender: TObject);
begin
  {
  DMPrincipal.ADODSAlocacao.Close;
  DMPrincipal.ADODSAlocacao.CommandText := 'select * from t_investimento where cod_status = 1 and cod_carteira = ' + quotedstr(dblcbCarteira.KeyValue);
  DMPrincipal.ADODSAlocacao.Active := true;
  DMPrincipal.ADODSAlocacao.Open;
  dblcbAtivo.Enabled := true;
  }
end;

procedure TfrmCadMovimentacoes.dbnAlocacaoClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'C' then
    rbTipMovimento.ItemIndex := 0
  else
    if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'V' then
      rbTipMovimento.ItemIndex := 1
    else
      rbTipMovimento.ItemIndex := -1;
end;

procedure TfrmCadMovimentacoes.dbnAlocacaoEnter(Sender: TObject);
begin
  if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'C' then
    rbTipMovimento.ItemIndex := 0
  else
    if DMPrincipal.ADODSMovimento.FieldByName('tip_movimento').AsString = 'V' then
      rbTipMovimento.ItemIndex := 1
    else
      rbTipMovimento.ItemIndex := -1;
end;

end.
