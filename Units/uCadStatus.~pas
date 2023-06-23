unit uCadStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, uDM;

type
  TfrmCadStatus = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    edtProcurar: TEdit;
    dbnStstus: TDBNavigator;
    dbgStstus: TDBGrid;
    Label3: TLabel;
    dbeNome: TDBEdit;
    btnExcluir: TBitBtn;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
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
  frmCadStatus: TfrmCadStatus;

implementation

uses uCadGestor;

{$R *.dfm}

procedure TfrmCadStatus.BitBtn2Click(Sender: TObject);
begin
  Close;
  frmCadGestor := nil;
end;

procedure TfrmCadStatus.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSStatus.Open;
end;

procedure TfrmCadStatus.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSStatus.Close;
  DMPrincipal.ADODSStatus.CommandText := 'select * from t_status';
  Action := caFree;

  frmCadStatus := nil;
end;

procedure TfrmCadStatus.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
end;

procedure TfrmCadStatus.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DMPrincipal.ADODSStatus.Close;
  DMPrincipal.ADODSStatus.CommandText := 'select * from t_status where dsc_status like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSStatus.Open;
end;

procedure TfrmCadStatus.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSStatus.Open;
  DMPrincipal.ADODSStatus.Append;
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

procedure TfrmCadStatus.btnSalvarClick(Sender: TObject);
begin
  DMPrincipal.ADODSStatus.Post;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeNome.Enabled := false;

  DMPrincipal.ADODSStatus.Close;
  DMPrincipal.ADODSStatus.CommandText := 'select * from t_status';
  DMPrincipal.ADODSStatus.Open;
end;

procedure TfrmCadStatus.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSStatus.Open;
  DMPrincipal.ADODSStatus.Edit;

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

procedure TfrmCadStatus.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSStatus.Cancel;

  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeNome.Enabled := false;

  DMPrincipal.ADODSStatus.Close;
  DMPrincipal.ADODSStatus.CommandText := 'select * from t_status';
  DMPrincipal.ADODSStatus.Open;
end;

procedure TfrmCadStatus.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSStatus.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSStatus.Delete;
  end;  
end;

end.
