unit uFiltroRelRentabilidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, DBCtrls, ExtCtrls, uDM, ADODB, uQRRentabil;

type
  TfrmFiltroRelRentab = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dblkTipoInvest: TDBLookupComboBox;
    dblkInvestidor: TDBLookupComboBox;
    dblkAtivo: TDBLookupComboBox;
    btnGerar: TBitBtn;
    dbtLimpar: TBitBtn;
    btnSair: TBitBtn;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    mskeAberturaI: TMaskEdit;
    mskeAberturaF: TMaskEdit;
    Label8: TLabel;
    dblkStatus: TDBLookupComboBox;
    Label6: TLabel;
    dblkCarteira: TDBLookupComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbtLimparClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    qrRelRentabil : TqrRelRentabil;
  public
    { Public declarations }
  end;

var
  frmFiltroRelRentab: TfrmFiltroRelRentab;
  dDataAberturaI, dDataAberturaF, dDataVenctoI, dDataVenctoF : string;

implementation

{$R *.dfm}

procedure TfrmFiltroRelRentab.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Open;
  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSStatus.Open;
  DMPrincipal.ADODSCarteira.Open;

  mskeAberturaI.Enabled := true;
  mskeAberturaF.Enabled := true;
end;

procedure TfrmFiltroRelRentab.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  shortdateformat := 'dd/mm/yyyy';
end;

procedure TfrmFiltroRelRentab.btnSairClick(Sender: TObject);
begin
  Close;
  frmFiltroRelRentab := nil;
end;

procedure TfrmFiltroRelRentab.dbtLimparClick(Sender: TObject);
begin
  dblkTipoInvest.KeyValue := -1;
  dblkInvestidor.KeyValue := -1;
  dblkAtivo.KeyValue := -1;
  mskeAberturaI.Text := '';
  mskeAberturaF.Text := '';
  dblkCarteira.KeyValue := -1;
  dblkStatus.KeyValue := -1;
end;

procedure TfrmFiltroRelRentab.btnGerarClick(Sender: TObject);
  var relRentabil : TqrRelRentabil;
  rError : boolean;
begin
  rError := false;
  DMPrincipal.ADOQRentab.Close;
  DMPrincipal.ADOQRentab.SQL.Clear;
  DMPrincipal.ADOQRentab.SQL.Add('select ti.dsc_investimento,');
  DMPrincipal.ADOQRentab.SQL.Add('tt.dsc_tipoinvestimento,');
  DMPrincipal.ADOQRentab.SQL.Add('ti.dsc_observacao,');
  DMPrincipal.ADOQRentab.SQL.Add('tc.nom_carteira,');
  DMPrincipal.ADOQRentab.SQL.Add('sum(ti.nro_cotas) as cotas,');
  DMPrincipal.ADOQRentab.SQL.Add('FORMAT(sum(ti.vlr_alocado), ''C'', ''pt-br'') as vlr_alocado,');
  DMPrincipal.ADOQRentab.SQL.Add('FORMAT(sum(ti.vlr_atualizado), ''C'', ''pt-br'') as vlr_atualizado,');
  DMPrincipal.ADOQRentab.SQL.Add('FORMAT(sum(ti.vlr_atualizado - ti.vlr_alocado), ''C'', ''pt-br'') as vlr_ret_liq,');
  DMPrincipal.ADOQRentab.SQL.Add('ts.dsc_status');
  DMPrincipal.ADOQRentab.SQL.Add('from t_investimento ti,');
  DMPrincipal.ADOQRentab.SQL.Add('t_ativo ta,');
  DMPrincipal.ADOQRentab.SQL.Add('t_tipoinvestimento tt,');
  DMPrincipal.ADOQRentab.SQL.Add('t_carteira tc,');
  DMPrincipal.ADOQRentab.SQL.Add('t_status ts');
  DMPrincipal.ADOQRentab.SQL.Add('where ti.cod_ativo = ta.cod_ativo');
  DMPrincipal.ADOQRentab.SQL.Add('and ta.cod_tipoinvestimento = tt.cod_tipoinvestimento');
  DMPrincipal.ADOQRentab.SQL.Add('and ti.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQRentab.SQL.Add('and ti.cod_status = ts.cod_status');

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    DMPrincipal.ADOQRentab.SQL.Add('and ti.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
  end;

  // Filtro por TIPO DE INVESTIMENTO...
  if dblkTipoInvest.Text <> '' then
  begin
    DMPrincipal.ADOQRentab.SQL.Add('and ta.cod_tipoinvestimento = ' + quotedstr(dblkTipoInvest.KeyValue));
  end;

  // Filtro por ATIVO...
  if dblkAtivo.Text <> '' then
  begin
    DMPrincipal.ADOQRentab.SQL.Add('and ta.cod_ativo = ' + quotedstr(dblkAtivo.KeyValue));
  end;

  // Filtro por CARTEIRA...
  if dblkCarteira.Text <> '' then
  begin
    DMPrincipal.ADOQRentab.SQL.Add('and ti.cod_carteira = ' + quotedstr(dblkCarteira.KeyValue));
  end;

  // Filtro por STATUS...
  if dblkStatus.Text <> '' then
  begin
    DMPrincipal.ADOQRentab.SQL.Add('and ti.cod_status = ' + quotedstr(dblkStatus.KeyValue));
  end;

  // Filtro por DATA DE ABERTURA...
  if mskeAberturaI.Text <> '  /  /    ' then
  begin
    if mskeAberturaF.Text <> '  /  /    ' then
    begin
      // Valida DATAS...
      if mskeAberturaI.Text > mskeAberturaF.Text then
      begin
        messageDlg('Data de Abertura Inválida!', mtError, [mbOk],0);
        rError := true;
        mskeAberturaI.SetFocus;
      end
      else
      begin
        dDataAberturaI := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaI.Text));
        dDataAberturaF := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaF.Text));
        DMPrincipal.ADOQRentab.SQL.Add('and ta.dat_abertura between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
      end;
    end
    else
    begin
      dDataAberturaI := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaI.Text));
      DMPrincipal.ADOQRentab.SQL.Add('and ta.dat_abertura >= ' + quotedstr(dDataAberturaI));
    end;
  end
  else
  begin
    if mskeAberturaF.Text <> '  /  /    ' then
    begin
      dDataAberturaF := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaF.Text));
      DMPrincipal.ADOQRentab.SQL.Add('and ta.dat_abertura <= ' + quotedstr(dDataAberturaF));
    end;
  end;

  // Agrupamento...
  DMPrincipal.ADOQRentab.SQL.Add('group by ti.dsc_investimento, tt.dsc_tipoinvestimento, ti.dsc_observacao, tc.nom_carteira, ts.dsc_status');
  DMPrincipal.ADOQRentab.SQL.Add('order by ti.dsc_investimento, tt.dsc_tipoinvestimento, ti.dsc_observacao, tc.nom_carteira  ');

  if rError = false then
  begin
    DMPrincipal.ADOQRentab.Open;

    relRentabil := TqrRelRentabil.Create(Self);
    relRentabil.Preview;
    relRentabil.Free;
  end;
end;

end.
