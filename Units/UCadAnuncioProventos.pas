unit UCadAnuncioProventos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, uDM;

type
  TfrmCadAnuncioProventos = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btnSair: TBitBtn;
    dbnProvento: TDBNavigator;
    mskeCompetenciaP: TMaskEdit;
    dbPesqStatus: TDBLookupComboBox;
    btnLimpar: TBitBtn;
    dbPesqAtivo: TDBLookupComboBox;
    dbgTipos: TDBGrid;
    Label2: TLabel;
    mskeCompetencia: TMaskEdit;
    edtTipoInvest: TLabel;
    dblcbAtivo: TDBLookupComboBox;
    Label4: TLabel;
    dblcbTipoProvento: TDBLookupComboBox;
    Label5: TLabel;
    dbeValorUnitario: TDBEdit;
    Label6: TLabel;
    dbeCotas: TDBEdit;
    Label7: TLabel;
    edtTotProv: TEdit;
    Label8: TLabel;
    mskePagto: TMaskEdit;
    Label11: TLabel;
    dblcbSituacao: TDBLookupComboBox;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    edtTotProvLiq: TEdit;
    Label3: TLabel;
    mskeCOM: TMaskEdit;
    Label12: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbnProventoClick(Sender: TObject; Button: TNavigateBtn);
    procedure dbgTiposCellClick(Column: TColumn);
    procedure btnLimparClick(Sender: TObject);
    procedure dbPesqStatusClick(Sender: TObject);
    procedure mskeCompetenciaPExit(Sender: TObject);
    procedure dbeCotasExit(Sender: TObject);
    procedure dbeValorUnitarioExit(Sender: TObject);
    procedure dbPesqAtivoClick(Sender: TObject);
    procedure dblcbTipoProventoClick(Sender: TObject);
  private
    { Private declarations }
    function DataOk(Dt:String):Boolean;
    procedure CalculaProvento;
    procedure PesquisaRegistro;
  public
    { Public declarations }
  end;

var
  frmCadAnuncioProventos: TfrmCadAnuncioProventos;
  Result : boolean;
  situacao, ativo : integer;
  calcTotProv, calcTotProvLiq : Double;

implementation

uses uCadProventos;

{$R *.dfm}

procedure TfrmCadAnuncioProventos.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSAnuncioProvento.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADOQPesqStatus.Open;
  DMPrincipal.ADODSTpProvento.Open;

  mskeCompetencia.Enabled := false;
  dblcbAtivo.Enabled := false;
  dblcbTipoProvento.Enabled := false;
  dblcbSituacao.Enabled := false;
  dbeValorUnitario.Enabled := false;
  dbeCotas.Enabled := false;

  //edtTotProv.Enabled := false;
  edtTotProvliq.Enabled := false;

  mskePagto.Enabled := false;

  mskeCompetencia.Text := DMPrincipal.ADODSAnuncioProventoDAT_ANUNCIO.AsString;
  mskePagto.Text := DMPrincipal.ADODSAnuncioProventoDAT_PAGAMENTO.AsString;
  edtTotProv.Text := DMPrincipal.ADODSAnuncioProventoVLR_IR.AsString;
  edtTotProvLiq.Text := DMPrincipal.ADODSAnuncioProventoVLR_LIQUIDO.AsString;
end;

procedure TfrmCadAnuncioProventos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSAnuncioProvento.Close;
  DMPrincipal.ADODSAtivo.Close;
  DMPrincipal.ADOQPesqStatus.Close;
  DMPrincipal.ADODSTpProvento.Close;

  DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos';
  Action := caFree;

  frmCadProventos := nil;
end;

procedure TfrmCadAnuncioProventos.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  dbPesqAtivo.Enabled := true;
  mskeCompetenciaP.Enabled := true;
  dbPesqStatus.Enabled := true;
end;

procedure TfrmCadAnuncioProventos.btnSairClick(Sender: TObject);
begin
Close;
  frmCadAnuncioProventos := nil;
end;

procedure TfrmCadAnuncioProventos.PesquisaRegistro;
begin
  DMPrincipal.ADODSAnuncioProvento.Close;

  mskeCompetencia.Clear;
  mskePagto.Clear;

  // mudados os formatos das datas para formato brasileiro - após a troca do note - RMoraes - 02/03/2023...
  if (dbPesqStatus.KeyValue <> null) and (mskeCompetenciaP.Text <> '  /  /    ') and (dbPesqAtivo.KeyValue <> null) then
  begin
    situacao := dbPesqStatus.KeyValue;
    ativo := dbPesqAtivo.KeyValue;

    DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_status = ' + #39 + IntToStr(situacao) + #39 + ' and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + 'and p.dat_anuncio = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39;
  end
  else
    if (dbPesqStatus.KeyValue <> null) and (dbPesqAtivo.KeyValue <> null) and (mskeCompetenciaP.Text = '  /  /    ') then
    begin
      situacao := dbPesqStatus.KeyValue;
      ativo := dbPesqAtivo.KeyValue;
      DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_status = ' + #39 + IntToStr(situacao) + #39 + ' and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39;
    end
    else
      if (dbPesqStatus.KeyValue <> null) and (dbPesqAtivo.KeyValue = null) and (mskeCompetenciaP.Text = '  /  /    ') then
      begin
        situacao := dbPesqStatus.KeyValue;
        DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_status = ' + #39 + IntToStr(situacao) + #39;
      end
      else
        if (dbPesqStatus.KeyValue = null) and (dbPesqAtivo.KeyValue <> null) and (mskeCompetenciaP.Text <> '  /  /    ') then
        begin
          ativo := dbPesqAtivo.KeyValue;
          DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + ' and p.dat_anuncio = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39;
        end
        else
          if (dbPesqStatus.KeyValue <> null) and (dbPesqAtivo.KeyValue = null) and (mskeCompetenciaP.Text <> '  /  /    ') then
          begin
            situacao := dbPesqStatus.KeyValue;
            DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_status = ' + #39 + IntToStr(situacao) + #39 + 'and p.dat_anuncio = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39;
          end
          else
            if (dbPesqStatus.KeyValue = null) and (dbPesqAtivo.KeyValue = null) and (mskeCompetenciaP.Text <> '  /  /    ') then
            begin
              DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos p, t_ativo a where p.cod_ativo = a.cod_ativo and p.dat_anuncio = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39;
            end
            else
              if (dbPesqStatus.KeyValue = null) and (dbPesqAtivo.KeyValue <> null) and (mskeCompetenciaP.Text = '  /  /    ') then
              begin
                ativo := dbPesqAtivo.KeyValue;
                DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39;
              end
              else
                if (dbPesqStatus.KeyValue = null) and (dbPesqAtivo.KeyValue = null) and (mskeCompetenciaP.Text = '  /  /    ') then
                begin
                  DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos p, t_ativo a where p.cod_ativo = a.cod_ativo and 1=1';
                end;

  DMPrincipal.ADODSAnuncioProvento.CommandText := DMPrincipal.ADODSAnuncioProvento.CommandText + ' order by  p.dat_anuncio, p.dat_pagamento, p.cod_ativo';
  DMPrincipal.ADODSAnuncioProvento.Open;

  //edtValorTotal.Text := DMPrincipal.ADOQProventosVALOR_TOTAL.AsString;
  mskeCompetencia.Text := DMPrincipal.ADODSAnuncioProventoDAT_ANUNCIO.AsString;
  mskePagto.Text := DMPrincipal.ADODSAnuncioProventoDAT_PAGAMENTO.AsString;
  edtTotProv.Text := DMPrincipal.ADODSAnuncioProventoVLR_IR.AsString;
  edtTotProvLiq.Text := DMPrincipal.ADODSAnuncioProventoVLR_LIQUIDO.AsString;
end;

function TfrmCadAnuncioProventos.DataOk(Dt:String):Boolean;
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

procedure TfrmCadAnuncioProventos.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSAnuncioProvento.Append;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  dbPesqStatus.Enabled := false;
  mskeCompetenciaP.Enabled := false;

  mskeCompetencia.Enabled := true;
  dblcbAtivo.Enabled := true;
  dblcbTipoProvento.Enabled := true;
  dblcbSituacao.Enabled := true;
  dbeValorUnitario.Enabled := true;
  dbeCotas.Enabled := true;
  //edtTotProv.Enabled := true;
  edtTotProvLiq.Enabled := true;
  mskeCOM.Enabled := true;
  mskePagto.Enabled := true;

  mskeCompetencia.Clear;
  mskeCOM.Clear;
  mskePagto.Clear;

  mskeCompetencia.SetFocus;
end;

procedure TfrmCadAnuncioProventos.btnSalvarClick(Sender: TObject);
begin
  if DataOk(mskeCompetencia.Text) then
    result := true
  else
    result := false;

  if not Result then
  begin
    ShowMessage('Não é uma data válida!');
    exit;
    mskeCompetencia.SetFocus;
  end;

  if DataOk(mskePagto.Text) then
    result := true
  else
    result := false;

  if not Result then
  begin
    ShowMessage('Não é uma data válida!');
    exit;
    mskePagto.SetFocus;
  end;

  DMPrincipal.ADODSAnuncioProvento.FieldByName('dat_anuncio').Value := FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetencia.Text));
  DMPrincipal.ADODSAnuncioProvento.FieldByName('dat_com').Value := FormatDateTime('dd-MM-yyyy',StrToDate(mskeCOM.Text));
  DMPrincipal.ADODSAnuncioProvento.FieldByName('dat_pagamento').Value := FormatDateTime('dd-MM-yyyy',StrToDate(mskePagto.Text));

  DMPrincipal.ADODSAnuncioProvento.FieldByName('vlr_ir').Value := edtTotProv.Text;
  DMPrincipal.ADODSAnuncioProvento.FieldByName('vlr_liquido').Value := edtTotProvLiq.Text;

  // Salva...
  try
    DMPrincipal.ADODSAnuncioProvento.Post;
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

  dbPesqStatus.Enabled := true;
  mskeCompetenciaP.Enabled := true;

  mskeCompetencia.Enabled := false;
  dblcbAtivo.Enabled := false;
  dblcbTipoProvento.Enabled := false;
  dblcbSituacao.Enabled := false;
  dbeValorUnitario.Enabled := false;
  dbeCotas.Enabled := false;
  //edtTotProv.Enabled := false;
  edtTotProvLiq.Enabled := false;
  mskeCOM.Enabled := false;
  mskePagto.Enabled := false;

  PesquisaRegistro;

  mskeCompetencia.Text := DMPrincipal.ADODSAnuncioProventoDAT_ANUNCIO.AsString;
  mskeCOM.Text := DMPrincipal.ADODSAnuncioProventoDAT_COM.AsString;
  mskePagto.Text := DMPrincipal.ADODSAnuncioProventoDAT_PAGAMENTO.AsString;

  DMPrincipal.ADODSAnuncioProvento.Close;
  DMPrincipal.ADODSAnuncioProvento.Open;
end;

procedure TfrmCadAnuncioProventos.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSAnuncioProvento.Open;
  DMPrincipal.ADODSAnuncioProvento.Edit;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  dbPesqStatus.Enabled := false;
  mskeCompetenciaP.Enabled := false;

  mskeCompetencia.Enabled := true;
  dblcbAtivo.Enabled := true;
  dblcbTipoProvento.Enabled := true;
  dblcbSituacao.Enabled := true;
  dbeValorUnitario.Enabled := true;
  dbeCotas.Enabled := true;

  //edtTotProv.Enabled := true;
  edtTotProvLiq.Enabled := true;
  mskeCOM.Enabled := true;
  mskePagto.Enabled := true;

  mskeCompetencia.SetFocus;
end;

procedure TfrmCadAnuncioProventos.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSAnuncioProvento.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  dbPesqStatus.Enabled := true;
  mskeCompetenciaP.Enabled := true;

  mskeCompetencia.Enabled := false;
  dblcbAtivo.Enabled := false;
  dblcbTipoProvento.Enabled := false;
  dblcbSituacao.Enabled := false;
  dbeValorUnitario.Enabled := false;
  dbeCotas.Enabled := false;

  //edtTotProv.Enabled := false;
  edtTotProvLiq.Enabled := false;
  mskeCOM.Enabled := false;
  mskePagto.Enabled := false;

  PesquisaRegistro;

  mskeCompetencia.Text := DMPrincipal.ADODSAnuncioProventoDAT_ANUNCIO.AsString;
  mskeCOM.Text := DMPrincipal.ADODSAnuncioProventoDAT_COM.AsString;
  mskePagto.Text := DMPrincipal.ADODSAnuncioProventoDAT_PAGAMENTO.AsString;

  DMPrincipal.ADODSAnuncioProvento.Close;
  DMPrincipal.ADODSAnuncioProvento.Open;
  edtTotProv.Text := DMPrincipal.ADODSAnuncioProventoVLR_IR.AsString;
  edtTotProvLiq.Text := DMPrincipal.ADODSAnuncioProventoVLR_LIQUIDO.AsString;
end;

procedure TfrmCadAnuncioProventos.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSAnuncioProvento.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSAnuncioProvento.Delete;
  end;
end;

procedure TfrmCadAnuncioProventos.dbnProventoClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  mskeCompetencia.Text := DMPrincipal.ADODSAnuncioProventoDAT_ANUNCIO.AsString;
  mskePagto.Text := DMPrincipal.ADODSAnuncioProventoDAT_COM.AsString;
  mskePagto.Text := DMPrincipal.ADODSAnuncioProventoDAT_PAGAMENTO.AsString;
  edtTotProv.Text := DMPrincipal.ADODSAnuncioProventoVLR_IR.AsString;
  edtTotProvLiq.Text := DMPrincipal.ADODSAnuncioProventoVLR_LIQUIDO.AsString;
end;

procedure TfrmCadAnuncioProventos.dbgTiposCellClick(Column: TColumn);
begin
  mskeCompetencia.Text := DMPrincipal.ADODSAnuncioProventoDAT_ANUNCIO.AsString;
  mskeCOM.Text := DMPrincipal.ADODSAnuncioProventoDAT_COM.AsString;
  mskePagto.Text := DMPrincipal.ADODSAnuncioProventoDAT_PAGAMENTO.AsString;
  edtTotProv.Text := DMPrincipal.ADODSAnuncioProventoVLR_IR.AsString;
  edtTotProvLiq.Text := DMPrincipal.ADODSAnuncioProventoVLR_LIQUIDO.AsString;
end;

procedure TfrmCadAnuncioProventos.btnLimparClick(Sender: TObject);
begin
  DMPrincipal.ADODSAnuncioProvento.Close;
  DMPrincipal.ADODSAnuncioProvento.CommandText := 'select * from t_prev_proventos';
  mskeCompetenciaP.Clear;
  mskeCompetencia.Clear;
  mskeCOM.Clear;
  mskePagto.Clear;

  dbPesqAtivo.KeyValue := null;
  dbPesqStatus.KeyValue := null;

  PesquisaRegistro;

  mskeCompetencia.Text := DMPrincipal.ADODSAnuncioProventoDAT_ANUNCIO.AsString;
  mskeCOM.Text := DMPrincipal.ADODSAnuncioProventoDAT_COM.AsString;
  mskePagto.Text := DMPrincipal.ADODSAnuncioProventoDAT_PAGAMENTO.AsString;

  DMPrincipal.ADODSAnuncioProvento.Close;
  DMPrincipal.ADODSAnuncioProvento.Open;

  edtTotProv.Text := DMPrincipal.ADODSAnuncioProventoVLR_IR.AsString;
  edtTotProvLiq.Text := DMPrincipal.ADODSAnuncioProventoVLR_LIQUIDO.AsString;
end;

procedure TfrmCadAnuncioProventos.dbPesqStatusClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TfrmCadAnuncioProventos.mskeCompetenciaPExit(Sender: TObject);
begin
  try
    if DataOk(mskeCompetenciaP.Text) then
    begin
      result := true;
      PesquisaRegistro;
    end
    else
      result := false;
  except
      on E:exception do
        begin
          ShowMessage('Não é uma data válida!');
          exit;
          mskeCompetenciaP.SetFocus;
        end;
  end;
end;

procedure TfrmCadAnuncioProventos.dbeCotasExit(Sender: TObject);
begin
  CalculaProvento;
  edtTotProv.Text := formatfloat('###,##0.0000',calcTotProv);
  edtTotProvLiq.Text := formatfloat('###,##0.0000',calcTotProvLiq);
end;

procedure TfrmCadAnuncioProventos.CalculaProvento;
begin
  if (trim(dbeValorUnitario.Text) <> '') and (trim(dbeCotas.Text) <> '') then
  begin
    calcTotProv := (strToFloat(dbeValorUnitario.Text) * strToFloat(dbeCotas.Text)) / 100;
    calcTotProvLiq := strToFloat(dbeValorUnitario.Text) - calcTotProv;
  end
  else
    begin
      calcTotProv := 0;
      calcTotProvLiq := strToFloat(dbeValorUnitario.Text);
    end;
end;

procedure TfrmCadAnuncioProventos.dbeValorUnitarioExit(Sender: TObject);
begin
  CalculaProvento;
  edtTotProv.Text := formatfloat('###,##0.0000',calcTotProv);
  edtTotProvLiq.Text := formatfloat('###,##0.0000',calcTotProvLiq);
end;

procedure TfrmCadAnuncioProventos.dbPesqAtivoClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TfrmCadAnuncioProventos.dblcbTipoProventoClick(Sender: TObject);
begin
  if dblcbTipoProvento.Text = 'JUROS SOBRE CAPITAL PRÓPRIO' then
  begin
    //dbeCotas.Enabled := true;
    dbeCotas.Text := '15,00';
  end
  else
  begin
    dbeCotas.Enabled := false;
    dbeCotas.Text := '0';
  end;
end;

end.
