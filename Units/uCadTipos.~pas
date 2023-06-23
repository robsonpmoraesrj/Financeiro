unit uCadTipos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, Grids, DBGrids, uDM;

type
  TfrmCadTipos = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btnSair: TBitBtn;
    edtProcurar: TEdit;
    dbnCarteira: TDBNavigator;
    dbgTipos: TDBGrid;
    Label2: TLabel;
    dbeNome: TDBEdit;
    Label4: TLabel;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    Label3: TLabel;
    dbeDescricao: TDBEdit;
    dblcbCaracteristica: TDBLookupComboBox;
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
  frmCadTipos: TfrmCadTipos;

implementation

{$R *.dfm}

procedure TfrmCadTipos.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSCaracteristica.Open;
  DMPrincipal.ADODSTipInvest.Open;
  DMPrincipal.ADODSInvestidor.Open;

  dbeNome.Enabled := false;
  dblcbCaracteristica.Enabled := false;
  dblcbCaracteristica.ReadOnly := true;
  dbeDescricao.Enabled := false;
end;

procedure TfrmCadTipos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMPrincipal.ADODSTipInvest.Close;
  DMPrincipal.ADODSTipInvest.CommandText := 'select * from t_tipoinvestimento';
  Action := caFree;

  frmCadTipos := nil;
end;

procedure TfrmCadTipos.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtProcurar.Enabled := true;
end;

procedure TfrmCadTipos.edtProcurarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DMPrincipal.ADODSTipInvest.Close;
  DMPrincipal.ADODSTipInvest.CommandText := 'select * from t_tipoinvestimento where dsc_tipoinvestimento like ' + #39 + edtProcurar.Text + '%' + #39;
  DMPrincipal.ADODSTipInvest.Open;
end;

procedure TfrmCadTipos.btnSairClick(Sender: TObject);
begin
  Close;
  frmCadTipos := nil;
end;

procedure TfrmCadTipos.btnNovoClick(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Append;

  {
  try
      DMPrincipal.ADODSTipInvest.Append;



      //ShowMessage('Operação efetuada com sucesso!');

    except
      on E:exception do
        begin
          //ShowMessage('Erro ao inserir registro');
          exit;
        end;
    end;
  }






  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.ReadOnly := false;
  dbeNome.Enabled:= true;
  dblcbCaracteristica.ReadOnly := false;
  dblcbCaracteristica.Enabled:= true;
  dbeDescricao.ReadOnly := false;
  dbeDescricao.Enabled := true;

  dbeNome.SetFocus;
end;

procedure TfrmCadTipos.btnSalvarClick(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Post;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeNome.Enabled:= false;
  dblcbCaracteristica.ReadOnly := true;
  dblcbCaracteristica.Enabled:= false;
  dbeDescricao.ReadOnly := true;
  dbeDescricao.Enabled := false;

  DMPrincipal.ADODSTipInvest.Close;
  DMPrincipal.ADODSTipInvest.CommandText := 'select * from t_tipoinvestimento';
  DMPrincipal.ADODSTipInvest.Open;
end;

procedure TfrmCadTipos.btnAlterarClick(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Open;
  DMPrincipal.ADODSTipInvest.Edit;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;

  edtProcurar.Enabled := false;

  dbeNome.ReadOnly := false;
  dbeNome.Enabled:= true;
  dblcbCaracteristica.ReadOnly := false;
  dblcbCaracteristica.Enabled:= true;
  dbeDescricao.ReadOnly := false;
  dbeDescricao.Enabled := true;

  dbeNome.SetFocus;
end;

procedure TfrmCadTipos.btnCancelarClick(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Cancel;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := true;
  btnNovo.Enabled := true;
  btnExcluir.Enabled := true;

  edtProcurar.Enabled := true;

  dbeNome.ReadOnly := true;
  dbeNome.Enabled:= false;
  dblcbCaracteristica.ReadOnly := true;
  dblcbCaracteristica.Enabled:= false;
  dbeDescricao.ReadOnly := true;
  dbeDescricao.Enabled := false;

  DMPrincipal.ADODSTipInvest.Close;
  DMPrincipal.ADODSTipInvest.CommandText := 'select * from t_tipoinvestimento';
  DMPrincipal.ADODSTipInvest.Open;
end;

procedure TfrmCadTipos.btnExcluirClick(Sender: TObject);
begin
  if messageDlg('Esta operação não poderá ser desfeita. Prosseguir',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    messageDlg('Excluido ' + DMPrincipal.ADODSTipInvest.Fields[1].asString, mtInformation, [mbOk], 0);
    DMPrincipal.ADODSTipInvest.Delete;
  end;
end;

end.
