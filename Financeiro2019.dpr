program Financeiro2019;

uses
  Forms,
  uMsgConectado in 'Units\uMsgConectado.pas' {frmTesteConexao},
  TABPGDLG in '..\..\..\..\Program Files (x86)\Borland\Delphi7\ObjRepos\TABPGDLG.pas' {PagesDlg},
  uMenuPrincipal in 'Units\uMenuPrincipal.pas' {frmMenuPrincipal},
  uCadUsuarios in 'Units\uCadUsuarios.pas' {frmCadUsuarios},
  uDM in 'Units\uDM.pas' {DMPrincipal: TDataModule},
  Controls,
  SysUtils,
  uCadInvestidores in 'Units\uCadInvestidores.pas' {frmCadInvestidores},
  uCadAlocacoes in 'Units\uCadAlocacoes.pas' {frmCadAlocacoes},
  uCadCarteiras in 'Units\uCadCarteiras.pas' {frmCadCarteiras},
  uPai in 'Heranca\uPai.pas' {frmPai},
  uCadGestor in 'Units\uCadGestor.pas' {frmCadGestor},
  uCadAtivos in 'Units\uCadAtivos.pas' {frmCadAtivos},
  uCadTipos in 'Units\uCadTipos.pas' {frmCadTipos},
  uCadCaracteristicas in 'Units\uCadCaracteristicas.pas' {frmCadCaracteristicas},
  uCadStatus in 'Units\uCadStatus.pas' {frmCadStatus},
  uQRInvertidores in 'Units\uQRInvertidores.pas' {qrRelInvestidores: TQuickRep},
  uQRTipInvest in 'Units\uQRTipInvest.pas' {qrRelTipInvest: TQuickRep},
  uFiltroRelAtivos in 'Units\uFiltroRelAtivos.pas' {frmFiltroRelAtivos},
  uQRAtivos in 'Units\uQRAtivos.pas' {qrRelAtivos: TQuickRep},
  uFrmFechamento in 'Units\uFrmFechamento.pas' {frmFechamento},
  uQRAlocacoes in 'Units\uQRAlocacoes.pas' {qrRelAlocacoes: TQuickRep},
  uFiltroRelAlocacoes in 'Units\uFiltroRelAlocacoes.pas' {frmFiltroRelAlocacoes},
  uFiltroRelRentabilidade in 'Units\uFiltroRelRentabilidade.pas' {frmFiltroRelRentab},
  uQRRentabil in 'Units\uQRRentabil.pas' {qrRelRentabil: TQuickRep},
  uCadMovimentacoes in 'Units\uCadMovimentacoes.pas' {frmCadMovimentacoes},
  uFiltroRelFechamento in 'Units\uFiltroRelFechamento.pas' {frmFiltroRelFechamento},
  uQRFechamento in 'Units\uQRFechamento.pas' {qrRelFechamento: TQuickRep},
  uCadMovtos in 'Units\uCadMovtos.pas' {frmCadMovtos},
  uCadTipoProvento in 'Units\uCadTipoProvento.pas' {frmCadTipoProvento},
  uCadProventos in 'Units\uCadProventos.pas' {frmCadProventos},
  uCadMetas in 'Units\uCadMetas.pas' {frmCadMetas},
  uCadCambio in 'Units\uCadCambio.pas' {frmCadCambio},
  uFiltroRelProventos in 'Units\uFiltroRelProventos.pas' {frmFiltroRelProventos},
  uQrProventos in 'Units\uQrProventos.pas' {qrRelProventos},
  uFiltroRelCambio in 'Units\uFiltroRelCambio.pas' {frmFiltroRelCambio},
  uQRCambio in 'Units\uQRCambio.pas' {qrRelCambio},
  uFiltroRelMovimentos in 'Units\uFiltroRelMovimentos.pas' {frmFiltroRelMovimentos},
  uQRMovimentos in 'Units\uQRMovimentos.pas' {qrRelMovimentos},
  UCadAnuncioProventos in 'Units\UCadAnuncioProventos.pas' {frmCadAnuncioProventos},
  uFiltroRelAnuncios in 'Units\uFiltroRelAnuncios.pas' {frmFiltroRelAnuncios},
  uQrAnuncios2 in 'Units\uQrAnuncios2.pas' {qrRelAnuncios2},
  uFrmConsultaProventos in 'Units\uFrmConsultaProventos.pas' {frmConsultaProventos};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TfrmTesteConexao, frmTesteConexao);
  if frmTesteConexao.ShowModal = mrOK then
  begin
    FreeAndNil(frmTesteConexao);
    Application.CreateForm(TfrmTesteConexao, frmTesteConexao);
    Application.Run;
  end
  else
    Application.Terminate;

end.
