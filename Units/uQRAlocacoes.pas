unit uQRAlocacoes;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, jpeg, uDM;

type
  TqrRelAlocacoes = class(TQuickRep)
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
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRBand3: TQRBand;
    QRLabel5: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape2: TQRShape;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText12: TQRDBText;
    QRBand4: TQRBand;
    QRLabel15: TQRLabel;
    lTotalAlocacao: TQRLabel;
    lTotalAtualizado: TQRLabel;
    QRShape3: TQRShape;
    QRLabel16: TQRLabel;
    lTotalRetornoBruto: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  qrRelAlocacoes: TqrRelAlocacoes;
  tot_vlr_alocacao, tot_vlr_atualizado, tot_vlr_retornado : currency;

implementation

{$R *.DFM}

procedure TqrRelAlocacoes.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  tot_vlr_alocacao := 0;
  tot_vlr_atualizado := 0;
  tot_vlr_retornado := 0;
  DMPrincipal.ADOQAlocacoes.Open;
end;

procedure TqrRelAlocacoes.QRBand2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if not DMPrincipal.ADOQAlocacoes.Eof then
  begin
    tot_vlr_alocacao := tot_vlr_alocacao + DMPrincipal.ADOQAlocacoes.fieldbyname('vlr_alocado').Value;
    tot_vlr_atualizado := tot_vlr_atualizado + DMPrincipal.ADOQAlocacoes.fieldbyname('vlr_atualizado').Value;
  end
  else
  begin
    tot_vlr_alocacao := tot_vlr_alocacao + 0;
    tot_vlr_atualizado := tot_vlr_atualizado + 0;
  end;

end;

procedure TqrRelAlocacoes.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //if (tot_vlr_alocacao) <>
  lTotalAlocacao.Caption := formatfloat('R$###,###,##0.00',tot_vlr_alocacao);
  lTotalAtualizado.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atualizado);

  tot_vlr_retornado := tot_vlr_atualizado - tot_vlr_alocacao;

  lTotalRetornoBruto.Caption := formatfloat('R$###,###,##0.00',tot_vlr_retornado);
end;

end.
