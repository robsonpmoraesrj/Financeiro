unit uMsgConectado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, uMenuPrincipal, uDM, Buttons, jpeg,
  ExtCtrls;

type
  TfrmTesteConexao = class(TForm)
    ADOConnection1: TADOConnection;
    GroupBox1: TGroupBox;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    btnSaiSistema: TBitBtn;
    btnLoga: TBitBtn;
    Image1: TImage;
    procedure btnSaiSistemaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnLogaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtSenhaExit(Sender: TObject);
  private
    { Private declarations }
    frmMenuPrincipal : TfrmMenuPrincipal;
    uDM : TDMPrincipal;
    tentativas : Smallint;
    function loginValido(const usuario, senha: String):boolean;
  public
    { Public declarations }
  end;

var
  frmTesteConexao: TfrmTesteConexao;
  teste : string;

implementation

uses uCadUsuarios;

{$R *.dfm}

function TfrmTesteConexao.loginValido(const usuario, senha : String) : Boolean;
  begin

  with DMPrincipal.ConLOGIN2, DMPrincipal.datasetAux2 do
  begin
    if not Connected then //Caso o componente ConLOGIN n�o esteja conectado ao BD
      Connected := True;
    Close;
    CommandText := 'SELECT COUNT(1) FROM T_USUARIO ' +
    ' WHERE UPPER(USU_NOME) = ' + QuotedStr(AnsiUpperCase(Trim(usuario))) +
    ' AND USU_SENHA = ' + QuotedStr(Trim(senha));
    Open;
    Result := (Fields[0].AsInteger > 0);
    teste:=usuario;
  end;
end;

procedure TfrmTesteConexao.btnSaiSistemaClick(Sender: TObject);
begin
  Close;
  frmTesteConexao := nil;
end;

procedure TfrmTesteConexao.FormActivate(Sender: TObject);
begin
  edtUsuario.Enabled := true;
  edtusuario.ReadOnly := false;
  edtUsuario.SetFocus;
end;

procedure TfrmTesteConexao.btnLogaClick(Sender: TObject);
begin
  try

  if (edtUsuario.Text = '') then //Verifica se o campo "Usu�rio" foi preenchido
  begin
    Messagedlg('O campo "Usu�rio" deve ser preenchido!', mtInformation, [mbOk], 0);
    if edtUsuario.CanFocus then
      edtUsuario.SetFocus;
    Exit;
  end;

  if (edtSenha.Text = '') then //Verifica se o campo "Senha" foi preenchido
  begin
    Messagedlg('O campo "Senha" deve ser preenchido!', mtInformation, [mbOk], 0);
    if edtSenha.CanFocus then
      edtSenha.SetFocus;
    Exit;
  end;

  if loginValido(edtUsuario.Text, edtSenha.Text) then //Verifica se o login � v�lido
  begin
    ModalResult := mrOk;

    //showMessage('CONECTADO!');

    if frmMenuPrincipal = nil then
    begin
      frmMenuPrincipal := TfrmMenuPrincipal.Create(Self); //* cria inst�ncia *//
      frmMenuPrincipal.ShowModal; //* cria o formul�rio *//
      frmMenuPrincipal.Destroy; //* destroi o formul�rio *//
    end;
  end
  
  else //Caso o login n�o seja v�lido ent�o
  begin
    inc(tentativas); //Incrementa em 1 o valor da vari�vel tentativas

    if tentativas < 3 then
    begin
      MessageDlg(Format('Tentativa %d de 3', [tentativas]), mtError, [mbOk], 0);

      if edtSenha.CanFocus then
        edtSenha.SetFocus;
        
    end
    else
    begin
      MessageDlg(Format('%d� tentativa de acesso ao sistema.',
        [tentativas]) + #13 + 'A aplica��o ser� fechada!', mtError, [mbOk], 0);
      ModalResult := mrCancel;
    end;
  end;

  except
    on e: Exception do
      showMessage(e.Message);
  end;

end;

procedure TfrmTesteConexao.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;
  edtUsuario.Enabled := true;
  edtSenha.Enabled := true;
end;

procedure TfrmTesteConexao.edtSenhaExit(Sender: TObject);
begin
  btnLoga.SetFocus;
end;

end.
