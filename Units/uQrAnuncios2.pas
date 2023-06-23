unit uQrAnuncios2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, uDM, StdCtrls, QRPrntr, DB,
  ADODB;

type
  TqrRelAnuncios2 = class(TForm)
    qrRelAnuncios2: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRSysData2: TQRSysData;
    lblFiltro: TQRLabel;
    QRBand4: TQRBand;
    QRShape3: TQRShape;
    lTotalAtualmai: TQRLabel;
    lTotalAtualjun: TQRLabel;
    lTotalAtualjul: TQRLabel;
    lTotalAtualset: TQRLabel;
    lTotalAtualout: TQRLabel;
    QRLabel21: TQRLabel;
    lTotalPctInvestido: TQRLabel;
    QRBand2: TQRBand;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText3: TQRDBText;
    QRBand3: TQRBand;
    QRLabel22: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape2: TQRShape;
    QRGroup1: TQRGroup;
    QRLabel6: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText6: TQRDBText;
    QRBand5: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel20: TQRLabel;
    QRShape1: TQRShape;
    procedure qrRelAnuncios2BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  qrRelAnuncios2: TqrRelAnuncios2;
  tot_vlr_atualizado, tot_vlr_atual_jan, tot_vlr_atual_fev, tot_vlr_atual_mar,
  tot_vlr_atual_abr, tot_vlr_atual_mai, tot_vlr_atual_jun,
  tot_vlr_atual_jul, tot_vlr_atual_ago, tot_vlr_atual_set,
  tot_vlr_atual_out, tot_vlr_atual_nov, tot_vlr_atual_dez, tot_vlr_atual_geral : currency;
  pct_ativo_investido, tot_pct_investido, tot_cotas : Double;

implementation

{$R *.dfm}

procedure TqrRelAnuncios2.qrRelAnuncios2BeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
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
  DMPrincipal.ADOQAnunciosProventos.Open;
end;

procedure TqrRelAnuncios2.QRBand2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if not DMPrincipal.ADOQAnunciosProventos.Eof then
  begin
    tot_pct_investido := tot_pct_investido + 1;
    tot_vlr_atual_mai := tot_vlr_atual_mai + DMPrincipal.ADOQAnunciosProventos.fieldbyname('vlr_bruto').Value;
    tot_vlr_atual_jun := tot_vlr_atual_jun + DMPrincipal.ADOQAnunciosProventos.fieldbyname('vlr_ir').Value;
    tot_vlr_atual_jul := tot_vlr_atual_jul + DMPrincipal.ADOQAnunciosProventos.fieldbyname('vlr_liquido').Value;
    tot_vlr_atual_set := tot_vlr_atual_set + DMPrincipal.ADOQAnunciosProventos.fieldbyname('nro_cotas').Value;
    tot_vlr_atual_out := tot_vlr_atual_out + DMPrincipal.ADOQAnunciosProventos.fieldbyname('valor_a_receber').Value;
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

procedure TqrRelAnuncios2.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  {
  if (DMPrincipal.ADOQAnunciosProventos.fieldbyname('val_atualizado').Value <> null) and (DMPrincipal.ADOQTotalInvestido.fieldByName('val_investido').value <> null) then
    pct_ativo_investido := (DMPrincipal.ADOQAnunciosProventos.fieldbyname('val_atualizado').Value * 100) / DMPrincipal.ADOQTotalInvestido.fieldByName('val_investido').value
  else
    pct_ativo_investido := 0;

  lblPctInvestido.Caption := formatfloat('##0.00',pct_ativo_investido);
  }
end;

procedure TqrRelAnuncios2.QRBand4AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  tot_pct_investido := 0;
end;

procedure TqrRelAnuncios2.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lTotalPctInvestido.Caption := formatfloat('#####0',tot_pct_investido);
  lTotalAtualmai.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_mai);
  lTotalAtualjun.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_jun);
  lTotalAtualjul.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_jul);
  lTotalAtualset.Caption := formatfloat('###,###,##0',tot_vlr_atual_set);
  lTotalAtualout.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atual_out);
end;

end.
