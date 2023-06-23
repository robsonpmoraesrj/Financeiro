unit uQRMovimentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, uDM, QRCtrls, jpeg;

type
  TqrRelMovimentos = class(TForm)
    qrRelMovimentos: TQuickRep;
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
    QRLabel10: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel15: TQRLabel;
    lblFiltro: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText16: TQRDBText;
    QRBand4: TQRBand;
    QRShape3: TQRShape;
    lTotalAtualCotas: TQRLabel;
    lTotalAtualUnitario: TQRLabel;
    lTotalAtualOutrasDespesas: TQRLabel;
    lTotalAtualMovimentos: TQRLabel;
    QRLabel21: TQRLabel;
    QRBand3: TQRBand;
    QRLabel22: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape2: TQRShape;
    lbCategoria: TQRLabel;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrRelMovimentosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  qrRelMovimentos: TqrRelMovimentos;
  tot_vlr_unitario, tot_vlr_outras_despesas, tot_vlr_movimento : currency;
  tot_cotas : Double;

implementation

{$R *.dfm}

procedure TqrRelMovimentos.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if DMPrincipal.ADOQMovimentos.FieldByName('CAT_MOVIMENTO').AsString = 'M' then
    lbCategoria.Caption := 'MERCADO'
  else
    if DMPrincipal.ADOQMovimentos.FieldByName('CAT_MOVIMENTO').AsString = 'S' then
      lbCategoria.Caption := 'SUBSCRIÇÃO'
    else
      if DMPrincipal.ADOQMovimentos.FieldByName('CAT_MOVIMENTO').AsString = 'D' then
        lbCategoria.Caption := 'DESDOBRAMENTO'
      else
        if DMPrincipal.ADOQMovimentos.FieldByName('CAT_MOVIMENTO').AsString = 'B' then
          lbCategoria.Caption := 'BONIFICAÇÃO'
        else
          lbCategoria.Caption := 'OUTROS';
end;

procedure TqrRelMovimentos.QRBand2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if not DMPrincipal.ADOQMovimentos.Eof then
  begin
    tot_cotas := tot_cotas + DMPrincipal.ADOQMovimentos.fieldbyname('qtd_cotas').Value;
    tot_vlr_unitario := tot_vlr_unitario + DMPrincipal.ADOQMovimentos.fieldbyname('vlr_unitario').Value;
    tot_vlr_outras_despesas := tot_vlr_outras_despesas + DMPrincipal.ADOQMovimentos.fieldbyname('vlr_outras_despesas').Value;
    tot_vlr_movimento := tot_vlr_movimento + DMPrincipal.ADOQMovimentos.fieldbyname('vlr_movimento').Value;
  end
  else
  begin
    tot_cotas := tot_cotas + 0;
    tot_vlr_unitario := tot_vlr_unitario + 0;
    tot_vlr_outras_despesas := tot_vlr_outras_despesas + 0;
    tot_vlr_movimento := tot_vlr_movimento + 0;
  end;
end;

procedure TqrRelMovimentos.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lTotalAtualCotas.Caption := formatfloat('##0.00',tot_cotas);
  lTotalAtualUnitario.Caption := formatfloat('R$###,###,##0.00',tot_vlr_unitario);
  lTotalAtualOutrasDespesas.Caption := formatfloat('R$###,###,##0.00',tot_vlr_outras_despesas);
  lTotalAtualMovimentos.Caption := formatfloat('R$###,###,##0.00',tot_vlr_movimento);
end;

procedure TqrRelMovimentos.qrRelMovimentosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  tot_cotas := 0;
  tot_vlr_unitario := 0;
  tot_vlr_outras_despesas := 0;
  tot_vlr_movimento := 0;

  DMPrincipal.ADOQMovimentos.Open;
end;

end.
