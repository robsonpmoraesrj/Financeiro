unit uCadUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  DBCtrls, uDM, Mask;

type
  TfrmCadUsuarios = class(TForm)
    GroupBox1: TGroupBox;
    dbgUsuario: TDBGrid;
    BitBtn2: TBitBtn;
    edtProcurar: TEdit;
    Label1: TLabel;
    dbnUsuarios: TDBNavigator;
    btnExcluir: TBitBtn;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    dbeNome: TDBEdit;
    Label3: TLabel;
    dbeSenha: TDBEdit;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtProcurarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadUsuarios: TfrmCadUsuarios;

implementation

{$R *.dfm}

procedure TfrmCadUsuarios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSUsuario.Close;
  DMPrincipal.ADODSUsuario.CommandText := 'select * from t_usuario';
  Action := caFree;

  frmCadUsuarios := nil;
end;

procedure TfrmCadUsuarios.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSUsuario.Open;
end;

procedure TfrmCadUsuarios.BitBtn2Click(Sender: TObject);
begin
  Close;
  frmCadUsuarios := nil;
end;

procedure TfrmCadUsuarios.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSUsuario.Open;
  DMPrincipal.ADODSUsuario.Append;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;
  
  dbeNome.Enabled := true;
  dbeSenha.Enabled := true;
  dbeNome.ReadOnly := false;
  dbeSenha.ReadOnly := false;
  dbeNome.SetFocus;
end;

procedure TfrmCadUsuarios.btnFecharClick(Sender: TObject);
begin
  Close;
  frmCadUsuarios := nil;
end;

procedure TfrmCadUsuarios.btnSalvarClick(Sender: TObject);
begin
  DMPrincipal.ADODSUsuario.Post;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeSenha.ReadOnly := true;
  DMPrincipal.ADODSUsuario.Close;
  DMPrincipal.ADODSUsuario.CommandText := 'select * from t_usuario';
  DMPrincipal.ADODSUsuario.Open;
end;

procedure TfrmCadUsuarios.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSUsuario.Open;
  DMPrincipal.ADODSUsuario.Edit;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;
  
  dbeNome.Enabled := true;
  dbeSenha.Enabled := true;
  dbeNome.ReadOnly := false;
  dbeSenha.ReadOnly := false;
  dbeNome.SetFocus;
end;

procedure TfrmCadUsuarios.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DMPrincipal.ADODSUsuario.Close;
  DMPrincipal.ADODSUsuario.CommandText := 'select * from t_usuario where usu_nome like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSUsuario.Open;
end;

procedure TfrmCadUsuarios.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSUsuario.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSUsuario.Delete;
  end;
end;

procedure TfrmCadUsuarios.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSUsuario.Cancel;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeSenha.ReadOnly := true;
  DMPrincipal.ADODSUsuario.Close;
  DMPrincipal.ADODSUsuario.CommandText := 'select * from t_usuario';
  DMPrincipal.ADODSUsuario.Open;
end;

procedure TfrmCadUsuarios.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
end;

end.
