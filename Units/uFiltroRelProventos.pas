{------------------------------------------------------------------------------------------------------
 Objetivo    : Relatório de Proventos
 Autor       : Robson Moraes
 Data        : 2019
 Atualização : 01/03/2023 - Troquei de note e por causa do formato da data americana
               tive que trocar para o formato brasileiro - v.06.
             : 02/03/2023 - Retirei média para sobrar mnais espaços - renda passiva aumentando...
------------------------------------------------------------------------------------------------------}

unit uFiltroRelProventos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDM, ADODB, StdCtrls, Mask, Buttons, DBCtrls, ExtCtrls;

type
  TfrmFiltroRelProventos = class(TForm)
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
    mskeAberturaI: TMaskEdit;
    mskeAberturaF: TMaskEdit;
    dblkStatus: TDBLookupComboBox;
    dblkCarteira: TDBLookupComboBox;
    dblkAtivo: TDBLookupComboBox;
    procedure btnSairClick(Sender: TObject);
    procedure dbtLimparClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroRelProventos: TfrmFiltroRelProventos;
  dDataAberturaI, dDataAberturaF, dDataVenctoI, dDataVenctoF, filtro : string;

implementation

uses uQrProventos;

{$R *.dfm}

procedure TfrmFiltroRelProventos.btnSairClick(Sender: TObject);
begin
  Close;
  frmFiltroRelProventos := nil;
end;

procedure TfrmFiltroRelProventos.dbtLimparClick(Sender: TObject);
begin
  dblkTipoInvest.KeyValue := -1;
  dblkInvestidor.KeyValue := -1;
  dblkAtivo.KeyValue := -1;
  dblkCarteira.KeyValue := -1;
  dblkStatus.KeyValue := -1;
  mskeAberturaI.Text := '';
  mskeAberturaF.Text := '';
  filtro := 'Filtro de Pesquisa: ';
end;

procedure TfrmFiltroRelProventos.btnGerarClick(Sender: TObject);
  var
  relProventos : TqrRelProventos;
  rError : boolean;
begin
  rError := false;

  DMPrincipal.ADOQTotalInvestido.Close;
  DMPrincipal.ADOQTotalInvestido.SQL.Clear;
  DMPrincipal.ADOQTotalInvestido.SQL.Add('/* Query auxiliar para pegar o valor total investido... */');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('IF Object_ID(''tempDB..#temp_totinvestimentos'',''U'') is not null DROP TABLE #temp_totinvestimentos');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('select ta.nom_ativo, a.val_atualizado');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('INTO #temp_totinvestimentos');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nro_cotas) as nro_cotas, ti.cod_ativo');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('FROM t_investimento ti');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('WHERE 1=1');

  DMPrincipal.ADOQTotalInvestido.SQL.Add('and ti.cod_status <> 4');

  // novo
  if dblkAtivo.Text <> '' then
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and ti.cod_ativo = ' + quotedstr(dblkAtivo.KeyValue));

  if dblkTipoInvest.Text <> '' then
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and ti.cod_tipoinvestimento = ' + quotedstr(dblkTipoInvest.KeyValue));

  if dblkCarteira.Text <> '' then
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and ti.cod_carteira = ' + quotedstr(dblkCarteira.KeyValue));

  if dblkStatus.Text <> '' then
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and ti.cod_status = ' + quotedstr(dblkStatus.KeyValue));

  if dblkInvestidor.Text <> '' then
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and ti.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));

  //

  DMPrincipal.ADOQTotalInvestido.SQL.Add('GROUP BY ti.cod_ativo) a');
  DMPrincipal.ADOQTotalInvestido.SQL.Add(', t_provento tr');
  DMPrincipal.ADOQTotalInvestido.SQL.Add(', t_ativo ta');
  DMPrincipal.ADOQTotalInvestido.SQL.Add(', t_investimento ti2');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('where a.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('and ta.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('and ta.cod_ativo = ti2.cod_ativo');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('and tr.cod_carteira = ti2.cod_carteira');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('and ti2.cod_status <> 4');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('and ta.cod_tipoinvestimento = ti2.cod_tipoinvestimento');

  // query principal...
  DMPrincipal.ADOQProventosAno.Close;
  DMPrincipal.ADOQProventosAno.SQL.Clear;
  DMPrincipal.ADOQProventosAno.SQL.Add('/* Query estatística para listar os proventos dos ativos ao longo do ano... */');
  DMPrincipal.ADOQProventosAno.SQL.Add('select ta.nom_ativo,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(a.val_atualizado,''C'', ''pt-br'') as val_atualizado,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(a.nro_cotas, ''N'', ''pt-br'') as nro_cotas,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT((a.val_atualizado / a.nro_cotas), ''C'', ''pt-br'') as preco_medio,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 1) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as janeiro,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 2) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as fevereiro,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 3) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as marco,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 4) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as abril,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 5) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as maio,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 6) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as junho,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 7) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as julho,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 8) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as agosto,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 9) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as setembro,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 10) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as outubro,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 11) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as novembro,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 12) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as dezembro,');
  DMPrincipal.ADOQProventosAno.SQL.Add('FORMAT(sum(tr.vlr_total), ''C'', ''pt-br'') as total');
  DMPrincipal.ADOQProventosAno.SQL.Add('from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nro_cotas) as nro_cotas, ti.cod_ativo');
  DMPrincipal.ADOQProventosAno.SQL.Add('FROM t_investimento ti');
  DMPrincipal.ADOQProventosAno.SQL.Add('WHERE 1=1');

  DMPrincipal.ADOQProventosAno.SQL.Add('and ti.cod_status <> 4');

  // novo
  if dblkAtivo.Text <> '' then
    DMPrincipal.ADOQProventosAno.SQL.Add('and ti.cod_ativo = ' + quotedstr(dblkAtivo.KeyValue));

  if dblkTipoInvest.Text <> '' then
    DMPrincipal.ADOQProventosAno.SQL.Add('and ti.cod_tipoinvestimento = ' + quotedstr(dblkTipoInvest.KeyValue));

  if dblkCarteira.Text <> '' then
    DMPrincipal.ADOQProventosAno.SQL.Add('and ti.cod_carteira = ' + quotedstr(dblkCarteira.KeyValue));

  if dblkStatus.Text <> '' then
    DMPrincipal.ADOQProventosAno.SQL.Add('and ti.cod_status = ' + quotedstr(dblkStatus.KeyValue));

  if dblkInvestidor.Text <> '' then
    DMPrincipal.ADOQProventosAno.SQL.Add('and ti.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
  //

  DMPrincipal.ADOQProventosAno.SQL.Add('GROUP BY ti.cod_ativo) a');
  DMPrincipal.ADOQProventosAno.SQL.Add(', t_provento tr');
  DMPrincipal.ADOQProventosAno.SQL.Add(', t_ativo ta');
  DMPrincipal.ADOQProventosAno.SQL.Add(', t_carteira tc');
  DMPrincipal.ADOQProventosAno.SQL.Add(', t_proprietario tp');
  DMPrincipal.ADOQProventosAno.SQL.Add(', t_investimento ti2');
  DMPrincipal.ADOQProventosAno.SQL.Add('where a.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQProventosAno.SQL.Add('and ta.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQProventosAno.SQL.Add('and tr.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQProventosAno.SQL.Add('and tc.cod_proprietario = tp.cod_proprietario');
  DMPrincipal.ADOQProventosAno.SQL.Add('and ti2.cod_proprietario = tc.cod_proprietario');
  DMPrincipal.ADOQProventosAno.SQL.Add('and ti2.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQProventosAno.SQL.Add('and ti2.cod_ativo = ta.cod_ativo');

  DMPrincipal.ADOQProventosAno.SQL.Add('and ti2.cod_status <> 4');

  // Filtro por ATIVO...
  if dblkAtivo.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkAtivo.Text;
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and tr.cod_ativo = ' + quotedstr(dblkAtivo.KeyValue));
    DMPrincipal.ADOQProventosAno.SQL.Add('and tr.cod_ativo = ' + quotedstr(dblkAtivo.KeyValue));
  end;

  // Filtro por TIPO DE INVESTIMENTO...
  if dblkTipoInvest.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkTipoInvest.Text;
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and ta.cod_tipoinvestimento = ' + quotedstr(dblkTipoInvest.KeyValue));
    DMPrincipal.ADOQProventosAno.SQL.Add('and ta.cod_tipoinvestimento = ' + quotedstr(dblkTipoInvest.KeyValue));
  end;

  // Filtro por CARTEIRA...
  if dblkCarteira.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkCarteira.Text;
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and tr.cod_carteira = ' + quotedstr(dblkCarteira.KeyValue));
    DMPrincipal.ADOQProventosAno.SQL.Add('and tr.cod_carteira = ' + quotedstr(dblkCarteira.KeyValue));
  end;

  // Filtro por STATUS...
  if dblkStatus.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkStatus.Text;
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and ti2.cod_status = ' + quotedstr(dblkStatus.KeyValue));
    DMPrincipal.ADOQProventosAno.SQL.Add('and ti2.cod_status = ' + quotedstr(dblkStatus.KeyValue));
  end;

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkInvestidor.Text;
    DMPrincipal.ADOQTotalInvestido.SQL.Add('and ti2.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
    DMPrincipal.ADOQProventosAno.SQL.Add('and tp.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
  end;

  // Filtro por DATA DE ABERTURA...
  if mskeAberturaI.Text <> '  /    ' then
  begin
    if mskeAberturaF.Text <> '  /    ' then
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
        filtro := filtro + ' - ' + mskeAberturaI.Text + ' até ' + mskeAberturaF.Text;
        //dDataAberturaI := copy(mskeAberturaI.Text,4,7) + '-' + copy(mskeAberturaI.Text,1,2) + '-01';
        dDataAberturaI := '01-' + copy(mskeAberturaI.Text,1,2) + '-' + copy(mskeAberturaI.Text,4,7);

        if (copy(mskeAberturaF.Text,1,2) = '01') or
           (copy(mskeAberturaF.Text,1,2) = '03') or
           (copy(mskeAberturaF.Text,1,2) = '05') or
           (copy(mskeAberturaF.Text,1,2) = '07') or
           (copy(mskeAberturaF.Text,1,2) = '08') or
           (copy(mskeAberturaF.Text,1,2) = '10') or
           (copy(mskeAberturaF.Text,1,2) = '12') then
          //dDataAberturaF := copy(mskeAberturaF.Text,4,7) + '-' + copy(mskeAberturaF.Text,1,2) + '-31'
          dDataAberturaF := '31-' + copy(mskeAberturaF.Text,1,2) + '-' + copy(mskeAberturaF.Text,4,7)
        else
          if (copy(mskeAberturaF.Text,1,2) = '04') or
             (copy(mskeAberturaF.Text,1,2) = '06') or
             (copy(mskeAberturaF.Text,1,2) = '09') or
             (copy(mskeAberturaF.Text,1,2) = '11') then
            //dDataAberturaF := copy(mskeAberturaF.Text,4,7) + '-' + copy(mskeAberturaF.Text,1,2) + '-30'
            dDataAberturaF := '30-' + copy(mskeAberturaF.Text,1,2) + '-' + copy(mskeAberturaF.Text,4,7)
        else
            //dDataAberturaF := copy(mskeAberturaF.Text,4,7) + '-' + copy(mskeAberturaF.Text,1,2) + '-28';
            dDataAberturaF := '28-' + copy(mskeAberturaF.Text,1,2) + '-' + copy(mskeAberturaF.Text,4,7);

        DMPrincipal.ADOQTotalInvestido.SQL.Add('and tr.competencia between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
        DMPrincipal.ADOQProventosAno.SQL.Add('and tr.competencia between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
      end;
    end
    else
    begin
      filtro := filtro + ' - ' + mskeAberturaI.Text;
      //dDataAberturaI := copy(mskeAberturaI.Text,4,7) + '-' + copy(mskeAberturaI.Text,1,2) + '-01';
      dDataAberturaI := '01-' + copy(mskeAberturaI.Text,1,2) + '-' + copy(mskeAberturaI.Text,4,7);

      DMPrincipal.ADOQTotalInvestido.SQL.Add('and tr.competencia >= ' + quotedstr(dDataAberturaI));
      DMPrincipal.ADOQProventosAno.SQL.Add('and tr.competencia >= ' + quotedstr(dDataAberturaI));
    end;
  end
  else
  begin
    if mskeAberturaF.Text <> '  /    ' then
    begin
      filtro := filtro + ' - ' + mskeAberturaF.Text;

      if (copy(mskeAberturaF.Text,1,2) = '01') or
         (copy(mskeAberturaF.Text,1,2) = '03') or
         (copy(mskeAberturaF.Text,1,2) = '05') or
         (copy(mskeAberturaF.Text,1,2) = '07') or
         (copy(mskeAberturaF.Text,1,2) = '08') or
         (copy(mskeAberturaF.Text,1,2) = '10') or
         (copy(mskeAberturaF.Text,1,2) = '12') then
          // dDataAberturaF := copy(mskeAberturaF.Text,4,7) + '-' + copy(mskeAberturaF.Text,1,2) + '-31'
          dDataAberturaF := '31-' + copy(mskeAberturaF.Text,1,2) + '-' + copy(mskeAberturaF.Text,4,7)
        else
          if (copy(mskeAberturaF.Text,1,2) = '04') or
             (copy(mskeAberturaF.Text,1,2) = '06') or
             (copy(mskeAberturaF.Text,1,2) = '09') or
             (copy(mskeAberturaF.Text,1,2) = '11') then
            //dDataAberturaF := copy(mskeAberturaF.Text,4,7) + '-' + copy(mskeAberturaF.Text,1,2) + '-30'
            dDataAberturaF := '30-' + copy(mskeAberturaF.Text,1,2) + '-' + copy(mskeAberturaF.Text,4,7)
        else
            //dDataAberturaF := copy(mskeAberturaF.Text,4,7) + '-' + copy(mskeAberturaF.Text,1,2) + '-28';
            dDataAberturaF := '28-' + copy(mskeAberturaF.Text,1,2) + '-' + copy(mskeAberturaF.Text,4,7);

      DMPrincipal.ADOQTotalInvestido.SQL.Add('and tr.competencia <= ' + quotedstr(dDataAberturaF));
      DMPrincipal.ADOQProventosAno.SQL.Add('and tr.competencia <= ' + quotedstr(dDataAberturaF));
    end;
  end;

  // Agrupamentos...

  // primeira query...
  DMPrincipal.ADOQTotalInvestido.SQL.Add('group by ta.nom_ativo, a.val_atualizado');
  DMPrincipal.ADOQTotalInvestido.SQL.Add('select FORMAT(sum(t.val_atualizado),''C'', ''pt-br'') as val_investido from #temp_totinvestimentos t');

  // segunda query...
  DMPrincipal.ADOQProventosAno.SQL.Add('group by ta.nom_ativo, a.val_atualizado, a.nro_cotas');
  DMPrincipal.ADOQProventosAno.SQL.Add('order by ta.nom_ativo');

  if rError = false then
  begin
    DMPrincipal.ADOQTotalInvestido.Open;
    DMPrincipal.ADOQProventosAno.Open;

    relProventos := TqrRelProventos.Create(Self);
    relProventos.lblFiltro.Caption := filtro;
    relProventos.qrRelProventos.Preview;
    relProventos.Free;
    filtro := 'Filtro de Pesquisa: ';
  end;
end;

procedure TfrmFiltroRelProventos.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Open;
  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSStatus.Open;
  DMPrincipal.ADODSCarteira.Open;

  mskeAberturaI.Enabled := true;
  mskeAberturaF.Enabled := true;
end;

procedure TfrmFiltroRelProventos.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  mskeAberturaI.Text := '01/2023';
  mskeAberturaF.Text := '12/2023';

  shortdateformat := 'dd/mm/yyyy';
  filtro := 'Filtro de Pesquisa: ';
end;

end.
