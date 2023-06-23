unit uCadCaracteristicas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, Grids, DBGrids, uDM;

type
  TfrmCadCaracteristicas = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnSair: TBitBtn;
    edtProcurar: TEdit;
    dbnCarteira: TDBNavigator;
    dbgAtivos: TDBGrid;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    dbeNome: TDBEdit;
    Label4: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtProcurarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
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
  frmCadCaracteristicas: TfrmCadCaracteristicas;

implementation

{$R *.dfm}

procedure TfrmCadCaracteristicas.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSCaracteristica.Open;

  dbeNome.Enabled := false;
end;

procedure TfrmCadCaracteristicas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSCaracteristica.Close;
  DMPrincipal.ADODSCaracteristica.CommandText := 'select * from t_caracteristica';
  Action := caFree;

  frmCadCaracteristicas := nil;
end;

procedure TfrmCadCaracteristicas.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
end;

procedure TfrmCadCaracteristicas.edtProcurarKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  DMPrincipal.ADODSCaracteristica.Close;
  DMPrincipal.ADODSCaracteristica.CommandText := 'select * from t_caracteristica where dsc_caracteristica like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSCaracteristica.Open;
end;

procedure TfrmCadCaracteristicas.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadCaracteristicas := nil;
end;

procedure TfrmCadCaracteristicas.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSCaracteristica.Open;
  DMPrincipal.ADODSCaracteristica.Append;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.ReadOnly := false;
  dbeNome.Enabled:= true;
  dbeNome.SetFocus;
end;

procedure TfrmCadCaracteristicas.btnSalvarClick(Sender: TObject);
begin
  DMPrincipal.ADODSCaracteristica.Post;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;

  DMPrincipal.ADODSCaracteristica.Close;
  DMPrincipal.ADODSCaracteristica.CommandText := 'select * from t_caracteristica';
  DMPrincipal.ADODSCaracteristica.Open;
end;

procedure TfrmCadCaracteristicas.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSCaracteristica.Open;
  DMPrincipal.ADODSCaracteristica.Edit;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.Enabled := true;
  dbeNome.ReadOnly := false;
  dbeNome.SetFocus;
end;

procedure TfrmCadCaracteristicas.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSCaracteristica.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;

  DMPrincipal.ADODSCaracteristica.Close;
  DMPrincipal.ADODSCaracteristica.CommandText := 'select * from t_caracteristica';
  DMPrincipal.ADODSCaracteristica.Open;
end;

procedure TfrmCadCaracteristicas.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSCaracteristica.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSCaracteristica.Delete;
  end;
end;

end.
