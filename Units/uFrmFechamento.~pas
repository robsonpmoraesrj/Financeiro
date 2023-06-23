unit uFrmFechamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, uDM, DB, DBTables;

type
  TfrmFechamento = class(TForm)
    Panel1: TPanel;
    btnGerar: TBitBtn;
    btnSair: TBitBtn;
    lMensagem: TLabel;
    Label1: TLabel;
    medtCompetencia: TMaskEdit;
    Label2: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFechamento: TfrmFechamento;

implementation

{$R *.dfm}

procedure TfrmFechamento.btnSairClick(Sender: TObject);
begin
  Close;
  frmFechamento := nil;
end;

procedure TfrmFechamento.btnGerarClick(Sender: TObject);
var rError : boolean;
    sComp : string;
begin
  // Verificar se o fechamento do mês informado já foi efetuado...
  DMPrincipal.ADOQValidaComp.Close;
  DMPrincipal.ADOQValidaComp.Parameters.ParamByName('pdtcomp').Value := strtodatetime(medtCompetencia.Text);
  DMPrincipal.ADOQValidaComp.Open;
  if DMPrincipal.ADOQValidaComp.IsEmpty then
  begin

    if (medtCompetencia.Text = '  /  /    ') then
    begin
      messageDlg('Competência Inválida!', mtError, [mbOk],0);
      rError := true;
      medtCompetencia.SetFocus;
    end
    else
    begin
      DMPrincipal.ADOQFechamento.Close;
      DMPrincipal.ADOQFechamento.SQL.Clear;
      DMPrincipal.ADOQFechamento.SQL.Add('INSERT INTO T_FECHAMENTO (COD_INVESTIMENTO, COD_ATIVO, DSC_INVESTIMENTO, ');
      DMPrincipal.ADOQFechamento.SQL.Add('VLR_ALOCADO, VLR_ATUALIZADO, COD_PROPRIETARIO, COD_CARTEIRA, COD_STATUS, ');
      DMPrincipal.ADOQFechamento.SQL.Add('DAT_INICIO_INVESTIMENTO, DAT_FIM_INVESTIMENTO, DAT_ATUALIZACAO, DSC_OBSERVACAO, ');
      DMPrincipal.ADOQFechamento.SQL.Add('NRO_COTAS, COMPETENCIA, DAT_GERACAO) SELECT COD_INVESTIMENTO, COD_ATIVO, ');
      DMPrincipal.ADOQFechamento.SQL.Add('DSC_INVESTIMENTO, VLR_ALOCADO, VLR_ATUALIZADO, COD_PROPRIETARIO, COD_CARTEIRA, ');
      DMPrincipal.ADOQFechamento.SQL.Add('COD_STATUS, DAT_ABERTURA, DAT_VENCIMENTO, DAT_ATUALIZACAO, ');
      DMPrincipal.ADOQFechamento.SQL.Add('DSC_OBSERVACAO, NRO_COTAS, ' + chr(39) + formatdatetime('yyyy-mm-dd',strtodatetime(medtCompetencia.Text)) + chr(39) + ', getdate() FROM T_INVESTIMENTO ');

      rError := false;

      sComp:=copy(formatdatetime('dd/mm/yyyy',strtodatetime(medtCompetencia.Text)),4,7);

      if rError = false then
      begin
        try
          lMensagem.Visible := True;
          DMPrincipal.ADOQFechamento.ExecSQL;
          lMensagem.Caption := 'Fechamento da competência ' + sComp + ' finalizado com Sucesso!';
        except on e:econverterror
        do
          begin
            rError := true;
            lMensagem.Caption := 'Erro ao tentar gravar registro na tabela t_fechamento!';
          end;
        end;

      end;
    end;
  end
  else
  begin
    messageDlg('Competência Já Processada!', mtError, [mbOk],0);
    rError := true;
    medtCompetencia.SetFocus;
  end;

end;

procedure TfrmFechamento.FormActivate(Sender: TObject);
begin
  Label2.caption := 'Antes de efetuar o fechamento, deve-se atualizar todos os ativos';
  Label2.Enabled := true;
end;

procedure TfrmFechamento.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  shortdateformat := 'dd/mm/yyyy';

end;

end.
