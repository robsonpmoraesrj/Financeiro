unit uQrProventos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, uDM, StdCtrls, QRPrntr;

type
  TqrRelProventos = class(TForm)
    qrRelProventos: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape1: TQRShape;
    QRSysData2: TQRSysData;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRBand4: TQRBand;
    lTotalAtualizado: TQRLabel;
    lTotalAtualjan: TQRLabel;
    QRShape3: TQRShape;
    lTotalAtualfev: TQRLabel;
    lTotalAtualmar: TQRLabel;
    lTotalAtualabr: TQRLabel;
    lTotalAtualmai: TQRLabel;
    lTotalAtualjun: TQRLabel;
    lTotalAtualjul: TQRLabel;
    lTotalAtualago: TQRLabel;
    lTotalAtualset: TQRLabel;
    lTotalAtualout: TQRLabel;
    lTotalAtualnov: TQRLabel;
    lTotalAtualdez: TQRLabel;
    QRBand3: TQRBand;
    QRLabel22: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape2: TQRShape;
    QRLabel21: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    lblPctInvestido: TQRLabel;
    lTotalPctInvestido: TQRLabel;
    lTotalCotas: TQRLabel;
    lblFiltro: TQRLabel;
    QRDBText17: TQRDBText;
    lTotalAtualGeral: TQRLabel;
    procedure QRBand2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrRelProventosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }                             
  end;

var
  qrRelProventos: TqrRelProventos;
  tot_vlr_atualizado, tot_vlr_atual_jan, tot_vlr_atual_fev, tot_vlr_atual_mar,
  tot_vlr_atual_abr, tot_vlr_atual_mai, tot_vlr_atual_jun,
  tot_vlr_atual_jul, tot_vlr_atual_ago, tot_vlr_atual_set,
  tot_vlr_atual_out, tot_vlr_atual_nov, tot_vlr_atual_dez, tot_vlr_atual_geral : currency;
  pct_ativo_investido, tot_pct_investido, tot_cotas : Double;

implementation

{$R *.dfm}

procedure TqrRelProventos.QRBand2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if not DMPrincipal.ADOQProventosAno.Eof then
  begin
    tot_vlr_atualizado := tot_vlr_atualizado + DMPrincipal.ADOQProventosAno.fieldbyname('val_atualizado').Value;
    tot_cotas := tot_cotas + DMPrincipal.ADOQProventosAno.fieldbyname('nro_cotas').Value;
    tot_pct_investido := tot_pct_investido + pct_ativo_investido;
    tot_vlr_atual_jan := tot_vlr_atual_jan + DMPrincipal.ADOQProventosAno.fieldbyname('janeiro').Value;
    tot_vlr_atual_fev := tot_vlr_atual_fev + DMPrincipal.ADOQProventosAno.fieldbyname('fevereiro').Value;
    tot_vlr_atual_mar := tot_vlr_atual_mar + DMPrincipal.ADOQProventosAno.fieldbyname('marco').Value;
    tot_vlr_atual_abr := tot_vlr_atual_abr + DMPrincipal.ADOQProventosAno.fieldbyname('abril').Value;
    tot_vlr_atual_mai := tot_vlr_atual_mai + DMPrincipal.ADOQProventosAno.fieldbyname('maio').Value;
    tot_vlr_atual_jun := tot_vlr_atual_jun + DMPrincipal.ADOQProventosAno.fieldbyname('junho').Value;
    tot_vlr_atual_jul := tot_vlr_atual_jul + DMPrincipal.ADOQProventosAno.fieldbyname('julho').Value;
    tot_vlr_atual_ago := tot_vlr_atual_ago + DMPrincipal.ADOQProventosAno.fieldbyname('agosto').Value;
    tot_vlr_atual_set := tot_vlr_atual_set + DMPrincipal.ADOQProventosAno.fieldbyname('setembro').Value;
    tot_vlr_atual_out := tot_vlr_atual_out + DMPrincipal.ADOQProventosAno.fieldbyname('outubro').Value;
    tot_vlr_atual_nov := tot_vlr_atual_nov + DMPrincipal.ADOQProventosAno.fieldbyname('novembro').Value;
    tot_vlr_atual_dez := tot_vlr_atual_dez + DMPrincipal.ADOQProventosAno.fieldbyname('dezembro').Value;
    tot_vlr_atual_geral := tot_vlr_atual_geral + DMPrincipal.ADOQProventosAno.fieldbyname('total').Value;
  end
  else
  begin
    tot_vlr_atualizado := tot_vlr_atualizado + 0;
    tot_cotas := tot_cotas + 0;
    tot_pct_investido := tot_pct_investido + 0;
    tot_vlr_atual_jan := tot_vlr_atual_jan + 0;
    tot_vlr_atual_fev := tot_vlr_atual_fev + 0;
    tot_vlr_atual_mar := tot_vlr_atual_mar + 0;
    tot_vlr_atual_abr := tot_vlr_atual_abr + 0;
    tot_vlr_atual_mai := tot_vlr_atual_mai + 0;
    tot_vlr_atual_jun := tot_vlr_atual_jun + 0;
    tot_vlr_atual_jul := tot_vlr_atual_jul + 0;
    tot_vlr_atual_ago := tot_vlr_atual_ago + 0;
    tot_vlr_atual_set := tot_vlr_atual_set + 0;
    tot_vlr_atual_out := tot_vlr_atual_out + 0;
    tot_vlr_atual_nov := tot_vlr_atual_nov + 0;
    tot_vlr_atual_dez := tot_vlr_atual_dez + 0;
    tot_vlr_atual_geral := tot_vlr_atual_geral + 0;
  end;
  pct_ativo_investido := 0;
end;

procedure TqrRelProventos.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lTotalAtualizado.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atualizado);
  lTotalCotas.Caption := formatfloat('##0.00',tot_cotas);
  lTotalPctInvestido.Caption := formatfloat('##0.00',tot_pct_investido);
  lTotalAtualjan.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_jan);
  lTotalAtualfev.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_fev);
  lTotalAtualmar.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_mar);
  lTotalAtualabr.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_abr);
  lTotalAtualmai.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_mai);
  lTotalAtualjun.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_jun);
  lTotalAtualjul.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_jul);
  lTotalAtualago.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_ago);
  lTotalAtualset.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_set);
  lTotalAtualout.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_out);
  lTotalAtualnov.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_nov);
  lTotalAtualdez.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_dez);
  lTotalAtualGeral.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_geral);
end;

procedure TqrRelProventos.qrRelProventosBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  tot_vlr_atualizado := 0;
  tot_cotas := 0;
  tot_vlr_atual_jan := 0;
  tot_vlr_atual_fev := 0;
  tot_vlr_atual_mar := 0;
  tot_vlr_atual_abr := 0;
  tot_vlr_atual_mai := 0;
  tot_vlr_atual_jun := 0;
  tot_vlr_atual_jul := 0;
  tot_vlr_atual_ago := 0;
  tot_vlr_atual_set := 0;
  tot_vlr_atual_out := 0;
  tot_vlr_atual_nov := 0;
  tot_vlr_atual_dez := 0;
  tot_vlr_atual_geral := 0;
  DMPrincipal.ADOQTotalInvestido.Open;
  DMPrincipal.ADOQProventosAno.Open;
end;

procedure TqrRelProventos.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if (DMPrincipal.ADOQProventosAno.fieldbyname('val_atualizado').Value <> null) and (DMPrincipal.ADOQTotalInvestido.fieldByName('val_investido').value <> null) then
    pct_ativo_investido := (DMPrincipal.ADOQProventosAno.fieldbyname('val_atualizado').Value * 100) / DMPrincipal.ADOQTotalInvestido.fieldByName('val_investido').value
  else
    pct_ativo_investido := 0;

  lblPctInvestido.Caption := formatfloat('##0.00',pct_ativo_investido);
end;

procedure TqrRelProventos.QRBand4AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  tot_pct_investido := 0;
end;

end.
