unit uCadCarteiras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDM, Mask, DBCtrls, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons;

type
  TfrmCadCarteiras = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnSair: TBitBtn;
    edtProcurar: TEdit;
    dbnCarteira: TDBNavigator;
    dbgCarteira: TDBGrid;
    Label2: TLabel;
    dbeNomeCarteira: TDBEdit;
    Label3: TLabel;
    dbeAbertura: TDBEdit;
    edtInvestidor: TLabel;
    dblcbInvestidor: TDBLookupComboBox;
    edtStatus: TLabel;
    dblcbStatus: TDBLookupComboBox;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
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
  frmCadCarteiras: TfrmCadCarteiras;

implementation

uses uCadAlocacoes;

{$R *.dfm}

procedure TfrmCadCarteiras.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSCarteira.Open;
  DMPrincipal.ADODSInvestidor.Open;
  DMPrincipal.ADODSStatus.Open;

  dbeNomeCarteira.Enabled := false;
  dbeAbertura.Enabled := false;
  dblcbInvestidor.Enabled := false;
  dblcbStatus.Enabled := false;

  dblcbInvestidor.readOnly := true;
  dblcbInvestidor.Enabled := false;
  dblcbStatus.readOnly := true;
  dblcbStatus.Enabled := false;
end;

procedure TfrmCadCarteiras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSInvestidor.Close;
  DMPrincipal.ADODSStatus.Close;

  DMPrincipal.ADODSCarteira.Close;
  DMPrincipal.ADODSCarteira.CommandText := 'select * from t_carteira';
  Action := caFree;

  frmCadCarteiras := nil;
end;

procedure TfrmCadCarteiras.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
end;

procedure TfrmCadCarteiras.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadCarteiras := nil;
end;

procedure TfrmCadCarteiras.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DMPrincipal.ADODSCarteira.Close;
  DMPrincipal.ADODSCarteira.CommandText := 'select * from t_carteira where nom_carteira like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSCarteira.Open;
end;

procedure TfrmCadCarteiras.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSCarteira.Open;
  DMPrincipal.ADODSCarteira.Append;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNomeCarteira.ReadOnly := false;
  dbeNomeCarteira.Enabled:= true;
  dbeAbertura.ReadOnly := false;
  dbeAbertura.Enabled := true;

  //DMPrincipal.ADODSCarteira.FieldByName('dat_criacao').AsDateTime:=now;
  dbeAbertura.Text := DateToStr(Date());

  dblcbInvestidor.readOnly := false;
  dblcbInvestidor.Enabled := true;
  dblcbStatus.readOnly := false;
  dblcbStatus.Enabled := true;
  dbeNomeCarteira.SetFocus;
end;

procedure TfrmCadCarteiras.btnSalvarClick(Sender: TObject);
begin
  DMPrincipal.ADODSCarteira.Post;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNomeCarteira.ReadOnly := true;
  dbeNomeCarteira.Enabled:= false;
  dbeAbertura.ReadOnly := true;
  dbeAbertura.Enabled := false;

  dblcbInvestidor.readOnly := true;
  dblcbInvestidor.Enabled := false;
  dblcbStatus.readOnly := true;
  dblcbStatus.Enabled := false;

  DMPrincipal.ADODSCarteira.Close;
  DMPrincipal.ADODSCarteira.CommandText := 'select * from t_carteira';
  DMPrincipal.ADODSCarteira.Open;
end;

procedure TfrmCadCarteiras.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSCarteira.Open;
  DMPrincipal.ADODSCarteira.Edit;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNomeCarteira.ReadOnly := false;
  dbeNomeCarteira.Enabled:= true;
  dbeAbertura.ReadOnly := false;
  dbeAbertura.Enabled := true;

  dblcbInvestidor.readOnly := false;
  dblcbInvestidor.Enabled := true;
  dblcbStatus.readOnly := false;
  dblcbStatus.Enabled := true;
  dbeNomeCarteira.SetFocus;
end;

procedure TfrmCadCarteiras.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSCarteira.Cancel;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNomeCarteira.ReadOnly := true;
  dbeNomeCarteira.Enabled:= false;
  dbeAbertura.ReadOnly := true;
  dbeAbertura.Enabled := false;

  dblcbInvestidor.readOnly := true;
  dblcbInvestidor.Enabled := false;
  dblcbStatus.readOnly := true;
  dblcbStatus.Enabled := false;

  DMPrincipal.ADODSCarteira.Close;
  DMPrincipal.ADODSCarteira.CommandText := 'select * from t_carteira';
  DMPrincipal.ADODSCarteira.Open;
end;

procedure TfrmCadCarteiras.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSCarteira.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSCarteira.Delete;
  end;
end;

end.
