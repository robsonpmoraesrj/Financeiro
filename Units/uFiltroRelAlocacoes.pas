unit uFiltroRelAlocacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, DBCtrls, ExtCtrls, uDm, uQRAlocacoes;

type
  TfrmFiltroRelAlocacoes = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dblkTipoInvest: TDBLookupComboBox;
    dblkInvestimento: TDBLookupComboBox;
    dblkCarteira: TDBLookupComboBox;
    btnGerar: TBitBtn;
    dbtLimpar: TBitBtn;
    btnSair: TBitBtn;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    mskeAberturaI: TMaskEdit;
    mskeAberturaF: TMaskEdit;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    mskeVenctoI: TMaskEdit;
    mskeVenctoF: TMaskEdit;
    dblkStatus: TDBLookupComboBox;
    Label8: TLabel;
    Label9: TLabel;
    dblkInvestidor: TDBLookupComboBox;
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
  frmFiltroRelAlocacoes: TfrmFiltroRelAlocacoes;
  dDataAberturaI, dDataAberturaF, dDataVenctoI, dDataVenctoF : string;
  
implementation

{$R *.dfm}

procedure TfrmFiltroRelAlocacoes.btnSairClick(Sender: TObject);
begin
  Close;
  frmFiltroRelAlocacoes := nil;
end;

procedure TfrmFiltroRelAlocacoes.dbtLimparClick(Sender: TObject);
begin
  dblkInvestimento.KeyValue := -1;
  dblkTipoInvest.KeyValue := -1;
  dblkCarteira.KeyValue := -1;
  dblkStatus.KeyValue := -1;
  dblkInvestidor.KeyValue := -1;
  mskeAberturaI.Text := '';
  mskeAberturaF.Text := '';
  mskeVenctoI.Text := '';
  mskeVenctoF.Text := '';
end;

procedure TfrmFiltroRelAlocacoes.btnGerarClick(Sender: TObject);
var relAlocacoes : TqrRelAlocacoes;
  rError : boolean;
begin
  rError := false;
  DMPrincipal.ADOQAlocacoes.Close;
  DMPrincipal.ADOQAlocacoes.SQL.Clear;
  DMPrincipal.ADOQAlocacoes.SQL.Add('select ti.dsc_investimento, tt.dsc_tipoinvestimento, ti.dsc_observacao, ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('tc.nom_carteira, tp.nom_proprietario, ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('FORMAT(ti.vlr_alocado,''C'', ''pt-br'') as vlr_alocado, ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('FORMAT(ti.vlr_atualizado,''C'', ''pt-br'') as vlr_atualizado, ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('ti.dat_abertura, ti.dat_vencimento, ti.dat_atualizacao, ti.nro_cotas, ts.dsc_status ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('from t_investimento ti, t_tipoinvestimento tt, t_ativo ta, t_carteira tc, t_proprietario tp, t_status ts ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('where ti.cod_ativo = ta.cod_ativo ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('and ta.cod_tipoinvestimento = tt.cod_tipoinvestimento ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.cod_carteira = tc.cod_carteira ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('and tc.cod_proprietario = tp.cod_proprietario ');
  DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.cod_status = ts.cod_status ');

  // Filtro por INVESTIMENTO...
  if dblkInvestimento.Text <> '' then
  begin
    DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.cod_investimento = ' + quotedstr(dblkInvestimento.KeyValue));
  end;

  // Filtro por TIPO DE INVESTIMENTO...
  if dblkTipoInvest.Text <> '' then
  begin
    DMPrincipal.ADOQAlocacoes.SQL.Add('and ta.cod_tipoinvestimento = ' + quotedstr(dblkTipoInvest.KeyValue));
  end;

  // Filtro por CARTEIRA...
  if dblkCarteira.Text <> '' then
  begin
    DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.cod_carteira = ' + quotedstr(dblkCarteira.KeyValue));
  end;

  // Filtro por STATUS...
  if dblkStatus.Text <> '' then
  begin
    DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.cod_status = ' + quotedstr(dblkStatus.KeyValue));
  end;

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
  end;

  // Per�odos de DATAS...
  if ((mskeAberturaI.Text <> '  /  /    ') and (mskeVenctoI.Text <> '  /  /    ')) then
  begin
    if (strtodate(mskeAberturaI.Text) > strtodate(mskeVenctoI.Text)) then
    begin
      messageDlg('Intervalo de datas Inv�lido!', mtError, [mbOk],0);
      rError := true;
      mskeAberturaI.SetFocus;
      //Abort;
    end;
  end
  else
  begin
    if ((mskeAberturaI.Text <> '  /  /    ') and (mskeVenctoF.Text <> '  /  /    ')) then
    begin
      if (strtodate(mskeAberturaI.Text) > strtodate(mskeVenctoF.Text)) then
      begin
        messageDlg('Intervalo de datas Inv�lido!', mtError, [mbOk],0);
        rError := true;
        mskeAberturaI.SetFocus;
      end;
    end
    else
    begin
      if ((mskeAberturaF.Text <> '  /  /    ') and (mskeVenctoI.Text <> '  /  /    ')) then
      begin
        if (strtodate(mskeAberturaF.Text) > strtodate(mskeVenctoI.Text)) then
        begin
          messageDlg('Intervalo de datas Inv�lido!', mtError, [mbOk],0);
          rError := true;
          mskeAberturaI.SetFocus;
        end;
      end
      else
      begin
        if ((mskeAberturaF.Text <> '  /  /    ') and (mskeVenctoF.Text <> '  /  /    ')) then
        begin
          if (strtodate(mskeAberturaF.Text) > strtodate(mskeVenctoF.Text)) then
          begin
            messageDlg('Intervalo de datas Inv�lido!', mtError, [mbOk],0);
            rError := true;
            mskeAberturaI.SetFocus;
          end;
        end;
      end;
    end;
  end;

  // Filtro por DATA DE ABERTURA...
  if mskeAberturaI.Text <> '  /  /    ' then
  begin
    if mskeAberturaF.Text <> '  /  /    ' then
    begin
      // Valida DATAS...
      if mskeAberturaI.Text > mskeAberturaF.Text then
      begin
        messageDlg('Data de Abertura Inv�lida!', mtError, [mbOk],0);
        rError := true;
        mskeAberturaI.SetFocus;
      end
      else
      begin
        dDataAberturaI := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaI.Text));
        dDataAberturaF := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaF.Text));
        DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.dat_abertura between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
      end;
    end
    else
    begin
      dDataAberturaI := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaI.Text));
      DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.dat_abertura >= ' + quotedstr(dDataAberturaI));
    end;
  end
  else
  begin
    if mskeAberturaF.Text <> '  /  /    ' then
    begin
      dDataAberturaF := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaF.Text));
      DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.dat_abertura <= ' + quotedstr(dDataAberturaF));
    end;
  end;

  // Filtro por DATA DE VENCIMENTO...
  if mskeVenctoI.Text <> '  /  /    ' then
  begin
    if mskeVenctoF.Text <> '  /  /    ' then
    begin
      if mskeVenctoI.Text > mskeVenctoF.Text then
      begin
        messageDlg('Data de Vencimento Inv�lida!', mtError, [mbOk],0);
        rError := true;
        mskeVenctoI.SetFocus;
      end
      else
      begin
        dDataVenctoI := formatdatetime('yyyy/mm/dd', strtodate(mskeVenctoI.Text));
        dDataVenctoF := formatdatetime('yyyy/mm/dd', strtodate(mskeVenctoF.Text));
        DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.dat_vencimento between ' + quotedstr(dDataVenctoI) +  ' and ' + quotedstr(dDataVenctoF));
      end;
    end
    else
    begin
      dDataVenctoI := formatdatetime('yyyy/mm/dd', strtodate(mskeVenctoI.Text));
      DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.dat_vencimento >= ' + quotedstr(dDataVenctoI));
    end;
  end
  else
  begin
    if mskeVenctoF.Text <> '  /  /    ' then
    begin
      dDataVenctoF := formatdatetime('yyyy/mm/dd', strtodate(mskeVenctoF.Text));
      DMPrincipal.ADOQAlocacoes.SQL.Add('and ti.dat_vencimento <= ' + quotedstr(dDataVenctoF));
    end;
  end;

  DMPrincipal.ADOQAlocacoes.SQL.Add('order by ti.dsc_investimento, tt.dsc_tipoinvestimento, ti.dsc_observacao, ti.dat_abertura, tc.nom_carteira ');

  if rError = false then
  begin
    DMPrincipal.ADOQAlocacoes.Open;

    relAlocacoes := TqrRelAlocacoes.Create(Self);
    relAlocacoes.Preview;
    relAlocacoes.Free;
  end;
end;

procedure TfrmFiltroRelAlocacoes.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Open;
  DMPrincipal.ADODSCarteira.Open;
  DMPrincipal.ADODSAlocacao.Open;
  DMPrincipal.ADODSStatus.Open;

  mskeAberturaI.Enabled := true;
  mskeAberturaF.Enabled := true;
  mskeVenctoI.Enabled := true;
  mskeVenctoF.Enabled := true;
end;

procedure TfrmFiltroRelAlocacoes.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  shortdateformat := 'dd/mm/yyyy';
end;

end.
