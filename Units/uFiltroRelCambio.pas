unit uFiltroRelCambio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, DBCtrls, ExtCtrls, uQRCambio, uDM, ADODB;

type
  TfrmFiltroRelCambio = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    dblkInvestidor: TDBLookupComboBox;
    btnGerar: TBitBtn;
    dbtLimpar: TBitBtn;
    btnSair: TBitBtn;
    gbDataAtualizacao: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    mskeAberturaI: TMaskEdit;
    mskeAberturaF: TMaskEdit;
    dblkStatus: TDBLookupComboBox;
    dblkCarteira: TDBLookupComboBox;
    procedure btnSairClick(Sender: TObject);
    procedure dbtLimparClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    qrRelCambio : TqrRelCambio;
  public
    { Public declarations }
  end;

var
  frmFiltroRelCambio: TfrmFiltroRelCambio;
  dDataAberturaI, dDataAberturaF, dDataVenctoI, dDataVenctoF : string;

implementation

{$R *.dfm}

procedure TfrmFiltroRelCambio.btnSairClick(Sender: TObject);
begin
  Close;
  frmFiltroRelCambio := nil;
end;

procedure TfrmFiltroRelCambio.dbtLimparClick(Sender: TObject);
begin
  dblkCarteira.KeyValue := -1;
  dblkInvestidor.KeyValue := -1;
  dblkStatus.KeyValue := -1;
  mskeAberturaI.Text := '';
  mskeAberturaF.Text := '';
end;

procedure TfrmFiltroRelCambio.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSCarteira.Open;
  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSStatus.Open;

  mskeAberturaI.Enabled := true;
  mskeAberturaF.Enabled := true;
end;

procedure TfrmFiltroRelCambio.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  shortdateformat := 'dd/mm/yyyy';
end;

procedure TfrmFiltroRelCambio.btnGerarClick(Sender: TObject);
  var relCambio : TqrRelCambio;
  rError : boolean;
begin
  rError := false;
  DMPrincipal.ADOQCambio.Close;
  DMPrincipal.ADOQCambio.SQL.Clear;
  DMPrincipal.ADOQCambio.SQL.Add('select tm.dat_solicitacao');
  DMPrincipal.ADOQCambio.SQL.Add(', tm.dat_cambio');
  DMPrincipal.ADOQCambio.SQL.Add(', tc.nom_carteira');
  DMPrincipal.ADOQCambio.SQL.Add(', tp.nom_proprietario');
  DMPrincipal.ADOQCambio.SQL.Add(', FORMAT(tm.vlr_aporte_br, ''C'', ''pt-br'') as vlr_aporte_br');
  DMPrincipal.ADOQCambio.SQL.Add(', FORMAT(tm.vlr_taxas, ''C'', ''pt-br'') as vlr_taxas');
  DMPrincipal.ADOQCambio.SQL.Add(', FORMAT(tm.vlr_final_br, ''C'', ''pt-br'') as vlr_final_br');
  DMPrincipal.ADOQCambio.SQL.Add(', ''R$ '' + cast(tm.vlr_cotacao_dolar as varchar) as vlr_cotacao_dolar');
  //DMPrincipal.ADOQCambio.SQL.Add(', FORMAT(tm.vlr_aporte_us, ''C'', ''en-us'') as vlr_aporte_us');
  DMPrincipal.ADOQCambio.SQL.Add(', tm.vlr_aporte_us');
  DMPrincipal.ADOQCambio.SQL.Add(', tm.dat_cadastro');
  DMPrincipal.ADOQCambio.SQL.Add(', ts.dsc_status as situacao');
  DMPrincipal.ADOQCambio.SQL.Add(', substring(tm.dsc_observacao,1,40) as dsc_observacao');
  DMPrincipal.ADOQCambio.SQL.Add('from t_cambio tm');
  DMPrincipal.ADOQCambio.SQL.Add(', t_carteira tc');
  DMPrincipal.ADOQCambio.SQL.Add(', t_proprietario tp');
  DMPrincipal.ADOQCambio.SQL.Add(', t_status ts');
  DMPrincipal.ADOQCambio.SQL.Add('where tm.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQCambio.SQL.Add('and tm.cod_proprietario = tp.cod_proprietario');
  DMPrincipal.ADOQCambio.SQL.Add('and tm.cod_status = ts.cod_status');

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    DMPrincipal.ADOQCambio.SQL.Add('and tm.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
  end;

  // Filtro por CARTEIRA...
  if dblkCarteira.Text <> '' then
  begin
    DMPrincipal.ADOQCambio.SQL.Add('and tm.cod_carteira = ' + quotedstr(dblkCarteira.KeyValue));
  end;

  // Filtro por STATUS...
  if dblkStatus.Text <> '' then
  begin
    DMPrincipal.ADOQCambio.SQL.Add('and tm.cod_status = ' + quotedstr(dblkStatus.KeyValue));
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
        DMPrincipal.ADOQCambio.SQL.Add('and tm.dat_cambio between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
      end;
    end
    else
    begin
      dDataAberturaI := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaI.Text));
      DMPrincipal.ADOQCambio.SQL.Add('and tm.dat_cambio >= ' + quotedstr(dDataAberturaI));
    end;
  end
  else
  begin
    if mskeAberturaF.Text <> '  /  /    ' then
    begin
      dDataAberturaF := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaF.Text));
      DMPrincipal.ADOQCambio.SQL.Add('and tm.dat_cambio <= ' + quotedstr(dDataAberturaF));
    end;
  end;

  DMPrincipal.ADOQCambio.SQL.Add('order by tm.dat_cambio desc, tc.nom_carteira, tp.nom_proprietario');

  if rError = false then
  begin
    DMPrincipal.ADOQCambio.Open;

    relCambio := TqrRelCambio.Create(Self);
    relCambio.qrRelCambio.Preview;
    relCambio.Free;

  end;
end;

end.
