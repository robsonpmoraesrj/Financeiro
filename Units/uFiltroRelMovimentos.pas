unit uFiltroRelMovimentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDM, StdCtrls, Mask, Buttons, DBCtrls, ExtCtrls;

type
  TfrmFiltroRelMovimentos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    dblkTipoInvest: TDBLookupComboBox;
    dblkInvestidor: TDBLookupComboBox;
    btnGerar: TBitBtn;
    dbtLimpar: TBitBtn;
    btnSair: TBitBtn;
    gbDataAtualizacao: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    mskeMovimentoI: TMaskEdit;
    mskeMovimentoF: TMaskEdit;
    dblkCarteira: TDBLookupComboBox;
    dblkAtivo: TDBLookupComboBox;
    CBTipo: TComboBox;
    CBCategoria: TComboBox;
    Label7: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbtLimparClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroRelMovimentos: TfrmFiltroRelMovimentos;
  dDataMovimentoI, dDataMovimentoF, filtro : string;

implementation

uses uQRMovimentos;

{$R *.dfm}

procedure TfrmFiltroRelMovimentos.btnSairClick(Sender: TObject);
begin
  Close;
  frmFiltroRelMovimentos := nil;
end;

procedure TfrmFiltroRelMovimentos.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Open;
  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSCarteira.Open;

  mskeMovimentoI.Enabled := true;
  mskeMovimentoF.Enabled := true;
end;

procedure TfrmFiltroRelMovimentos.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  shortdateformat := 'dd/mm/yyyy';
  filtro := 'Filtro de Pesquisa: ';
end;

procedure TfrmFiltroRelMovimentos.dbtLimparClick(Sender: TObject);
begin
  dblkTipoInvest.KeyValue := -1;
  dblkInvestidor.KeyValue := -1;
  dblkAtivo.KeyValue := -1;
  dblkCarteira.KeyValue := -1;
  CBTipo.ItemIndex := -1;
  CBCategoria.ItemIndex := -1;
  mskeMovimentoI.Text := '';
  mskeMovimentoF.Text := '';
  filtro := 'Filtro de Pesquisa: ';
end;

procedure TfrmFiltroRelMovimentos.btnGerarClick(Sender: TObject);
  var
  relMovimentos : TqrRelMovimentos;
  rError : boolean;
begin
  rError := false;

  // query principal...
  DMPrincipal.ADOQMovimentos.Close;
  DMPrincipal.ADOQMovimentos.SQL.Clear;
  DMPrincipal.ADOQMovimentos.SQL.Add('/* Listagem das movimentações  - relatório */');
  DMPrincipal.ADOQMovimentos.SQL.Add('select tc.nom_carteira');
  DMPrincipal.ADOQMovimentos.SQL.Add(', cast(tm.dat_movimento as date) as dat_movimento');
  DMPrincipal.ADOQMovimentos.SQL.Add(', ta.nom_ativo');
  DMPrincipal.ADOQMovimentos.SQL.Add(', tm.tip_movimento');
  DMPrincipal.ADOQMovimentos.SQL.Add(', tm.qtd_cotas');
  DMPrincipal.ADOQMovimentos.SQL.Add(', tm.vlr_unitario');
  DMPrincipal.ADOQMovimentos.SQL.Add(', tm.vlr_outras_despesas');
  DMPrincipal.ADOQMovimentos.SQL.Add(', tm.vlr_movimento');
  DMPrincipal.ADOQMovimentos.SQL.Add(', tm.cat_movimento');
  DMPrincipal.ADOQMovimentos.SQL.Add(', tp.nom_proprietario');
  DMPrincipal.ADOQMovimentos.SQL.Add(', ti.dsc_tipoinvestimento');
  DMPrincipal.ADOQMovimentos.SQL.Add('from t_movimento tm');
  DMPrincipal.ADOQMovimentos.SQL.Add(', t_carteira tc');
  DMPrincipal.ADOQMovimentos.SQL.Add(', t_ativo ta');
  DMPrincipal.ADOQMovimentos.SQL.Add(', t_proprietario tp');
  DMPrincipal.ADOQMovimentos.SQL.Add(', t_tipoinvestimento ti');
  DMPrincipal.ADOQMovimentos.SQL.Add('where tm.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQMovimentos.SQL.Add('and tm.cod_ativo = ta.cod_ativo');
  DMPrincipal.ADOQMovimentos.SQL.Add('and tc.cod_proprietario = tp.cod_proprietario');
  DMPrincipal.ADOQMovimentos.SQL.Add('and ta.cod_tipoinvestimento = ti.cod_tipoinvestimento');

  // Filtro por ATIVO...
  if dblkAtivo.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkAtivo.Text;
    DMPrincipal.ADOQMovimentos.SQL.Add('and tm.cod_ativo = ' + quotedstr(dblkAtivo.KeyValue));
  end;

  // Filtro por TIPO DE INVESTIMENTO...
  if dblkTipoInvest.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkTipoInvest.Text;
    DMPrincipal.ADOQMovimentos.SQL.Add('and ti.cod_tipoinvestimento = ' + quotedstr(dblkTipoInvest.KeyValue));
  end;

  // Filtro por CARTEIRA...
  if dblkCarteira.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkCarteira.Text;
    DMPrincipal.ADOQMovimentos.SQL.Add('and tm.cod_carteira = ' + quotedstr(dblkCarteira.KeyValue));
  end;

  // Filtro por TIPO...
  if CBTipo.ItemIndex >= 0 then
  begin
    filtro := filtro + ' - ' + CBTipo.Text;
    if CBTipo.ItemIndex = 0 then
      DMPrincipal.ADOQMovimentos.SQL.Add('and tm.tip_movimento = ''C''')
    else
      if CBTipo.ItemIndex = 1 then
        DMPrincipal.ADOQMovimentos.SQL.Add('and tm.tip_movimento = ''V''');
  end;

  // Filtro por CATEGORIA...
  if CBCategoria.ItemIndex >= 0 then
  begin
    filtro := filtro + ' - ' + CBCategoria.Text;
    if CBCategoria.ItemIndex = 0 then
      DMPrincipal.ADOQMovimentos.SQL.Add('and tm.cat_movimento = ''M''')
    else
      if CBCategoria.ItemIndex = 1 then
        DMPrincipal.ADOQMovimentos.SQL.Add('and tm.cat_movimento = ''S''')
      else
        if CBCategoria.ItemIndex = 2 then
          DMPrincipal.ADOQMovimentos.SQL.Add('and tm.cat_movimento = ''D''')
        else
          if CBCategoria.ItemIndex = 3 then
            DMPrincipal.ADOQMovimentos.SQL.Add('and tm.cat_movimento = ''B''')
          else
            if CBCategoria.ItemIndex = 4 then
              DMPrincipal.ADOQMovimentos.SQL.Add('and tm.cat_movimento = ''O''');
  end;

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkInvestidor.Text;
    DMPrincipal.ADOQMovimentos.SQL.Add('and tp.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
  end;

  // Filtro por DATA DE MOVIMENTO...
  if mskeMovimentoI.Text <> '  /  /    ' then
  begin
    if mskeMovimentoF.Text <> '  /  /    ' then
    begin
      // Valida DATAS...
      if mskeMovimentoI.Text > mskeMovimentoF.Text then
      begin
        messageDlg('Data do Movimento Inválida!', mtError, [mbOk],0);
        rError := true;
        mskeMovimentoI.SetFocus;
      end
      else
      begin
        filtro := filtro + ' - ' + mskeMovimentoI.Text + ' até ' + mskeMovimentoF.Text;
        dDataMovimentoI := formatdatetime('yyyy/mm/dd', strtodate(mskeMovimentoI.Text));
        dDataMovimentoF := formatdatetime('yyyy/mm/dd', strtodate(mskeMovimentoF.Text));
        DMPrincipal.ADOQMovimentos.SQL.Add('and cast(tm.dat_movimento as date) between ' + quotedstr(dDataMovimentoI) +  ' and ' + quotedstr(dDataMovimentoF));
      end;
    end
    else
    begin
      filtro := filtro + ' - ' + mskeMovimentoI.Text;
      dDataMovimentoI := formatdatetime('yyyy/mm/dd', strtodate(mskeMovimentoI.Text));
      DMPrincipal.ADOQMovimentos.SQL.Add('and cast(tm.dat_movimento as date) >= ' + quotedstr(dDataMovimentoI));
    end;
  end
  else
  begin
    if mskeMovimentoF.Text <> '  /  /    ' then
    begin
      filtro := filtro + ' - ' + mskeMovimentoF.Text;
      dDataMovimentoF := formatdatetime('yyyy/mm/dd', strtodate(mskeMovimentoF.Text));
      DMPrincipal.ADOQMovimentos.SQL.Add('and cast(tm.dat_movimento as date) <= ' + quotedstr(dDataMovimentoF));
    end;
  end;

  DMPrincipal.ADOQMovimentos.SQL.Add('order by tm.dat_movimento desc, tm.cod_carteira, tm.cod_ativo, tm.vlr_movimento');

  if rError = false then
  begin
    DMPrincipal.ADOQMovimentos.Open;

    relMovimentos := TqrRelMovimentos.Create(Self);
    relMovimentos.lblFiltro.Caption := filtro;
    relMovimentos.qrRelMovimentos.Preview;
    relMovimentos.Free;
    filtro := 'Filtro de Pesquisa: ';
  end;
end;

end.
