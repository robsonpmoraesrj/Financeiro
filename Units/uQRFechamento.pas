unit uQRFechamento;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, uDM, jpeg;

type
  TqrRelFechamento = class(TQuickRep)
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
    QRBand4: TQRBand;
    QRLabel15: TQRLabel;
    lTotalAlocacao: TQRLabel;
    lTotalAtualjan: TQRLabel;
    QRShape3: TQRShape;
    lTotalAtualfev: TQRLabel;
    QRBand3: TQRBand;
    QRLabel5: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape2: TQRShape;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
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
    procedure QRBand2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  qrRelFechamento: TqrRelFechamento;
  tot_vlr_alocacao, tot_vlr_atual_jan, tot_vlr_atual_fev, tot_vlr_atual_mar,
  tot_vlr_atual_abr, tot_vlr_atual_mai, tot_vlr_atual_jun,
  tot_vlr_atual_jul, tot_vlr_atual_ago, tot_vlr_atual_set,
  tot_vlr_atual_out, tot_vlr_atual_nov, tot_vlr_atual_dez : currency;

implementation

{$R *.DFM}

procedure TqrRelFechamento.QRBand2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if not DMPrincipal.ADOQPerformace.Eof then
  begin
    tot_vlr_alocacao := tot_vlr_alocacao + DMPrincipal.ADOQPerformace.fieldbyname('vlr_alocado').Value;
    tot_vlr_atual_jan := tot_vlr_atual_jan + DMPrincipal.ADOQPerformace.fieldbyname('janeiro').Value;
    tot_vlr_atual_fev := tot_vlr_atual_fev + DMPrincipal.ADOQPerformace.fieldbyname('fevereiro').Value;
    tot_vlr_atual_mar := tot_vlr_atual_mar + DMPrincipal.ADOQPerformace.fieldbyname('marco').Value;
    tot_vlr_atual_abr := tot_vlr_atual_abr + DMPrincipal.ADOQPerformace.fieldbyname('abril').Value;
    tot_vlr_atual_mai := tot_vlr_atual_mai + DMPrincipal.ADOQPerformace.fieldbyname('maio').Value;
    tot_vlr_atual_jun := tot_vlr_atual_jun + DMPrincipal.ADOQPerformace.fieldbyname('junho').Value;
    tot_vlr_atual_jul := tot_vlr_atual_jul + DMPrincipal.ADOQPerformace.fieldbyname('julho').Value;
    tot_vlr_atual_ago := tot_vlr_atual_ago + DMPrincipal.ADOQPerformace.fieldbyname('agosto').Value;
    tot_vlr_atual_set := tot_vlr_atual_set + DMPrincipal.ADOQPerformace.fieldbyname('setembro').Value;
    tot_vlr_atual_out := tot_vlr_atual_out + DMPrincipal.ADOQPerformace.fieldbyname('outubro').Value;
    tot_vlr_atual_nov := tot_vlr_atual_nov + DMPrincipal.ADOQPerformace.fieldbyname('novembro').Value;
    tot_vlr_atual_dez := tot_vlr_atual_dez + DMPrincipal.ADOQPerformace.fieldbyname('dezembro').Value;
  end
  else
  begin
    tot_vlr_alocacao := tot_vlr_alocacao + 0;
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
  end;
end;

procedure TqrRelFechamento.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lTotalAlocacao.Caption := formatfloat('R$###,###,##0.00',tot_vlr_alocacao);
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
end;

procedure TqrRelFechamento.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  tot_vlr_alocacao := 0;
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
  DMPrincipal.ADOQPerformace.Open;
end;

end.
