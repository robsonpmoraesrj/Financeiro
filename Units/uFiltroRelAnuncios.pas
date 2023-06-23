{------------------------------------------------------------------------------------------------------
 Objetivo    : Relatório Anúncios de Proventos
 Autor       : Robson Moraes
 Data        : 2023
------------------------------------------------------------------------------------------------------}

unit uFiltroRelAnuncios;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDM, ADODB, StdCtrls, Mask, Buttons, DBCtrls, ExtCtrls;

type
  TfrmFiltroRelAnuncios = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
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
    dblkAtivo: TDBLookupComboBox;
    gbStatus: TGroupBox;
    chkBPagos: TCheckBox;
    chkBProvisionados: TCheckBox;
    chkBPendentes: TCheckBox;
    chkBTodos: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbtLimparClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure chkBTodosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroRelAnuncios: TfrmFiltroRelAnuncios;
  dDataAberturaI, dDataAberturaF, dDataVenctoI, dDataVenctoF, filtro : string;

implementation

uses uQrAnuncios2;

{$R *.dfm}

procedure TfrmFiltroRelAnuncios.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Open;
  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSStatus.Open;

  mskeAberturaI.Enabled := true;
  mskeAberturaF.Enabled := true;
end;

procedure TfrmFiltroRelAnuncios.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  mskeAberturaI.Text := '01/2023';
  mskeAberturaF.Text := '12/2023';

  shortdateformat := 'dd/mm/yyyy';
  filtro := 'Filtro de Pesquisa: ';

  chkBTodos.Checked := true;

  if chkBTodos.Checked then
  begin
    chkBPagos.Checked := false;
    chkBProvisionados.Checked := false;
    chkBPendentes.Checked := false;
    chkBPagos.Enabled := false;
    chkBProvisionados.Enabled := false;
    chkBPendentes.Enabled := false;
  end
  else
  begin
    chkBPagos.Enabled := true;
    chkBProvisionados.Enabled := true;
    chkBPendentes.Enabled := true;
  end;

end;

procedure TfrmFiltroRelAnuncios.btnSairClick(Sender: TObject);
begin
  Close;
  frmFiltroRelAnuncios := nil;
end;

procedure TfrmFiltroRelAnuncios.dbtLimparClick(Sender: TObject);
begin
  dblkTipoInvest.KeyValue := -1;
  dblkInvestidor.KeyValue := -1;
  dblkAtivo.KeyValue := -1;
  chkBTodos.Checked := true;;
  mskeAberturaI.Text := '01/2023';
  mskeAberturaF.Text := '12/2023';
  filtro := 'Filtro de Pesquisa: ';
  chkBPagos.Checked := true;
end;

procedure TfrmFiltroRelAnuncios.btnGerarClick(Sender: TObject);
  var
  relAnuncios2 : TqrRelAnuncios2;
  rError : boolean;
begin
  rError := false;

  // query principal...
  DMPrincipal.ADOQAnunciosProventos.Close;
  DMPrincipal.ADOQAnunciosProventos.SQL.Clear;
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('/* Listagem dos anúncios e pagamento de proventos a receber ou já recebidos - 10/03/2023 */');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('select CONVERT(varchar(10),tp.dat_pagamento,103) dt_pagamento, CONVERT(varchar(10),tp.dat_com,103) dt_com, tp.cod_ativo, ta.nom_ativo');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add(', tp.cod_tipprovento, tv.dsc_tipprovento, tp.vlr_bruto, tp.pct_ir, tp.vlr_ir, tp.vlr_liquido, tp.cod_status');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add(', tu.dsc_status, tr.nom_proprietario, ti.nro_cotas, (ti.nro_cotas * tp.vlr_liquido) valor_a_receber');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('from t_prev_proventos tp, t_ativo ta, t_tipprovento tv, t_investimento ti, t_proprietario tr, t_status tu');

  DMPrincipal.ADOQAnunciosProventos.SQL.Add('where 1=1');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_ativo = ta.cod_ativo');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status = tu.cod_status');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_tipprovento = tv.cod_tipprovento');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('and ti.cod_status = 1');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_ativo = ti.cod_ativo');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('and ti.cod_proprietario = tr.cod_proprietario');

  // Filtro por ATIVO...
  if dblkAtivo.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkAtivo.Text;
    DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_ativo = ' + quotedstr(dblkAtivo.KeyValue));
  end;

  // Filtro por TIPO DE INVESTIMENTO...
  if dblkTipoInvest.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkTipoInvest.Text;
    DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_tipprovento = ' + quotedstr(dblkTipoInvest.KeyValue));
  end;

  // Filtro por STATUS...
  if chkBTodos.Checked then
  begin
    filtro := filtro + ' - Todos';
    DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status in (1,5,3)');
  end
  else
  begin
    //chkBPagos.Enabled := true;
    //chkBProvisionados.Enabled := true;
    //chkBPendentes.Enabled := true;

    if (chkBPagos.Checked and chkBProvisionados.Checked and chkBPendentes.Checked) then
    begin
      filtro := filtro + ' - Todos';
      DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status in (1,5,3)');
    end
    else
      if (chkBPagos.Checked and chkBProvisionados.Checked and not chkBPendentes.Checked) then
      begin
        filtro := filtro + ' - Pagos e Provisionados';
        DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status in (1,5)');
      end
      else
        if (chkBPagos.Checked and not chkBProvisionados.Checked and chkBPendentes.Checked) then
        begin
          filtro := filtro + ' - Pagos e Pendentes';
          DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status in (3,5)');
        end
        else
          if (not chkBPagos.Checked and chkBProvisionados.Checked and chkBPendentes.Checked) then
          begin
            filtro := filtro + ' - Provisionados e Pendentes';
            DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status in (1,3)');
          end
          else
            if (chkBPagos.Checked and not chkBProvisionados.Checked and not chkBPendentes.Checked) then
            begin
              filtro := filtro + ' - Pagos';
              DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status = 5');
            end
            else
              if (not chkBPagos.Checked and chkBProvisionados.Checked and not chkBPendentes.Checked) then
              begin
                filtro := filtro + ' - Provisionados';
                DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status = 1');
              end
              else
                if (not chkBPagos.Checked and not chkBProvisionados.Checked and chkBPendentes.Checked) then
                begin
                  filtro := filtro + ' - Pendentes';
                  DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status = 3');
                end
                else
                  if (not chkBPagos.Checked and not chkBProvisionados.Checked and not chkBPendentes.Checked and not chkBtodos.Checked) then
                  begin
                    filtro := filtro + ' - Todos';
                    chkBtodos.Checked := true;
                    DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.cod_status in (1,3,5)');
                  end;

  end;

  // Filtro por INVESTIDOR...
  if dblkInvestidor.Text <> '' then
  begin
    filtro := filtro + ' - ' + dblkInvestidor.Text;
    DMPrincipal.ADOQAnunciosProventos.SQL.Add('and ti.cod_proprietario = ' + quotedstr(dblkInvestidor.KeyValue));
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

        DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.dat_pagamento between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
      end;
    end
    else
    begin
      filtro := filtro + ' - ' + mskeAberturaI.Text;
      //dDataAberturaI := copy(mskeAberturaI.Text,4,7) + '-' + copy(mskeAberturaI.Text,1,2) + '-01';
      dDataAberturaI := '01-' + copy(mskeAberturaI.Text,1,2) + '-' + copy(mskeAberturaI.Text,4,7);

      DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.dat_pagamento >= ' + quotedstr(dDataAberturaI));
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

      DMPrincipal.ADOQAnunciosProventos.SQL.Add('and tp.dat_pagamento <= ' + quotedstr(dDataAberturaF));
    end;
  end;

  // Agrupamentos...
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('group by tp.dat_pagamento, tp.dat_com, tp.cod_ativo, ta.nom_ativo');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add(', tp.cod_tipprovento, tv.dsc_tipprovento, tp.vlr_bruto, tp.pct_ir, tp.vlr_ir, tp.vlr_liquido, tp.cod_status');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add(', tu.dsc_status, tr.nom_proprietario, ti.nro_cotas');
  DMPrincipal.ADOQAnunciosProventos.SQL.Add('order by tp.dat_pagamento, tp.cod_ativo');

  if rError = false then
  begin
    DMPrincipal.ADOQAnunciosProventos.Open;

    relAnuncios2 := TqrRelAnuncios2.Create(Self);
    relAnuncios2.lblFiltro.Caption := filtro;
    relAnuncios2.qrRelAnuncios2.Preview;
    relAnuncios2.Free;
    filtro := 'Filtro de Pesquisa: ';
  end;
end;

procedure TfrmFiltroRelAnuncios.chkBTodosClick(Sender: TObject);
begin
  if chkBTodos.Checked then
  begin
    chkBPagos.Checked := false;
    chkBProvisionados.Checked := false;
    chkBPendentes.Checked := false;
    chkBPagos.Enabled := false;
    chkBProvisionados.Enabled := false;
    chkBPendentes.Enabled := false;
  end
  else
  begin
    chkBPagos.Enabled := true;
    chkBProvisionados.Enabled := true;
    chkBPendentes.Enabled := true;
  end;
end;

end.
 