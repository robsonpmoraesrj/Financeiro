unit uFrmConsultaProventos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, DBCtrls, ExtCtrls, Mask;

type
  TfrmConsultaProventos = class(TForm)
    dbgConsulta: TDBGrid;
    Panel1: TPanel;
    btnSair: TBitBtn;
    Panel2: TPanel;
    gbDataAtualizacao: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    mskeAberturaI: TMaskEdit;
    mskeAberturaF: TMaskEdit;
    btnPesquisar: TBitBtn;
    dbtLimpar: TBitBtn;
    edtValAtualizado: TEdit;
    Label1: TLabel;
    edtQtdCotas: TEdit;
    edtPrecMedio: TEdit;
    edtJaneiro: TEdit;
    edtFevereiro: TEdit;
    edtMarco: TEdit;
    edtAbril: TEdit;
    edtMaio: TEdit;
    edtJunho: TEdit;
    edtJulho: TEdit;
    edtAgosto: TEdit;
    edtSetembro: TEdit;
    edtOutubro: TEdit;
    edtNovembro: TEdit;
    edtDezembro: TEdit;
    edtTotal: TEdit;
    edtMedia: TEdit;
    gbStatus: TGroupBox;
    chkBFIIs: TCheckBox;
    chkBAcoes: TCheckBox;
    chkBRF: TCheckBox;
    chkBTodos: TCheckBox;
    GroupBox1: TGroupBox;
    dblkInvestidor: TDBLookupComboBox;
    chkBReits: TCheckBox;
    chkBETFs: TCheckBox;
    chkBStocks: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbtLimparClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure chkBFIIsClick(Sender: TObject);
    procedure chkBAcoesClick(Sender: TObject);
    procedure chkBReitsClick(Sender: TObject);
    procedure chkBETFsClick(Sender: TObject);
    procedure chkBStocksClick(Sender: TObject);
    procedure chkBRFClick(Sender: TObject);
    procedure chkBTodosClick(Sender: TObject);
  private
    { Private declarations }
    procedure atribuiValores();
    procedure controlaChecks();
    procedure filtraChecks1();
    procedure filtraChecks2();
    procedure filtraChecks3();
    procedure filtraChecks4();
    procedure limpaGrid();
  public
    { Public declarations }
  end;

var
  frmConsultaProventos: TfrmConsultaProventos;
  dDataAberturaI, dDataAberturaF : string;

implementation

uses uDM;

{$R *.dfm}

procedure TfrmConsultaProventos.FormCreate(Sender: TObject);
begin
  DMPrincipal.ADOQConProventosAno.Close;
  DMPrincipal.ADOQConAux1.Close;
  DMPrincipal.ADOQConProventosAno.Open;
  DMPrincipal.ADOQConAux1.Open;
end;

procedure TfrmConsultaProventos.btnSairClick(Sender: TObject);
begin
  Close;
  frmConsultaProventos := nil;
end;

procedure TfrmConsultaProventos.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADOQConProventosAno.Close;
  DMPrincipal.ADOQConAux1.Close;
  DMPrincipal.ADOQConProventosAno.Open;
  DMPrincipal.ADOQConAux1.Open;
  DMPrincipal.ADODSInvestidor.Open;

  mskeAberturaI.Text := '01/2023';
  mskeAberturaF.Text := '12/2023';
  mskeAberturaI.Enabled := true;
  mskeAberturaF.Enabled := true;

  // atribuição dos valores...
  edtValAtualizado.Text := DMPrincipal.ADOQConAux1val_atualizado.AsString;
  edtQtdCotas.Text := DMPrincipal.ADOQConAux1nro_cotas.AsString;
  edtPrecMedio.Text := DMPrincipal.ADOQConAux1preco_medio.AsString;
  edtJaneiro.Text := DMPrincipal.ADOQConAux1janeiro.AsString;
  edtFevereiro.Text := DMPrincipal.ADOQConAux1fevereiro.AsString;
  edtMarco.Text := DMPrincipal.ADOQConAux1marco.AsString;
  edtAbril.Text := DMPrincipal.ADOQConAux1abril.AsString;
  edtMaio.Text := DMPrincipal.ADOQConAux1maio.AsString;
  edtJunho.Text := DMPrincipal.ADOQConAux1junho.AsString;
  edtJulho.Text := DMPrincipal.ADOQConAux1julho.AsString;
  edtAgosto.Text := DMPrincipal.ADOQConAux1agosto.AsString;
  edtSetembro.Text := DMPrincipal.ADOQConAux1setembro.AsString;
  edtOutubro.Text := DMPrincipal.ADOQConAux1outubro.AsString;
  edtNovembro.Text := DMPrincipal.ADOQConAux1novembro.AsString;
  edtDezembro.Text := DMPrincipal.ADOQConAux1dezembro.AsString;
  edtTotal.Text := DMPrincipal.ADOQConAux1total.AsString;
  edtMedia.Text := DMPrincipal.ADOQConAux1media.AsString;
end;

procedure TfrmConsultaProventos.dbtLimparClick(Sender: TObject);
begin
  mskeAberturaI.Text := '01/2023';
  mskeAberturaF.Text := '12/2023';
  dblkInvestidor.KeyValue := -1;
  chkBTodos.Checked := true;
  chkBFIIs.Checked := false;
  chkBAcoes.Checked := false;
  chkBReits.Checked := false;
  chkBETFs.Checked := false;
  chkBStocks.Checked := false;
  chkBRF.Checked := false;
  limpaGrid;
  dbgConsulta.Refresh;
  DMPrincipal.ADOQConProventosAno.Close;
  DMPrincipal.ADOQConAux1.Close;
  DMPrincipal.ADOQConProventosAno.Open;
  DMPrincipal.ADOQConAux1.Open;
  DMPrincipal.ADODSInvestidor.Open;

  mskeAberturaI.Text := '01/2023';
  mskeAberturaF.Text := '12/2023';
  mskeAberturaI.Enabled := true;
  mskeAberturaF.Enabled := true;

  // atribuição dos valores...
  edtValAtualizado.Text := DMPrincipal.ADOQConAux1val_atualizado.AsString;
  edtQtdCotas.Text := DMPrincipal.ADOQConAux1nro_cotas.AsString;
  edtPrecMedio.Text := DMPrincipal.ADOQConAux1preco_medio.AsString;
  edtJaneiro.Text := DMPrincipal.ADOQConAux1janeiro.AsString;
  edtFevereiro.Text := DMPrincipal.ADOQConAux1fevereiro.AsString;
  edtMarco.Text := DMPrincipal.ADOQConAux1marco.AsString;
  edtAbril.Text := DMPrincipal.ADOQConAux1abril.AsString;
  edtMaio.Text := DMPrincipal.ADOQConAux1maio.AsString;
  edtJunho.Text := DMPrincipal.ADOQConAux1junho.AsString;
  edtJulho.Text := DMPrincipal.ADOQConAux1julho.AsString;
  edtAgosto.Text := DMPrincipal.ADOQConAux1agosto.AsString;
  edtSetembro.Text := DMPrincipal.ADOQConAux1setembro.AsString;
  edtOutubro.Text := DMPrincipal.ADOQConAux1outubro.AsString;
  edtNovembro.Text := DMPrincipal.ADOQConAux1novembro.AsString;
  edtDezembro.Text := DMPrincipal.ADOQConAux1dezembro.AsString;
  edtTotal.Text := DMPrincipal.ADOQConAux1total.AsString;
  edtMedia.Text := DMPrincipal.ADOQConAux1media.AsString;
end;

procedure TfrmConsultaProventos.btnPesquisarClick(Sender: TObject);
  var
  rError : boolean;
begin
  rError := false;

  // query principal...
  DMPrincipal.ADOQConProventosAno.Close;
  DMPrincipal.ADOQConProventosAno.SQL.Clear;
  DMPrincipal.ADOQConProventosAno.SQL.Add('/* Query estatística para listar os proventos dos ativos ao longo do ano - consulta em tela... */');
  DMPrincipal.ADOQConProventosAno.SQL.Add('select ta.nom_ativo,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(a.val_atualizado,''C'', ''pt-br'') as val_atualizado,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(a.nro_cotas, ''N'', ''pt-br'') as nro_cotas,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT((a.val_atualizado / a.nro_cotas), ''C'', ''pt-br'') as preco_medio,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 1) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as janeiro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 2) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as fevereiro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 3) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as marco,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 4) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as abril,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 5) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as maio,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 6) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as junho,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 7) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as julho,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 8) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as agosto,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 9) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as setembro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 10) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as outubro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 11) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as novembro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 12) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as dezembro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(tr.vlr_total), ''C'', ''pt-br'') as total,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT((sum(tr.vlr_total)/12), ''C'', ''pt-br'') as media');
  DMPrincipal.ADOQConProventosAno.SQL.Add('from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nro_cotas) as nro_cotas, ti.cod_ativo');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FROM t_investimento ti, t_tipoinvestimento te');
  DMPrincipal.ADOQConProventosAno.SQL.Add('WHERE 1=1');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti.cod_status <> 4');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti.cod_tipoinvestimento = te.cod_tipoinvestimento');

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    DMPrincipal.ADOQConProventosAno.SQL.Add('and ti.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
  end;
  //DMPrincipal.ADOQConProventosAno.SQL.Add('and ti.cod_proprietario = ''1''');

  // Filtro por TIPO DE INVESTIMENTO...
  filtraChecks1;

  DMPrincipal.ADOQConProventosAno.SQL.Add('GROUP BY ti.cod_ativo) a');
  DMPrincipal.ADOQConProventosAno.SQL.Add(', t_provento tr, t_ativo ta, t_carteira tc, t_proprietario tp, t_investimento ti2, t_tipoinvestimento te2');
  DMPrincipal.ADOQConProventosAno.SQL.Add('where a.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ta.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and tr.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and tc.cod_proprietario = tp.cod_proprietario');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_proprietario = tc.cod_proprietario');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_ativo = ta.cod_ativo');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_status <> 4');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_tipoinvestimento = te2.cod_tipoinvestimento');

  // Filtro por TIPO DE INVESTIMENTO...
  filtraChecks2;

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    DMPrincipal.ADOQConProventosAno.SQL.Add('and tp.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
  end;
  //DMPrincipal.ADOQConProventosAno.SQL.Add('and tp.cod_proprietario = ''1''');

  // Filtro por DATAS...
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

        DMPrincipal.ADOQConProventosAno.SQL.Add('and tr.competencia between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
        //DMPrincipal.ADOQConAux1.SQL.Add('and tr.competencia between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
      end;
    end
    else
    begin
      //dDataAberturaI := copy(mskeAberturaI.Text,4,7) + '-' + copy(mskeAberturaI.Text,1,2) + '-01';
      dDataAberturaI := '01-' + copy(mskeAberturaI.Text,1,2) + '-' + copy(mskeAberturaI.Text,4,7);

      DMPrincipal.ADOQConProventosAno.SQL.Add('and tr.competencia >= ' + quotedstr(dDataAberturaI));
      //DMPrincipal.ADOQConAux1.SQL.Add('and tr.competencia >= ' + quotedstr(dDataAberturaI));
    end;
  end
  else
  begin
    if mskeAberturaF.Text <> '  /    ' then
    begin
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

      DMPrincipal.ADOQConProventosAno.SQL.Add('and tr.competencia <= ' + quotedstr(dDataAberturaF));
      //DMPrincipal.ADOQConAux1.SQL.Add('and tr.competencia <= ' + quotedstr(dDataAberturaF));
    end;
  end;
  //DMPrincipal.ADOQConProventosAno.SQL.Add('and tr.competencia between ''01-01-2023'' and ''31-12-2023''');

  DMPrincipal.ADOQConProventosAno.SQL.Add('group by ta.nom_ativo, a.val_atualizado, a.nro_cotas');
  DMPrincipal.ADOQConProventosAno.SQL.Add('order by ta.nom_ativo');

  // query auxiliar...
  DMPrincipal.ADOQConAux1.Close;
  DMPrincipal.ADOQConAux1.SQL.Clear;
  DMPrincipal.ADOQConAux1.SQL.Add('/* Query estatística para listar os proventos dos ativos ao longo do ano - Auxiliar... */');
  DMPrincipal.ADOQConAux1.SQL.Add('select');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(a.val_atualizado,''C'', ''pt-br'') as val_atualizado,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(a.nro_cotas, ''N'', ''pt-br'') as nro_cotas,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT((a.val_atualizado / a.nro_cotas), ''C'', ''pt-br'') as preco_medio,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 1) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as janeiro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 2) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as fevereiro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 3) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as marco,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 4) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as abril,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 5) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as maio,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 6) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as junho,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 7) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as julho,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 8) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as agosto,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 9) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as setembro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 10) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as outubro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 11) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as novembro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 12) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as dezembro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(tr.vlr_total), ''C'', ''pt-br'') as total,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT((sum(tr.vlr_total)/12), ''C'', ''pt-br'') as media');
  DMPrincipal.ADOQConAux1.SQL.Add('from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nro_cotas) as nro_cotas');
  DMPrincipal.ADOQConAux1.SQL.Add('FROM t_investimento ti, t_tipoinvestimento te');
  DMPrincipal.ADOQConAux1.SQL.Add('WHERE 1=1');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti.cod_tipoinvestimento = te.cod_tipoinvestimento');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti.cod_status <> 4');

  // Filtro por TIPO DE INVESTIMENTO...
  filtraChecks3;

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    DMPrincipal.ADOQConAux1.SQL.Add('and ti.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue) + ') a ');
  end
  else
    DMPrincipal.ADOQConAux1.SQL.Add(') a');

  DMPrincipal.ADOQConAux1.SQL.Add(', t_provento tr, t_ativo ta, t_carteira tc, t_proprietario tp, t_investimento ti2, t_tipoinvestimento te2');
  DMPrincipal.ADOQConAux1.SQL.Add('where');
  DMPrincipal.ADOQConAux1.SQL.Add('ta.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQConAux1.SQL.Add('and tr.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQConAux1.SQL.Add('and tc.cod_proprietario = tp.cod_proprietario');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_proprietario = tc.cod_proprietario');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_ativo = ta.cod_ativo');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_status <> 4');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_tipoinvestimento = te2.cod_tipoinvestimento');

  // Filtro por TIPO DE INVESTIMENTO...
  filtraChecks4;

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    DMPrincipal.ADOQConAux1.SQL.Add('and tp.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
  end;
  //DMPrincipal.ADOQConAux1.SQL.Add('and tp.cod_proprietario = ''1''');

  // Filtro por DATAS...
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

        DMPrincipal.ADOQConAux1.SQL.Add('and tr.competencia between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
      end;
    end
    else
    begin
      //dDataAberturaI := copy(mskeAberturaI.Text,4,7) + '-' + copy(mskeAberturaI.Text,1,2) + '-01';
      dDataAberturaI := '01-' + copy(mskeAberturaI.Text,1,2) + '-' + copy(mskeAberturaI.Text,4,7);

      DMPrincipal.ADOQConAux1.SQL.Add('and tr.competencia >= ' + quotedstr(dDataAberturaI));
    end;
  end
  else
  begin
    if mskeAberturaF.Text <> '  /    ' then
    begin
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

      DMPrincipal.ADOQConAux1.SQL.Add('and tr.competencia <= ' + quotedstr(dDataAberturaF));
    end;
  end;

  //DMPrincipal.ADOQConAux1.SQL.Add('and tr.competencia between ''01-01-2023'' and ''31-12-2023''');

  DMPrincipal.ADOQConAux1.SQL.Add('group by a.val_atualizado, a.nro_cotas');

  if rError = false then
  begin
    DMPrincipal.ADOQConProventosAno.Open;
    DMPrincipal.ADOQConAux1.Open;
  end;

  atribuiValores;
end;

procedure TfrmConsultaProventos.atribuiValores();
begin
  // atribuição dos valores...
  edtValAtualizado.Text := DMPrincipal.ADOQConAux1val_atualizado.AsString;
  edtQtdCotas.Text := DMPrincipal.ADOQConAux1nro_cotas.AsString;
  edtPrecMedio.Text := DMPrincipal.ADOQConAux1preco_medio.AsString;
  edtJaneiro.Text := DMPrincipal.ADOQConAux1janeiro.AsString;
  edtFevereiro.Text := DMPrincipal.ADOQConAux1fevereiro.AsString;
  edtMarco.Text := DMPrincipal.ADOQConAux1marco.AsString;
  edtAbril.Text := DMPrincipal.ADOQConAux1abril.AsString;
  edtMaio.Text := DMPrincipal.ADOQConAux1maio.AsString;
  edtJunho.Text := DMPrincipal.ADOQConAux1junho.AsString;
  edtJulho.Text := DMPrincipal.ADOQConAux1julho.AsString;
  edtAgosto.Text := DMPrincipal.ADOQConAux1agosto.AsString;
  edtSetembro.Text := DMPrincipal.ADOQConAux1setembro.AsString;
  edtOutubro.Text := DMPrincipal.ADOQConAux1outubro.AsString;
  edtNovembro.Text := DMPrincipal.ADOQConAux1novembro.AsString;
  edtDezembro.Text := DMPrincipal.ADOQConAux1dezembro.AsString;
  edtTotal.Text := DMPrincipal.ADOQConAux1total.AsString;
  edtMedia.Text := DMPrincipal.ADOQConAux1media.AsString;
end;

procedure TfrmConsultaProventos.chkBFIIsClick(Sender: TObject);
begin
  controlaChecks;
end;

procedure TfrmConsultaProventos.controlaChecks();
begin
  if chkBFIIs.Checked = true or
     chkBAcoes.Checked = true or
     chkBReits.Checked = true or
     chkBETFs.Checked = true or
     chkBStocks.Checked = true or
     chkBRF.Checked = true then
    chkBTodos.Checked := false
  else
    if chkBFIIs.Checked = false and
     chkBAcoes.Checked = false and
     chkBReits.Checked = false and
     chkBETFs.Checked = false and
     chkBStocks.Checked = false and
     chkBRF.Checked = false then
    chkBTodos.Checked := true;
end;

procedure TfrmConsultaProventos.filtraChecks1();
begin
  // Filtro por TIPO DE INVESTIMENTO...
  if not chkBTodos.Checked then
  begin
    chkBFIIs.enabled := true;
    chkBAcoes.enabled := true;
    chkBReits.enabled := true;
    chkBETFs.enabled := true;
    chkBStocks.enabled := true;
    chkBRF.enabled := true;

    // todos...
    if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
    begin
      chkBTodos.Checked := true;
      DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,3,4,5,6,8,9,10,11,14,15,16,17,18,19,20,21,22,23,24,25,26)');
    end
    else
      // somente Ações...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,19)')
      else // somente FIIs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2)')
      else // somente Reits...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (4)')
      else // somente ETFs...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (5,6,8,9,10,11)')
      else // somente Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (3)')
      else // somente Renda Fixa...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (14,15,16,17,18,21,22,24,26)')

      else // Ações e FIIs...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,19)')
      else // Ações e Reits...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,4,19)')
      else // Ações e ETFs...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,19,5,6,8,9,10,11)')
      else // Ações e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,19,3)')
      else // Ações e Renda Fixa...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,19,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs e Reits...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,19,4)')
      else // Ações, FIIs e ETFs...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,4,19,5,6,8,9,10,11)')
      else // Ações, FIIs e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,3,19,5,6,8,9,10,11)')
      else // Ações, FIIs e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,19,3,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs, Reits e ETFs...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,19,4,5,6,8,9,10,11)')
      else // Ações, FIIs, Reits e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,19,4,3)')
      else // Ações, FIIs, Reits e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,19,4,14,15,16,17,18,21,22,24,26)')

      else // Ações, Reits e ETFs...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,4,19,5,6,8,9,10,11)')
      else // Ações, Reits e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,4,19,3)')
      else // Ações, Reits e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,4,19,14,15,16,17,18,21,22,24,26)')

      else // Ações, ETFs e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,19,5,6,8,9,10,11,3)')
      else // Ações, ETFs e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,19,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // Ações, Stocks e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,19,3,14,15,16,17,18,21,22,24,26)')

      else // FIIs e Reits...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2,4)')
      else // FIIs e ETFs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2,5,6,8,9,10,11)')
      else // FIIs e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2,3)')
      else // FIIs e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2,14,15,16,17,18,21,22,24,26)')

      else // FIIs, Reits e ETFs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2,4,5,6,8,9,10,11)')
      else // FIIs, Reits e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2,4,3)')
      else // FIIs, Reits e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2,4,14,15,16,17,18,21,22,24,26)')

      else // FIIs, Reits, ETFs e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2,4,5,6,8,9,10,11,3)')
      else // FIIs, Reits, ETFs e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (2,4,5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

      else // Reits e ETFs...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (4,5,6,8,9,10,11)')
      else // Reits e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (4,3)')
      else // Reits e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (4,14,15,16,17,18,21,22,24,26)')

      else // Reits, ETFs e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (4,5,6,8,9,10,11,3)')
      else // Reits, ETFs e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // ETFs e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (5,6,8,9,10,11,3)')
      else // ETFs e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // ETFs, Stocks e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs, Reits, ETFs e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,4,5,6,8,9,10,11,3)')
      else // Ações, FIIs, Reits, ETFs e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,2,4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')
      else // Ações, Reits, ETFs e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (1,4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // Reits, ETFs, Stocks e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te.cod_tipoinvestimento in (4,5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

  end
  else
  begin
    chkBFIIs.Checked := false;
    chkBAcoes.Checked := false;
    chkBReits.Checked := false;
    chkBETFs.Checked := false;
    chkBStocks.Checked := false;
    chkBRF.Checked := false;

    chkBFIIs.enabled := false;
    chkBAcoes.enabled := false;
    chkBReits.enabled := false;
    chkBETFs.enabled := false;
    chkBStocks.enabled := false;
    chkBRF.enabled := false;
  end;
end;

procedure TfrmConsultaProventos.filtraChecks2();
begin
  // Filtro por TIPO DE INVESTIMENTO...
  if not chkBTodos.Checked then
  begin
    chkBFIIs.enabled := true;
    chkBAcoes.enabled := true;
    chkBReits.enabled := true;
    chkBETFs.enabled := true;
    chkBStocks.enabled := true;
    chkBRF.enabled := true;

    // todos...
    if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
    begin
      chkBTodos.Checked := true;
      DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,3,4,5,6,8,9,10,11,14,15,16,17,18,19,20,21,22,23,24,25,26)');
    end
    else
      // somente Ações...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,19)')
      else // somente FIIs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2)')
      else // somente Reits...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (4)')
      else // somente ETFs...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (5,6,8,9,10,11)')
      else // somente Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (3)')
      else // somente Renda Fixa...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (14,15,16,17,18,21,22,24,26)')

      else // Ações e FIIs...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19)')
      else // Ações e Reits...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,4,19)')
      else // Ações e ETFs...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,19,5,6,8,9,10,11)')
      else // Ações e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,19,3)')
      else // Ações e Renda Fixa...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,19,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs e Reits...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19,4)')
      else // Ações, FIIs e ETFs...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,4,19,5,6,8,9,10,11)')
      else // Ações, FIIs e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,3,19,5,6,8,9,10,11)')
      else // Ações, FIIs e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,19,3,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs, Reits e ETFs...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19,4,5,6,8,9,10,11)')
      else // Ações, FIIs, Reits e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19,4,3)')
      else // Ações, FIIs, Reits e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19,4,14,15,16,17,18,21,22,24,26)')

      else // Ações, Reits e ETFs...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,4,19,5,6,8,9,10,11)')
      else // Ações, Reits e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,4,19,3)')
      else // Ações, Reits e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,4,19,14,15,16,17,18,21,22,24,26)')

      else // Ações, ETFs e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,19,5,6,8,9,10,11,3)')
      else // Ações, ETFs e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,19,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // Ações, Stocks e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,19,3,14,15,16,17,18,21,22,24,26)')

      else // FIIs e Reits...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2,4)')
      else // FIIs e ETFs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2,5,6,8,9,10,11)')
      else // FIIs e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2,3)')
      else // FIIs e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2,14,15,16,17,18,21,22,24,26)')

      else // FIIs, Reits e ETFs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2,4,5,6,8,9,10,11)')
      else // FIIs, Reits e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2,4,3)')
      else // FIIs, Reits e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2,4,14,15,16,17,18,21,22,24,26)')

      else // FIIs, Reits, ETFs e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2,4,5,6,8,9,10,11,3)')
      else // FIIs, Reits, ETFs e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (2,4,5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

      else // Reits e ETFs...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (4,5,6,8,9,10,11)')
      else // Reits e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (4,3)')
      else // Reits e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (4,14,15,16,17,18,21,22,24,26)')

      else // Reits, ETFs e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (4,5,6,8,9,10,11,3)')
      else // Reits, ETFs e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // ETFs e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (5,6,8,9,10,11,3)')
      else // ETFs e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // ETFs, Stocks e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs, Reits, ETFs e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,4,5,6,8,9,10,11,3)')
      else // Ações, FIIs, Reits, ETFs e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,2,4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')
      else // Ações, Reits, ETFs e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (1,4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // Reits, ETFs, Stocks e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConProventosAno.SQL.Add('and te2.cod_tipoinvestimento in (4,5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')
  end
  else
  begin
    chkBFIIs.Checked := false;
    chkBAcoes.Checked := false;
    chkBReits.Checked := false;
    chkBETFs.Checked := false;
    chkBStocks.Checked := false;
    chkBRF.Checked := false;

    chkBFIIs.enabled := false;
    chkBAcoes.enabled := false;
    chkBReits.enabled := false;
    chkBETFs.enabled := false;
    chkBStocks.enabled := false;
    chkBRF.enabled := false;
  end;
end;

procedure TfrmConsultaProventos.filtraChecks3();
begin
  // Filtro por TIPO DE INVESTIMENTO...
  if not chkBTodos.Checked then
  begin
    chkBFIIs.enabled := true;
    chkBAcoes.enabled := true;
    chkBReits.enabled := true;
    chkBETFs.enabled := true;
    chkBStocks.enabled := true;
    chkBRF.enabled := true;

    // todos...
    if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
    begin
      chkBTodos.Checked := true;
      DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,3,4,5,6,8,9,10,11,14,15,16,17,18,19,20,21,22,23,24,25,26)');
    end
    else
      // somente Ações...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,19)')
      else // somente FIIs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2)')
      else // somente Reits...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (4)')
      else // somente ETFs...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (5,6,8,9,10,11)')
      else // somente Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (3)')
      else // somente Renda Fixa...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (14,15,16,17,18,21,22,24,26)')

      else // Ações e FIIs...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,19)')
      else // Ações e Reits...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,4,19)')
      else // Ações e ETFs...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,19,5,6,8,9,10,11)')
      else // Ações e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,19,3)')
      else // Ações e Renda Fixa...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,19,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs e Reits...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,19,4)')
      else // Ações, FIIs e ETFs...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,4,19,5,6,8,9,10,11)')
      else // Ações, FIIs e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,3,19,5,6,8,9,10,11)')
      else // Ações, FIIs e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,19,3,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs, Reits e ETFs...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,19,4,5,6,8,9,10,11)')
      else // Ações, FIIs, Reits e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,19,4,3)')
      else // Ações, FIIs, Reits e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,19,4,14,15,16,17,18,21,22,24,26)')

      else // Ações, Reits e ETFs...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,4,19,5,6,8,9,10,11)')
      else // Ações, Reits e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,4,19,3)')
      else // Ações, Reits e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,4,19,14,15,16,17,18,21,22,24,26)')

      else // Ações, ETFs e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,19,5,6,8,9,10,11,3)')
      else // Ações, ETFs e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,19,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // Ações, Stocks e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,19,3,14,15,16,17,18,21,22,24,26)')

      else // FIIs e Reits...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2,4)')
      else // FIIs e ETFs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2,5,6,8,9,10,11)')
      else // FIIs e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2,3)')
      else // FIIs e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2,14,15,16,17,18,21,22,24,26)')

      else // FIIs, Reits e ETFs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2,4,5,6,8,9,10,11)')
      else // FIIs, Reits e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2,4,3)')
      else // FIIs, Reits e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2,4,14,15,16,17,18,21,22,24,26)')

      else // FIIs, Reits, ETFs e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2,4,5,6,8,9,10,11,3)')
      else // FIIs, Reits, ETFs e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (2,4,5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

      else // Reits e ETFs...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (4,5,6,8,9,10,11)')
      else // Reits e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (4,3)')
      else // Reits e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (4,14,15,16,17,18,21,22,24,26)')

      else // Reits, ETFs e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (4,5,6,8,9,10,11,3)')
      else // Reits, ETFs e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // ETFs e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (5,6,8,9,10,11,3)')
      else // ETFs e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // ETFs, Stocks e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs, Reits, ETFs e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,4,5,6,8,9,10,11,3)')
      else // Ações, FIIs, Reits, ETFs e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,2,4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')
      else // Ações, Reits, ETFs e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (1,4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // Reits, ETFs, Stocks e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te.cod_tipoinvestimento in (4,5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

  end
  else
  begin
    chkBFIIs.Checked := false;
    chkBAcoes.Checked := false;
    chkBReits.Checked := false;
    chkBETFs.Checked := false;
    chkBStocks.Checked := false;
    chkBRF.Checked := false;

    chkBFIIs.enabled := false;
    chkBAcoes.enabled := false;
    chkBReits.enabled := false;
    chkBETFs.enabled := false;
    chkBStocks.enabled := false;
    chkBRF.enabled := false;
  end;
end;

procedure TfrmConsultaProventos.filtraChecks4();
begin
  // Filtro por TIPO DE INVESTIMENTO...
  if not chkBTodos.Checked then
  begin
    chkBFIIs.enabled := true;
    chkBAcoes.enabled := true;
    chkBReits.enabled := true;
    chkBETFs.enabled := true;
    chkBStocks.enabled := true;
    chkBRF.enabled := true;

    // todos...
    if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
    begin
      chkBTodos.Checked := true;
      DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,3,4,5,6,8,9,10,11,14,15,16,17,18,19,20,21,22,23,24,25,26)');
    end
    else
      // somente Ações...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,19)')
      else // somente FIIs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2)')
      else // somente Reits...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (4)')
      else // somente ETFs...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (5,6,8,9,10,11)')
      else // somente Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (3)')
      else // somente Renda Fixa...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (14,15,16,17,18,21,22,24,26)')

      else // Ações e FIIs...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19)')
      else // Ações e Reits...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,4,19)')
      else // Ações e ETFs...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,19,5,6,8,9,10,11)')
      else // Ações e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,19,3)')
      else // Ações e Renda Fixa...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,19,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs e Reits...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19,4)')
      else // Ações, FIIs e ETFs...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,4,19,5,6,8,9,10,11)')
      else // Ações, FIIs e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,3,19,5,6,8,9,10,11)')
      else // Ações, FIIs e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,19,3,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs, Reits e ETFs...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19,4,5,6,8,9,10,11)')
      else // Ações, FIIs, Reits e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19,4,3)')
      else // Ações, FIIs, Reits e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,19,4,14,15,16,17,18,21,22,24,26)')

      else // Ações, Reits e ETFs...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,4,19,5,6,8,9,10,11)')
      else // Ações, Reits e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,4,19,3)')
      else // Ações, Reits e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,4,19,14,15,16,17,18,21,22,24,26)')

      else // Ações, ETFs e Stocks...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,19,5,6,8,9,10,11,3)')
      else // Ações, ETFs e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,19,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // Ações, Stocks e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,19,3,14,15,16,17,18,21,22,24,26)')

      else // FIIs e Reits...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2,4)')
      else // FIIs e ETFs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2,5,6,8,9,10,11)')
      else // FIIs e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2,3)')
      else // FIIs e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2,14,15,16,17,18,21,22,24,26)')

      else // FIIs, Reits e ETFs...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2,4,5,6,8,9,10,11)')
      else // FIIs, Reits e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2,4,3)')
      else // FIIs, Reits e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2,4,14,15,16,17,18,21,22,24,26)')

      else // FIIs, Reits, ETFs e Stocks...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2,4,5,6,8,9,10,11,3)')
      else // FIIs, Reits, ETFs e RF...
      if chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (2,4,5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

      else // Reits e ETFs...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (4,5,6,8,9,10,11)')
      else // Reits e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (4,3)')
      else // Reits e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and not chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (4,14,15,16,17,18,21,22,24,26)')

      else // Reits, ETFs e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (4,5,6,8,9,10,11,3)')
      else // Reits, ETFs e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // ETFs e Stocks...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (5,6,8,9,10,11,3)')
      else // ETFs e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // ETFs, Stocks e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and not chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')

      else // Ações, FIIs, Reits, ETFs e Stocks...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and not chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,4,5,6,8,9,10,11,3)')
      else // Ações, FIIs, Reits, ETFs e RF...
      if chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and not chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,2,4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')
      else // Ações, Reits, ETFs e RF...
      if not chkBFIIs.Checked and chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (1,4,5,6,8,9,10,11,14,15,16,17,18,21,22,24,26)')

      else // Reits, ETFs, Stocks e RF...
      if not chkBFIIs.Checked and not chkBAcoes.Checked and chkBReits.Checked and chkBETFs.Checked and chkBStocks.Checked and chkBRF.Checked then
        DMPrincipal.ADOQConAux1.SQL.Add('and te2.cod_tipoinvestimento in (4,5,6,8,9,10,11,3,14,15,16,17,18,21,22,24,26)')
  end
  else
  begin
    chkBFIIs.Checked := false;
    chkBAcoes.Checked := false;
    chkBReits.Checked := false;
    chkBETFs.Checked := false;
    chkBStocks.Checked := false;
    chkBRF.Checked := false;

    chkBFIIs.enabled := false;
    chkBAcoes.enabled := false;
    chkBReits.enabled := false;
    chkBETFs.enabled := false;
    chkBStocks.enabled := false;
    chkBRF.enabled := false;
  end;
end;

procedure TfrmConsultaProventos.chkBAcoesClick(Sender: TObject);
begin
  controlaChecks;
end;

procedure TfrmConsultaProventos.chkBReitsClick(Sender: TObject);
begin
  controlaChecks;
end;

procedure TfrmConsultaProventos.chkBETFsClick(Sender: TObject);
begin
  controlaChecks;
end;

procedure TfrmConsultaProventos.chkBStocksClick(Sender: TObject);
begin
  controlaChecks;
end;

procedure TfrmConsultaProventos.chkBRFClick(Sender: TObject);
begin
  controlaChecks;
end;

procedure TfrmConsultaProventos.chkBTodosClick(Sender: TObject);
begin
  if not chkBTodos.Checked then
  begin
    chkBFIIs.enabled := true;
    chkBAcoes.enabled := true;
    chkBReits.enabled := true;
    chkBETFs.enabled := true;
    chkBStocks.enabled := true;
    chkBRF.enabled := true;
  end
  else
  begin
    chkBFIIs.Checked := false;
    chkBAcoes.Checked := false;
    chkBReits.Checked := false;
    chkBETFs.Checked := false;
    chkBStocks.Checked := false;
    chkBRF.Checked := false;

    chkBFIIs.enabled := false;
    chkBAcoes.enabled := false;
    chkBReits.enabled := false;
    chkBETFs.enabled := false;
    chkBStocks.enabled := false;
    chkBRF.enabled := false;
  end;
end;

procedure TfrmConsultaProventos.limpaGrid();
begin
  // query principal...
  DMPrincipal.ADOQConProventosAno.Close;
  DMPrincipal.ADOQConProventosAno.SQL.Clear;
  DMPrincipal.ADOQConProventosAno.SQL.Add('/* Query estatística para listar os proventos dos ativos ao longo do ano - consulta em tela... */');
  DMPrincipal.ADOQConProventosAno.SQL.Add('select ta.nom_ativo,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(a.val_atualizado,''C'', ''pt-br'') as val_atualizado,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(a.nro_cotas, ''N'', ''pt-br'') as nro_cotas,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT((a.val_atualizado / a.nro_cotas), ''C'', ''pt-br'') as preco_medio,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 1) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as janeiro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 2) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as fevereiro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 3) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as marco,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 4) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as abril,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 5) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as maio,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 6) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as junho,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 7) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as julho,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 8) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as agosto,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 9) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as setembro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 10) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as outubro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 11) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as novembro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 12) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as dezembro,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT(sum(tr.vlr_total), ''C'', ''pt-br'') as total,');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FORMAT((sum(tr.vlr_total)/12), ''C'', ''pt-br'') as media');
  DMPrincipal.ADOQConProventosAno.SQL.Add('from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nro_cotas) as nro_cotas, ti.cod_ativo');
  DMPrincipal.ADOQConProventosAno.SQL.Add('FROM t_investimento ti, t_tipoinvestimento te');
  DMPrincipal.ADOQConProventosAno.SQL.Add('WHERE 1=1');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti.cod_status <> 4');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti.cod_tipoinvestimento = te.cod_tipoinvestimento');

  DMPrincipal.ADOQConProventosAno.SQL.Add('GROUP BY ti.cod_ativo) a');
  DMPrincipal.ADOQConProventosAno.SQL.Add(', t_provento tr, t_ativo ta, t_carteira tc, t_proprietario tp, t_investimento ti2, t_tipoinvestimento te2');
  DMPrincipal.ADOQConProventosAno.SQL.Add('where a.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ta.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and tr.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and tc.cod_proprietario = tp.cod_proprietario');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_proprietario = tc.cod_proprietario');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_ativo = ta.cod_ativo');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_status <> 4');
  DMPrincipal.ADOQConProventosAno.SQL.Add('and ti2.cod_tipoinvestimento = te2.cod_tipoinvestimento');

  DMPrincipal.ADOQConProventosAno.SQL.Add('group by ta.nom_ativo, a.val_atualizado, a.nro_cotas');
  DMPrincipal.ADOQConProventosAno.SQL.Add('order by ta.nom_ativo');

  // query auxiliar...
  DMPrincipal.ADOQConAux1.Close;
  DMPrincipal.ADOQConAux1.SQL.Clear;
  DMPrincipal.ADOQConAux1.SQL.Add('/* Query estatística para listar os proventos dos ativos ao longo do ano - Auxiliar... */');
  DMPrincipal.ADOQConAux1.SQL.Add('select');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(a.val_atualizado,''C'', ''pt-br'') as val_atualizado,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(a.nro_cotas, ''N'', ''pt-br'') as nro_cotas,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT((a.val_atualizado / a.nro_cotas), ''C'', ''pt-br'') as preco_medio,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 1) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as janeiro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 2) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as fevereiro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 3) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as marco,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 4) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as abril,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 5) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as maio,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 6) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as junho,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 7) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as julho,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 8) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as agosto,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 9) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as setembro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 10) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as outubro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 11) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as novembro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(case when (month(tr.competencia) = 12) then tr.vlr_total else 0 end), ''C'', ''pt-br'') as dezembro,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT(sum(tr.vlr_total), ''C'', ''pt-br'') as total,');
  DMPrincipal.ADOQConAux1.SQL.Add('FORMAT((sum(tr.vlr_total)/12), ''C'', ''pt-br'') as media');
  DMPrincipal.ADOQConAux1.SQL.Add('from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nro_cotas) as nro_cotas');
  DMPrincipal.ADOQConAux1.SQL.Add('FROM t_investimento ti, t_tipoinvestimento te');
  DMPrincipal.ADOQConAux1.SQL.Add('WHERE 1=1');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti.cod_tipoinvestimento = te.cod_tipoinvestimento');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti.cod_status <> 4');
  
  DMPrincipal.ADOQConAux1.SQL.Add(') a');

  DMPrincipal.ADOQConAux1.SQL.Add(', t_provento tr, t_ativo ta, t_carteira tc, t_proprietario tp, t_investimento ti2, t_tipoinvestimento te2');
  DMPrincipal.ADOQConAux1.SQL.Add('where');
  DMPrincipal.ADOQConAux1.SQL.Add('ta.cod_ativo = tr.cod_ativo');
  DMPrincipal.ADOQConAux1.SQL.Add('and tr.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQConAux1.SQL.Add('and tc.cod_proprietario = tp.cod_proprietario');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_proprietario = tc.cod_proprietario');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_carteira = tc.cod_carteira');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_ativo = ta.cod_ativo');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_status <> 4');
  DMPrincipal.ADOQConAux1.SQL.Add('and ti2.cod_tipoinvestimento = te2.cod_tipoinvestimento');

  DMPrincipal.ADOQConAux1.SQL.Add('group by a.val_atualizado, a.nro_cotas');
end;

end.
