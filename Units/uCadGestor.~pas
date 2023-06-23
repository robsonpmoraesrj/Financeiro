unit uCadGestor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDM, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, Grids, DBGrids;

type
  TfrmCadGestor = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    edtProcurar: TEdit;
    dbnUsuarios: TDBNavigator;
    dbgUsuario: TDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    dbeNome: TDBEdit;
    btnExcluir: TBitBtn;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    dbeContato: TDBEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtProcurarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
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
  frmCadGestor: TfrmCadGestor;

implementation

{$R *.dfm}

procedure TfrmCadGestor.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSGestor.Open;
end;

procedure TfrmCadGestor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSGestor.Close;
  DMPrincipal.ADODSGestor.CommandText := 'select * from t_gestorinvestimento';
  Action := caFree;

  frmCadGestor := nil;
end;

procedure TfrmCadGestor.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
end;

procedure TfrmCadGestor.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DMPrincipal.ADODSGestor.Close;
  DMPrincipal.ADODSGestor.CommandText := 'select * from t_gestorinvestimento where dsc_gestor like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSGestor.Open;
end;

procedure TfrmCadGestor.BitBtn2Click(Sender: TObject);
begin
  Close;
  frmCadGestor := nil;
end;

procedure TfrmCadGestor.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSGestor.Open;
  DMPrincipal.ADODSGestor.Append;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.Enabled := true;
  dbeContato.Enabled := true;
  dbeNome.ReadOnly := false;
  dbeContato.ReadOnly := false;
  dbeNome.SetFocus;
end;

procedure TfrmCadGestor.btnSalvarClick(Sender: TObject);
begin
  DMPrincipal.ADODSGestor.Post;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeContato.ReadOnly := true;
  dbeNome.Enabled := false;
  dbeContato.Enabled := false;

  DMPrincipal.ADODSGestor.Close;
  DMPrincipal.ADODSGestor.CommandText := 'select * from t_gestorinvestimento';
  DMPrincipal.ADODSGestor.Open;
end;

procedure TfrmCadGestor.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSGestor.Open;
  DMPrincipal.ADODSGestor.Edit;

  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.Enabled := true;
  dbeContato.Enabled := true;
  dbeNome.ReadOnly := false;
  dbeContato.ReadOnly := false;
  dbeNome.SetFocus;
end;

procedure TfrmCadGestor.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSGestor.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeContato.ReadOnly := true;
  dbeNome.Enabled := false;
  dbeContato.Enabled := false;

  DMPrincipal.ADODSGestor.Close;
  DMPrincipal.ADODSGestor.CommandText := 'select * from t_gestorinvestimento';
  DMPrincipal.ADODSGestor.Open;
end;

procedure TfrmCadGestor.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSGestor.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSGestor.Delete;
  end;
end;

end.
