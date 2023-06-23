unit uCadProventos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, uDM;

type
  TfrmCadProventos = class(TForm)
    GroupBox1: TGroupBox;
    btnSair: TBitBtn;
    dbnProvento: TDBNavigator;
    dbgTipos: TDBGrid;
    Label3: TLabel;
    dbeDescricao: TDBEdit;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    edtTipoInvest: TLabel;
    dblcbAtivo: TDBLookupComboBox;
    Label2: TLabel;
    mskeCompetencia: TMaskEdit;
    dblcbTipoProvento: TDBLookupComboBox;
    Label4: TLabel;
    dbeValorUnitario: TDBEdit;
    Label5: TLabel;
    dbeCotas: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    mskePagto: TMaskEdit;
    Label8: TLabel;
    Label1: TLabel;
    mskeCompetenciaP: TMaskEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    dblcbCarteira: TDBLookupComboBox;
    dbPesqCarteira: TDBLookupComboBox;
    btnLimpar: TBitBtn;
    edtValorTotal: TEdit;
    Label12: TLabel;
    edtTotProv: TEdit;
    dbPesqAtivo: TDBLookupComboBox;
    procedure btnSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtProcurarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbnProventoClick(Sender: TObject; Button: TNavigateBtn);
    procedure dbgTiposCellClick(Column: TColumn);
    procedure btnLimparClick(Sender: TObject);
    procedure dbPesqCarteiraClick(Sender: TObject);
    procedure mskeCompetenciaPExit(Sender: TObject);
    procedure dbeCotasExit(Sender: TObject);
    procedure dbeValorUnitarioExit(Sender: TObject);
    procedure dbPesqAtivoClick(Sender: TObject);
  private
    { Private declarations }
    function DataOk(Dt:String):Boolean;
    procedure CalculaProvento;
    procedure PesquisaRegistro;
    //procedure PosicionaTela;
  public
    { Public declarations }
  end;

var
  frmCadProventos: TfrmCadProventos;
  Result : boolean;
  carteira, ativo : integer;
  calcTotProv : Double;

implementation

{$R *.dfm}

procedure TfrmCadProventos.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadProventos := nil;
end;

procedure TfrmCadProventos.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSProvento.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSCarteira.Open;
  DMPrincipal.ADOQPesqCarteira.Open;
  DMPrincipal.ADODSTpProvento.Open;
  DMPrincipal.ADOQProventos.Open;

  mskeCompetencia.Enabled := false;
  dblcbAtivo.Enabled := false;
  dblcbCarteira.Enabled := false;
  dblcbTipoProvento.Enabled := false;
  dbeValorUnitario.Enabled := false;
  dbeCotas.Enabled := false;
  //dbeValorTotal.Enabled := false;
  edtTotProv.Enabled := false;
  mskePagto.Enabled := false;
  dbeDescricao.Enabled := false;

  mskeCompetencia.Text := DMPrincipal.ADODSProventoCOMPETENCIA.AsString;
  mskePagto.Text := DMPrincipal.ADODSProventoDAT_PAGAMENTO.AsString;
  edtValorTotal.Text := DMPrincipal.ADOQProventosVALOR_TOTAL.AsString;
  edtTotProv.Text := DMPrincipal.ADODSProventoVLR_TOTAL.AsString;
end;

procedure TfrmCadProventos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSProvento.Close;
  DMPrincipal.ADODSAtivo.Close;
  DMPrincipal.ADODSCarteira.Close;
  DMPrincipal.ADOQPesqCarteira.Close;
  DMPrincipal.ADODSTpProvento.Close;

  DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento';
  Action := caFree;

  frmCadProventos := nil;
end;

procedure TfrmCadProventos.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  //edtProcurar.Enabled := true;
  dbPesqCarteira.Enabled := true;
  mskeCompetenciaP.Enabled := true;
  dbPesqAtivo.Enabled := true;
end;

procedure TfrmCadProventos.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  PesquisaRegistro;
end;

procedure TfrmCadProventos.PesquisaRegistro;
begin
  DMPrincipal.ADODSProvento.Close;
  DMPrincipal.ADOQProventos.Close;
  DMPrincipal.ADOQProventos.SQL.Clear;

  mskeCompetencia.Clear;
  mskePagto.Clear;

  // mudados os formatos das datas para formato brasileiro - após a troca do note - RMoraes - 02/03/2023...
  if (dbPesqCarteira.KeyValue <> null) and (mskeCompetenciaP.Text <> '  /  /    ') and (dbPesqAtivo.KeyValue <> null) then
  begin
    carteira := dbPesqCarteira.KeyValue;
    ativo := dbPesqAtivo.KeyValue;
    //DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + 'and p.competencia = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCompetenciaP.Text)) + #39;
    //DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + 'and p.competencia = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCompetenciaP.Text)) + #39 + ' and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39);

    DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + 'and p.competencia = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39;
    DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + 'and p.competencia = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39 + ' and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39);
  end
  else
    if (dbPesqCarteira.KeyValue <> null) and (dbPesqAtivo.KeyValue <> null) and (mskeCompetenciaP.Text = '  /  /    ') then
    begin
      carteira := dbPesqCarteira.KeyValue;
      ativo := dbPesqAtivo.KeyValue;
      DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39;
      DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + ' and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39);
    end
    else
      if (dbPesqCarteira.KeyValue <> null) and (dbPesqAtivo.KeyValue = null) and (mskeCompetenciaP.Text = '  /  /    ') then
      begin
        carteira := dbPesqCarteira.KeyValue;
        DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39;
        DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39);
      end
      else
        if (dbPesqCarteira.KeyValue = null) and (dbPesqAtivo.KeyValue <> null) and (mskeCompetenciaP.Text <> '  /  /    ') then
        begin
          ativo := dbPesqAtivo.KeyValue;
          //DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + ' and p.competencia = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCompetenciaP.Text)) + #39;
          //DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + ' and p.competencia = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCompetenciaP.Text)) + #39);

          DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + ' and p.competencia = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39;
          DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39 + ' and p.competencia = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39);
        end
        else
          if (dbPesqCarteira.KeyValue <> null) and (dbPesqAtivo.KeyValue = null) and (mskeCompetenciaP.Text <> '  /  /    ') then
          begin
            carteira := dbPesqCarteira.KeyValue;
            //DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + 'and p.competencia = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCompetenciaP.Text)) + #39;
            //DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + 'and p.competencia = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCompetenciaP.Text)) + #39);

            DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + 'and p.competencia = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39;
            DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_carteira = ' + #39 + IntToStr(carteira) + #39 + 'and p.competencia = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39);
          end
          else
            if (dbPesqCarteira.KeyValue = null) and (dbPesqAtivo.KeyValue = null) and (mskeCompetenciaP.Text <> '  /  /    ') then
            begin
              //DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.competencia = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCompetenciaP.Text)) + #39;
              //DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.competencia = ' + #39 + FormatDateTime('yyyy-MM-dd',StrToDate(mskeCompetenciaP.Text)) + #39);

              DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.competencia = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39;
              DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.competencia = ' + #39 + FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetenciaP.Text)) + #39);
            end
            else
              if (dbPesqCarteira.KeyValue = null) and (dbPesqAtivo.KeyValue <> null) and (mskeCompetenciaP.Text = '  /  /    ') then
              begin
                ativo := dbPesqAtivo.KeyValue;
                DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39;
                DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and p.cod_ativo = ' + #39 + IntToStr(ativo) + #39);
              end
              else
                if (dbPesqCarteira.KeyValue = null) and (dbPesqAtivo.KeyValue = null) and (mskeCompetenciaP.Text = '  /  /    ') then
                begin
                  DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and 1=1';
                  DMPrincipal.ADOQProventos.SQL.Add('select sum(vlr_total) as valor_total from t_provento p, t_ativo a where p.cod_ativo = a.cod_ativo and 1=1');
                end;

  DMPrincipal.ADODSProvento.CommandText := DMPrincipal.ADODSProvento.CommandText + ' order by  p.competencia desc, p.dat_pagamento desc, p.cod_carteira';
  DMPrincipal.ADODSProvento.Open;
  DMPrincipal.ADOQProventos.Open;

  edtValorTotal.Text := DMPrincipal.ADOQProventosVALOR_TOTAL.AsString;
  mskeCompetencia.Text := DMPrincipal.ADODSProventoCOMPETENCIA.AsString;
  mskePagto.Text := DMPrincipal.ADODSProventoDAT_PAGAMENTO.AsString;
  edtTotProv.Text := DMPrincipal.ADODSProventoVLR_TOTAL.AsString;
end;

procedure TfrmCadProventos.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSProvento.Append;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  //edtProcurar.Enabled := false;
  dbPesqCarteira.Enabled := false;
  mskeCompetenciaP.Enabled := false;

  mskeCompetencia.Enabled := true;
  dblcbAtivo.Enabled := true;
  dblcbCarteira.Enabled := true;
  dblcbTipoProvento.Enabled := true;
  dbeValorUnitario.Enabled := true;
  dbeCotas.Enabled := true;
  //dbeValorTotal.Enabled := true;
  edtTotProv.Enabled := true;
  mskePagto.Enabled := true;
  dbeDescricao.Enabled := true;

  mskeCompetencia.Clear;
  mskePagto.Clear;

  mskeCompetencia.SetFocus;
end;

procedure TfrmCadProventos.btnSalvarClick(Sender: TObject);
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

  // alterado após a troca do note para adaptar ao formato brasileiro de datas - RMoraes - 02/03/2023...
  //DMPrincipal.ADODSProvento.FieldByName('competencia').Value := FormatDateTime('yyyy-MM-dd',StrToDate(mskeCompetencia.Text));
  //DMPrincipal.ADODSProvento.FieldByName('dat_pagamento').Value := FormatDateTime('yyyy-MM-dd',StrToDate(mskePagto.Text));

  DMPrincipal.ADODSProvento.FieldByName('competencia').Value := FormatDateTime('dd-MM-yyyy',StrToDate(mskeCompetencia.Text));
  DMPrincipal.ADODSProvento.FieldByName('dat_pagamento').Value := FormatDateTime('dd-MM-yyyy',StrToDate(mskePagto.Text));

  DMPrincipal.ADODSProvento.FieldByName('vlr_total').Value := edtTotProv.Text;

  // Salva...
  try
    DMPrincipal.ADODSProvento.Post;
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

  //edtProcurar.Enabled := true;
  dbPesqCarteira.Enabled := true;
  mskeCompetenciaP.Enabled := true;

  mskeCompetencia.Enabled := false;
  dblcbAtivo.Enabled := false;
  dblcbCarteira.Enabled := false;
  dblcbTipoProvento.Enabled := false;
  dbeValorUnitario.Enabled := false;
  dbeCotas.Enabled := false;
  //dbeValorTotal.Enabled := false;
  edtTotProv.Enabled := false;
  mskePagto.Enabled := false;
  dbeDescricao.Enabled := false;

  //DMPrincipal.ADODSProvento.Close;
  //DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento';
  //DMPrincipal.ADODSProvento.Open;
  PesquisaRegistro;

  mskeCompetencia.Text := DMPrincipal.ADODSProventoCOMPETENCIA.AsString;
  mskePagto.Text := DMPrincipal.ADODSProventoDAT_PAGAMENTO.AsString;

  DMPrincipal.ADOQProventos.Close;
  DMPrincipal.ADOQProventos.Open;
  edtValorTotal.Text := DMPrincipal.ADOQProventosVALOR_TOTAL.AsString;
end;

procedure TfrmCadProventos.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSProvento.Open;
  DMPrincipal.ADODSProvento.Edit;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  //edtProcurar.Enabled := false;
  dbPesqCarteira.Enabled := false;
  mskeCompetenciaP.Enabled := false;

  mskeCompetencia.Enabled := true;
  dblcbAtivo.Enabled := true;
  dblcbCarteira.Enabled := true;
  dblcbTipoProvento.Enabled := true;
  dbeValorUnitario.Enabled := true;
  dbeCotas.Enabled := true;
  //dbeValorTotal.Enabled := true;
  edtTotProv.Enabled := true;
  mskePagto.Enabled := true;
  dbeDescricao.Enabled := true;

  mskeCompetencia.SetFocus;
end;

procedure TfrmCadProventos.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSProvento.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  //edtProcurar.Enabled := true;
  dbPesqCarteira.Enabled := true;
  mskeCompetenciaP.Enabled := true;

  mskeCompetencia.Enabled := false;
  dblcbAtivo.Enabled := false;
  dblcbCarteira.Enabled := false;
  dblcbTipoProvento.Enabled := false;
  dbeValorUnitario.Enabled := false;
  dbeCotas.Enabled := false;
  //dbeValorTotal.Enabled := false;
  edtTotProv.Enabled := false;
  mskePagto.Enabled := false;
  dbeDescricao.Enabled := false;

  //DMPrincipal.ADODSProvento.Close;
  //DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento';
  //DMPrincipal.ADODSProvento.Open;
  PesquisaRegistro;

  mskeCompetencia.Text := DMPrincipal.ADODSProventoCOMPETENCIA.AsString;
  mskePagto.Text := DMPrincipal.ADODSProventoDAT_PAGAMENTO.AsString;

  DMPrincipal.ADOQProventos.Close;
  DMPrincipal.ADOQProventos.Open;
  edtValorTotal.Text := DMPrincipal.ADOQProventosVALOR_TOTAL.AsString;
  edtTotProv.Text := DMPrincipal.ADODSProventoVLR_TOTAL.AsString;
end;

procedure TfrmCadProventos.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSProvento.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSProvento.Delete;
  end;
end;

function TfrmCadProventos.DataOk(Dt:String):Boolean;
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

procedure TfrmCadProventos.dbnProventoClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  mskeCompetencia.Text := DMPrincipal.ADODSProventoCOMPETENCIA.AsString;
  mskePagto.Text := DMPrincipal.ADODSProventoDAT_PAGAMENTO.AsString;
  edtTotProv.Text := DMPrincipal.ADODSProventoVLR_TOTAL.AsString;
end;

procedure TfrmCadProventos.dbgTiposCellClick(Column: TColumn);
begin
  mskeCompetencia.Text := DMPrincipal.ADODSProventoCOMPETENCIA.AsString;
  mskePagto.Text := DMPrincipal.ADODSProventoDAT_PAGAMENTO.AsString;
  edtTotProv.Text := DMPrincipal.ADODSProventoVLR_TOTAL.AsString;
end;

procedure TfrmCadProventos.btnLimparClick(Sender: TObject);
begin
  DMPrincipal.ADODSProvento.Close;
  DMPrincipal.ADODSProvento.CommandText := 'select * from t_provento';
  mskeCompetenciaP.Clear;
  mskeCompetencia.Clear;
  mskePagto.Clear;
  //edtProcurar.Clear;
  dbPesqCarteira.KeyValue := null;
  dbPesqAtivo.KeyValue := null;

  PesquisaRegistro;
  
  mskeCompetencia.Text := DMPrincipal.ADODSProventoCOMPETENCIA.AsString;
  mskePagto.Text := DMPrincipal.ADODSProventoDAT_PAGAMENTO.AsString;

  DMPrincipal.ADOQProventos.Close;
  DMPrincipal.ADOQProventos.Open;
  edtValorTotal.Text := DMPrincipal.ADOQProventosVALOR_TOTAL.AsString;
  edtTotProv.Text := DMPrincipal.ADODSProventoVLR_TOTAL.AsString;
end;

procedure TfrmCadProventos.dbPesqCarteiraClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TfrmCadProventos.mskeCompetenciaPExit(Sender: TObject);
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

procedure TfrmCadProventos.dbeCotasExit(Sender: TObject);
begin
  CalculaProvento;
  edtTotProv.Text := formatfloat('###,##0.00',calcTotProv);
end;

procedure TfrmCadProventos.CalculaProvento;
begin
  if (trim(dbeValorUnitario.Text) <> '') and (trim(dbeCotas.Text) <> '') then
    calcTotProv := strToFloat(dbeValorUnitario.Text) * strToFloat(dbeCotas.Text)
  else
    calcTotProv := 0;
end;

procedure TfrmCadProventos.dbeValorUnitarioExit(Sender: TObject);
begin
  CalculaProvento;
  edtTotProv.Text := formatfloat('###,##0.00',calcTotProv);
end;

procedure TfrmCadProventos.dbPesqAtivoClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

end.
