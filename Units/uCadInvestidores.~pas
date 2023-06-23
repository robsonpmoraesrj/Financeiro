unit uCadInvestidores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  DBCtrls, uDM, Mask;

type
  TfrmCadInvestidores = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnFechar: TBitBtn;
    edtProcurar: TEdit;
    dbnInvestidor: TDBNavigator;
    dbgInvestidor: TDBGrid;
    Label3: TLabel;
    dbeNome: TDBEdit;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSalvar: TBitBtn;
    btnNovo: TBitBtn;
    btnExcluir: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtProcurarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadInvestidores: TfrmCadInvestidores;

implementation

{$R *.dfm}

procedure TfrmCadInvestidores.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSInvestidor.Open;
end;

procedure TfrmCadInvestidores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSInvestidor.Close;
  DMPrincipal.ADODSInvestidor.CommandText := 'select * from t_Proprietario';
  Action := caFree;

  frmCadInvestidores := nil;
end;

procedure TfrmCadInvestidores.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
end;

procedure TfrmCadInvestidores.btnFecharClick(Sender: TObject);
begin
  Close;
  frmCadInvestidores := nil;
end;

procedure TfrmCadInvestidores.edtProcurarKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  DMPrincipal.ADODSInvestidor.Close;
  DMPrincipal.ADODSInvestidor.CommandText := 'select * from t_proprietario where nom_proprietario like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSInvestidor.Open;
end;

procedure TfrmCadInvestidores.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSInvestidor.Append;
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

procedure TfrmCadInvestidores.btnSalvarClick(Sender: TObject);
begin
  DMPrincipal.ADODSInvestidor.Post;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  DMPrincipal.ADODSInvestidor.Close;
  DMPrincipal.ADODSInvestidor.CommandText := 'select * from t_proprietario';
  DMPrincipal.ADODSInvestidor.Open;
end;

procedure TfrmCadInvestidores.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSInvestidor.Edit;
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

procedure TfrmCadInvestidores.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSInvestidor.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSInvestidor.Delete;
  end;  
end;

procedure TfrmCadInvestidores.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSInvestidor.Cancel;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  DMPrincipal.ADODSInvestidor.Close;
  DMPrincipal.ADODSInvestidor.CommandText := 'select * from t_proprietario';
  DMPrincipal.ADODSInvestidor.Open;
end;

end.


