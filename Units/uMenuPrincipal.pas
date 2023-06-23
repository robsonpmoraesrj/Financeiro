unit uMenuPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, uCadUsuarios, uCadInvestidores, uCadAlocacoes, uCadCarteiras,
  jpeg, ExtCtrls, uCadGestor, uCadAtivos, uCadTipos, uCadCaracteristicas, uCadStatus, uQRInvertidores,
  uQRTipInvest, uQRAlocacoes, uFiltroRelAtivos, uFiltroRelRentabilidade, uFrmFechamento,
  uFiltroRelAlocacoes, uCadMovimentacoes, uCadMovtos, uFiltroRelFechamento, uCadTipoProvento,
  StdCtrls, Buttons;

type
  TfrmMenuPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Robson1: TMenuItem;
    Famlia1: TMenuItem;
    Sair1: TMenuItem;
    mpUsuarios: TMenuItem;
    Investimentos1: TMenuItem;
    Parmetros1: TMenuItem;
    Status1: TMenuItem;
    CDB2: TMenuItem;
    Usurios2: TMenuItem;
    Carteiras1: TMenuItem;
    Carteiras2: TMenuItem;
    Usurios1: TMenuItem;
    mmCadAlocacao: TMenuItem;
    Image1: TImage;
    Caractersticas1: TMenuItem;
    Investidores1: TMenuItem;
    Alocaes1: TMenuItem;
    Movimentaes1: TMenuItem;
    Rentabilidade1: TMenuItem;
    iposdeInvestimento2: TMenuItem;
    Gestor1: TMenuItem;
    Listagem1: TMenuItem;
    Fechamento1: TMenuItem;
    Mensal1: TMenuItem;
    Movimentaes2: TMenuItem;
    Fechamento2: TMenuItem;
    iposdeInvestimento3: TMenuItem;
    GestoresAdministradores1: TMenuItem;
    Cotaes1: TMenuItem;
    ipodeProvento1: TMenuItem;
    Proventos1: TMenuItem;
    Metas1: TMenuItem;
    Cmbio1: TMenuItem;
    Proventos2: TMenuItem;
    MovimentaesdeCmbio1: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    util: TMenuItem;
    Teste1: TMenuItem;
    AnnciosdeProventos1: TMenuItem;
    BitBtn6: TBitBtn;
    AnnciosdeProventos2: TMenuItem;
    ConsultaProventos1: TMenuItem;
    BitBtn7: TBitBtn;
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Usurios1Click(Sender: TObject);
    procedure mpUsuariosClick(Sender: TObject);
    procedure mmCadAlocacaoClick(Sender: TObject);
    procedure Carteiras1Click(Sender: TObject);
    procedure Investimentos1Click(Sender: TObject);
    procedure Caractersticas1Click(Sender: TObject);
    procedure Status1Click(Sender: TObject);
    procedure Investidores1Click(Sender: TObject);
    procedure iposdeInvestimento2Click(Sender: TObject);
    procedure Listagem1Click(Sender: TObject);
    procedure Mensal1Click(Sender: TObject);
    procedure Alocaes1Click(Sender: TObject);
    procedure Rentabilidade1Click(Sender: TObject);
    procedure Movimentaes2Click(Sender: TObject);
    procedure Fechamento2Click(Sender: TObject);
    procedure iposdeInvestimento3Click(Sender: TObject);
    procedure GestoresAdministradores1Click(Sender: TObject);
    procedure ipodeProvento1Click(Sender: TObject);
    procedure Proventos1Click(Sender: TObject);
    procedure Metas1Click(Sender: TObject);
    procedure Cmbio1Click(Sender: TObject);
    procedure Proventos2Click(Sender: TObject);
    procedure MovimentaesdeCmbio1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Movimentaes1Click(Sender: TObject);
    procedure AnnciosdeProventos1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure AnnciosdeProventos2Click(Sender: TObject);
    procedure ConsultaProventos1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    { Private declarations }
    uFrmCadUsuarios : TfrmCadUsuarios;
    uFrmCadInvestidores : TfrmCadInvestidores;
    uFrmCadAlocacoes : TfrmCadAlocacoes;
    uFrmCadCarteiras : TfrmCadCarteiras;
    uFrmCadGestor : TfrmCadGestor;
    uFrmCadAtivos : TfrmCadAtivos;
    uFrmCadTipos : TfrmCadTipos;
    uFrmCadCaracteristicas : TfrmCadCaracteristicas;
    uFrmCadStatus : TfrmCadStatus;
    qrRelInvestidores : TqrRelInvestidores;
    qrRelTipInvest : TqrRelTipInvest;
    qrRelAlocacoes : TqrRelAlocacoes;
    uFiltroRelAtivos : TfrmFiltroRelAtivos;
    uFiltroRelRentab : TfrmFiltroRelRentab;
    uFiltroRelAlocacoes : TfrmFiltroRelAlocacoes;
    ufrmFechamento : TfrmFechamento;
    uFrmCadMovimentacoes : TfrmCadMovimentacoes;
    uFrmCadMovtos : TfrmCadMovtos;
    uFiltroRelFechamento : TfrmFiltroRelFechamento;
  public
    { Public declarations }
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation

uses uCadProventos, uCadMetas, uCadCambio, uFiltroRelProventos,
  uFiltroRelCambio, uFiltroRelMovimentos, UCadAnuncioProventos,
  uFiltroRelAnuncios, uFrmConsultaProventos;

{$R *.dfm}

procedure TfrmMenuPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
  frmMenuPrincipal := nil;
end;

procedure TfrmMenuPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmMenuPrincipal := nil;
end;

procedure TfrmMenuPrincipal.Usurios1Click(Sender: TObject);
begin
  if frmCadUsuarios = nil then
  begin
    uFrmCadUsuarios := TfrmCadUsuarios.Create(nil);
    uFrmCadUsuarios.ShowModal;
    uFrmCadUsuarios.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.mpUsuariosClick(Sender: TObject);
begin
  if frmCadInvestidores = nil then
  begin
    uFrmCadInvestidores := TfrmCadInvestidores.Create(nil);
    uFrmCadInvestidores.ShowModal;
    uFrmCadInvestidores.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.mmCadAlocacaoClick(Sender: TObject);
begin
  if frmCadAlocacoes = nil then
  begin
    ufrmCadAlocacoes := TfrmCadAlocacoes.Create(nil);
    ufrmCadAlocacoes.ShowModal;
    ufrmCadAlocacoes.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Carteiras1Click(Sender: TObject);
begin
  if frmCadCarteiras = nil then
  begin
    ufrmCadCarteiras := TfrmCadCarteiras.Create(nil);
    ufrmCadCarteiras.ShowModal;
    ufrmCadCarteiras.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Investimentos1Click(Sender: TObject);
begin
  if frmCadAtivos = nil then
  begin
    ufrmCadAtivos := TfrmCadAtivos.Create(nil);
    ufrmCadAtivos.ShowModal;
    ufrmCadAtivos.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Caractersticas1Click(Sender: TObject);
begin
  if frmCadCaracteristicas = nil then
  begin
    uFrmCadCaracteristicas := TfrmCadCaracteristicas.Create(nil);
    uFrmCadCaracteristicas.ShowModal;
    uFrmCadCaracteristicas.Destroy;
  end;  
end;

procedure TfrmMenuPrincipal.Status1Click(Sender: TObject);
begin
  if frmCadStatus = nil then
  begin
    uFrmCadStatus := TfrmCadStatus.Create(nil);
    uFrmCadStatus.ShowModal;
    uFrmCadStatus.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Investidores1Click(Sender: TObject);
  var relInvest : TqrRelInvestidores;
begin
  relInvest := TqrRelInvestidores.Create(Self);
  relInvest.Preview;
  relInvest.Free;
end;

procedure TfrmMenuPrincipal.iposdeInvestimento2Click(Sender: TObject);
  var relTipInvest : TqrRelTipInvest;
begin
  relTipInvest := TqrRelTipInvest.Create(Self);
  relTipInvest.Preview;
  relTipInvest.Free;
end;

procedure TfrmMenuPrincipal.Listagem1Click(Sender: TObject);
begin
  if frmFiltroRelAtivos = nil then
  begin
    uFiltroRelAtivos := TfrmFiltroRelAtivos.Create(nil);
    uFiltroRelAtivos.ShowModal;
    uFiltroRelAtivos.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Mensal1Click(Sender: TObject);
begin
  ufrmFechamento := TfrmFechamento.Create(nil);
  ufrmFechamento.ShowModal;
  ufrmFechamento.Destroy;
end;

procedure TfrmMenuPrincipal.Alocaes1Click(Sender: TObject);
begin
  if frmFiltroRelAlocacoes = nil then
  begin
    uFiltroRelAlocacoes := TfrmFiltroRelAlocacoes.Create(nil);
    uFiltroRelAlocacoes.ShowModal;
    uFiltroRelAlocacoes.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Rentabilidade1Click(Sender: TObject);
begin
  if frmFiltroRelRentab = nil then
  begin
    uFiltroRelRentab := TfrmFiltroRelRentab.Create(nil);
    uFiltroRelRentab.ShowModal;
    uFiltroRelRentab.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Movimentaes2Click(Sender: TObject);
begin
  if frmCadMovtos = nil then
  begin
    ufrmCadMovtos := TfrmCadMovtos.Create(nil);
    ufrmCadMovtos.ShowModal;
    ufrmCadMovtos.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Fechamento2Click(Sender: TObject);
begin
  if frmFiltroRelFechamento = nil then
  begin
    uFiltroRelFechamento := TfrmFiltroRelFechamento.Create(nil);
    uFiltroRelFechamento.ShowModal;
    uFiltroRelFechamento.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.iposdeInvestimento3Click(Sender: TObject);
begin
  if frmCadTipos = nil then
  begin
    ufrmCadTipos := TfrmCadTipos.Create(nil);
    ufrmCadTipos.ShowModal;
    ufrmCadTipos.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.GestoresAdministradores1Click(Sender: TObject);
begin
  if frmCadGestor = nil then
  begin
    ufrmCadGestor := TfrmCadGestor.Create(nil);
    ufrmCadGestor.ShowModal;
    ufrmCadGestor.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.ipodeProvento1Click(Sender: TObject);
begin
  if frmCadTipoProvento = nil then
  begin
    frmCadTipoProvento := TfrmCadTipoProvento.Create(nil);
    frmCadTipoProvento.ShowModal;
    //frmCadTipoProvento.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Proventos1Click(Sender: TObject);
begin
  if frmCadProventos = nil then
  begin
    frmCadProventos := TfrmCadProventos.Create(nil);
    frmCadProventos.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.Metas1Click(Sender: TObject);
begin
  if frmCadMetas = nil then
  begin
    frmCadMetas := TfrmCadMetas.Create(nil);
    frmCadMetas.ShowModal;
    //frmCadMetas.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.Cmbio1Click(Sender: TObject);
begin
  if frmCadCambio = nil then
  begin
    frmCadCambio := TfrmCadCambio.Create(nil);
    frmCadCambio.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.Proventos2Click(Sender: TObject);
begin
  if frmFiltroRelProventos = nil then
  begin
    frmFiltroRelProventos := TfrmFiltroRelProventos.Create(nil);
    frmFiltroRelProventos.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.MovimentaesdeCmbio1Click(Sender: TObject);
begin
  if frmFiltroRelCambio = nil then
  begin
    frmFiltroRelCambio := TfrmFiltroRelCambio.Create(nil);
    frmFiltroRelCambio.ShowModal;
  end;  
end;

procedure TfrmMenuPrincipal.BitBtn1Click(Sender: TObject);
begin
  if frmCadAlocacoes = nil then
  begin
    ufrmCadAlocacoes := TfrmCadAlocacoes.Create(nil);
    ufrmCadAlocacoes.ShowModal;
    ufrmCadAlocacoes.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.BitBtn2Click(Sender: TObject);
begin
  if frmCadMovtos = nil then
  begin
    ufrmCadMovtos := TfrmCadMovtos.Create(nil);
    ufrmCadMovtos.ShowModal;
    ufrmCadMovtos.Destroy;
  end;
end;

procedure TfrmMenuPrincipal.BitBtn3Click(Sender: TObject);
begin
  if frmCadProventos = nil then
  begin
    frmCadProventos := TfrmCadProventos.Create(nil);
    frmCadProventos.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.BitBtn5Click(Sender: TObject);
begin
  Close;
  frmMenuPrincipal := nil;
end;

procedure TfrmMenuPrincipal.Movimentaes1Click(Sender: TObject);
begin
  if frmFiltroRelMovimentos = nil then
  begin
    frmFiltroRelMovimentos := TfrmFiltroRelMovimentos.Create(nil);
    frmFiltroRelMovimentos.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.AnnciosdeProventos1Click(Sender: TObject);
begin
  if frmCadAnuncioProventos = nil then
  begin
    frmCadAnuncioProventos := TfrmCadAnuncioProventos.Create(nil);
    frmCadAnuncioProventos.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.BitBtn6Click(Sender: TObject);
begin
  if frmCadAnuncioProventos = nil then
  begin
    frmCadAnuncioProventos := TfrmCadAnuncioProventos.Create(nil);
    frmCadAnuncioProventos.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.AnnciosdeProventos2Click(Sender: TObject);
begin
  if frmFiltroRelAnuncios = nil then
  begin
    frmFiltroRelAnuncios := TfrmFiltroRelAnuncios.Create(nil);
    frmFiltroRelAnuncios.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.ConsultaProventos1Click(Sender: TObject);
begin
  if frmConsultaProventos = nil then
  begin
    frmConsultaProventos := TfrmConsultaProventos.Create(nil);
    frmConsultaProventos.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.BitBtn4Click(Sender: TObject);
begin
  if frmCadCambio = nil then
  begin
    frmCadCambio := TfrmCadCambio.Create(nil);
    frmCadCambio.ShowModal;
  end;
end;

procedure TfrmMenuPrincipal.BitBtn7Click(Sender: TObject);
begin
  if frmConsultaProventos = nil then
  begin
    frmConsultaProventos := TfrmConsultaProventos.Create(nil);
    frmConsultaProventos.ShowModal;
  end;
end;

end.
