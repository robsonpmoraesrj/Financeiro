unit uCadTipoProvento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, Mask, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, uDM;

type
  TfrmCadTipoProvento = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnSair: TBitBtn;
    edtProcurar: TEdit;
    dbnCarteira: TDBNavigator;
    dbgTipos: TDBGrid;
    Label2: TLabel;
    dbeNome: TDBEdit;
    Label3: TLabel;
    dbeDescricao: TDBEdit;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadTipoProvento: TfrmCadTipoProvento;

implementation

{$R *.dfm}

procedure TfrmCadTipoProvento.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadTipoProvento := nil;
end;

procedure TfrmCadTipoProvento.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSTpProvento.Open;

  dbeNome.Enabled := false;
  dbeDescricao.Enabled := false;
end;

procedure TfrmCadTipoProvento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSTpProvento.Close;
  DMPrincipal.ADODSTpProvento.CommandText := 'select * from t_tipprovento';
  Action := caFree;

  frmCadTipoProvento := nil;
end;

procedure TfrmCadTipoProvento.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
end;

procedure TfrmCadTipoProvento.edtProcurarKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  DMPrincipal.ADODSTpProvento.Close;
  DMPrincipal.ADODSTpProvento.CommandText := 'select * from t_tipprovento where dsc_tipprovento like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSTpProvento.Open;
end;

procedure TfrmCadTipoProvento.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSTpProvento.Append;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.ReadOnly := false;
  dbeNome.Enabled:= true;
  dbeDescricao.ReadOnly := false;
  dbeDescricao.Enabled := true;

  dbeNome.SetFocus;
end;

procedure TfrmCadTipoProvento.btnSalvarClick(Sender: TObject);
begin
  DMPrincipal.ADODSTpProvento.Post;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeNome.Enabled:= false;
  dbeDescricao.ReadOnly := true;
  dbeDescricao.Enabled := false;

  DMPrincipal.ADODSTpProvento.Close;
  DMPrincipal.ADODSTpProvento.CommandText := 'select * from t_tipprovento';
  DMPrincipal.ADODSTpProvento.Open;
end;

procedure TfrmCadTipoProvento.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSTpProvento.Open;
  DMPrincipal.ADODSTpProvento.Edit;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.ReadOnly := false;
  dbeNome.Enabled:= true;
  dbeDescricao.ReadOnly := false;
  dbeDescricao.Enabled := true;

  dbeNome.SetFocus;
end;

procedure TfrmCadTipoProvento.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSTpProvento.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeNome.Enabled:= false;
  dbeDescricao.ReadOnly := true;
  dbeDescricao.Enabled := false;

  DMPrincipal.ADODSTpProvento.Close;
  DMPrincipal.ADODSTpProvento.CommandText := 'select * from t_tipprovento';
  DMPrincipal.ADODSTpProvento.Open;
end;

procedure TfrmCadTipoProvento.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSTpProvento.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSTpProvento.Delete;
  end;
end;

end.
