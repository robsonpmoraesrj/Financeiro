unit uQRRentabil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, uDM, uQRAtivos;

type
  TqrRelRentabil = class(TqrRelAtivos)
    QRLabel12: TQRLabel;
    QRDBText9: TQRDBText;
    QRBand4: TQRBand;
    QRLabel15: TQRLabel;
    lTotalAlocacao: TQRLabel;
    lTotalAtualizado: TQRLabel;
    QRShape3: TQRShape;
    lTotalRetornoBruto: TQRLabel;
    procedure QRBand2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  qrRelRentabil: TqrRelRentabil;
  tot_vlr_alocacao, tot_vlr_atualizado, tot_vlr_retornado : currency;

implementation

{$R *.dfm}

procedure TqrRelRentabil.QRBand2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  if not DMPrincipal.ADOQRentab.Eof then
  begin
    tot_vlr_alocacao := tot_vlr_alocacao + DMPrincipal.ADOQRentab.fieldbyname('vlr_alocado').Value;
    tot_vlr_atualizado := tot_vlr_atualizado + DMPrincipal.ADOQRentab.fieldbyname('vlr_atualizado').Value;
  end
  else
  begin
    tot_vlr_alocacao := tot_vlr_alocacao + 0;
    tot_vlr_atualizado := tot_vlr_atualizado + 0;
  end;

end;

procedure TqrRelRentabil.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  lTotalAlocacao.Caption := formatfloat('R$###,###,##0.00',tot_vlr_alocacao);
  lTotalAtualizado.Caption := formatfloat('R$###,###,##0.00',tot_vlr_atualizado);

  tot_vlr_retornado := tot_vlr_atualizado - tot_vlr_alocacao;

  lTotalRetornoBruto.Caption := formatfloat('R$###,###,##0.00',tot_vlr_retornado);
end;

procedure TqrRelRentabil.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  tot_vlr_alocacao := 0;
  tot_vlr_atualizado := 0;
  tot_vlr_retornado := 0;
  DMPrincipal.ADOQAlocacoes.Open;
end;

procedure TqrRelRentabil.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  if (DMPrincipal.ADOQRentab.fieldbyname('vlr_ret_liq').Value < 0) then
    QRDBText8.Font.Style := [fsBold]
  else
    QRDBText8.Font.Style := [];
end;

end.
