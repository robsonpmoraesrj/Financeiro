unit uFiltroRelAtivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDM, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls, DB, ADODB, uQRAtivos;

type
  TfrmFiltroRelAtivos = class(TForm)
    Panel1: TPanel;
    dblkTipoInvest: TDBLookupComboBox;
    Label1: TLabel;
    dblkGestor: TDBLookupComboBox;
    Label2: TLabel;
    dblkAtivo: TDBLookupComboBox;
    Label3: TLabel;
    btnGerar: TBitBtn;
    dbtLimpar: TBitBtn;
    btnSair: TBitBtn;
    GroupBox1: TGroupBox;
    mskeAberturaI: TMaskEdit;
    mskeAberturaF: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    mskeVenctoI: TMaskEdit;
    mskeVenctoF: TMaskEdit;
    procedure FormActivate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbtLimparClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskeAberturaIExit(Sender: TObject);
    procedure mskeAberturaFExit(Sender: TObject);
    procedure mskeVenctoIExit(Sender: TObject);
    procedure mskeVenctoFExit(Sender: TObject);
  private
    { Private declarations }
    qrRelAtivos : TqrRelAtivos;
  public
    { Public declarations }
  end;

var
  frmFiltroRelAtivos: TfrmFiltroRelAtivos;
  dDataAberturaI, dDataAberturaF, dDataVenctoI, dDataVenctoF : string;

implementation

{$R *.dfm}

procedure TfrmFiltroRelAtivos.FormActivate(Sender: TObject);
begin
  DMPrincipal.ADODSTipInvest.Open;
  DMPrincipal.ADODSGestor.Open;
  DMPrincipal.ADODSAtivo.Open;
  DMPrincipal.ADODSStatus.Open;

  mskeAberturaI.Enabled := true;
  mskeAberturaF.Enabled := true;
  mskeVenctoI.Enabled := true;
  mskeVenctoF.Enabled := true;
end;

procedure TfrmFiltroRelAtivos.btnSairClick(Sender: TObject);
begin
  Close;
  frmFiltroRelAtivos := nil;
end;

procedure TfrmFiltroRelAtivos.dbtLimparClick(Sender: TObject);
begin
  dblkTipoInvest.KeyValue := -1;
  dblkGestor.KeyValue := -1;
  dblkAtivo.KeyValue := -1;
  mskeAberturaI.Text := '';
  mskeAberturaF.Text := '';
  mskeVenctoI.Text := '';
  mskeVenctoF.Text := '';
end;

procedure TfrmFiltroRelAtivos.btnGerarClick(Sender: TObject);
  var relAtivos : TqrRelAtivos;
  rError : boolean;
begin
  rError := false;
  DMPrincipal.ADOQAtivo.Close;
  DMPrincipal.ADOQAtivo.SQL.Clear;
  DMPrincipal.ADOQAtivo.SQL.Add('select ta.*, tg.*, ti.*, tc.* ');
  DMPrincipal.ADOQAtivo.SQL.Add('from t_ativo ta, ');
  DMPrincipal.ADOQAtivo.SQL.Add('t_gestorinvestimento tg, ');
  DMPrincipal.ADOQAtivo.SQL.Add('t_tipoinvestimento ti, ');
  DMPrincipal.ADOQAtivo.SQL.Add('t_caracteristica tc ');
  DMPrincipal.ADOQAtivo.SQL.Add('where ta.cod_gestor = tg.cod_gestor ');
  DMPrincipal.ADOQAtivo.SQL.Add('and ta.cod_tipoinvestimento = ti.cod_tipoinvestimento ');
  DMPrincipal.ADOQAtivo.SQL.Add('and ti.cod_caracteristica = tc.cod_caracteristica ');

  // Filtro por GESTOR...
  if dblkGestor.Text <> '' then
  begin
    //DMPrincipal.ADOQAtivo.SQL.Add('and ta.cod_gestor = :pCodigo1 ');
    //DMPrincipal.ADOQAtivo.Parameters.ParamByName('pCodigo1').Value := dblkGestor.keyValue;
    DMPrincipal.ADOQAtivo.SQL.Add('and ta.cod_gestor = ' + quotedstr(dblkGestor.KeyValue));
  end;

  // Filtro por TIPO DE INVESTIMENTO...
  if dblkTipoInvest.Text <> '' then
  begin
    DMPrincipal.ADOQAtivo.SQL.Add('and ta.cod_tipoinvestimento = ' + quotedstr(dblkTipoInvest.KeyValue));
  end;

  // Filtro por ATIVO...
  if dblkAtivo.Text <> '' then
  begin
    DMPrincipal.ADOQAtivo.SQL.Add('and ta.cod_ativo = ' + quotedstr(dblkAtivo.KeyValue));
  end;

  if ((mskeAberturaI.Text <> '  /  /    ') and (mskeVenctoI.Text <> '  /  /    ')) then
  begin
    if (strtodate(mskeAberturaI.Text) > strtodate(mskeVenctoI.Text)) then
    begin
      messageDlg('Intervalo de datas Inv�lido!', mtError, [mbOk],0);
      rError := true;
      mskeAberturaI.SetFocus;
      //Abort;
    end;
  end
  else
  begin
    if ((mskeAberturaI.Text <> '  /  /    ') and (mskeVenctoF.Text <> '  /  /    ')) then
    begin
      if (strtodate(mskeAberturaI.Text) > strtodate(mskeVenctoF.Text)) then
      begin
        messageDlg('Intervalo de datas Inv�lido!', mtError, [mbOk],0);
        rError := true;
        mskeAberturaI.SetFocus;
      end;
    end
    else
    begin
      if ((mskeAberturaF.Text <> '  /  /    ') and (mskeVenctoI.Text <> '  /  /    ')) then
      begin
        if (strtodate(mskeAberturaF.Text) > strtodate(mskeVenctoI.Text)) then
        begin
          messageDlg('Intervalo de datas Inv�lido!', mtError, [mbOk],0);
          rError := true;
          mskeAberturaI.SetFocus;
        end;
      end
      else
      begin
        if ((mskeAberturaF.Text <> '  /  /    ') and (mskeVenctoF.Text <> '  /  /    ')) then
        begin
          if (strtodate(mskeAberturaF.Text) > strtodate(mskeVenctoF.Text)) then
          begin
            messageDlg('Intervalo de datas Inv�lido!', mtError, [mbOk],0);
            rError := true;
            mskeAberturaI.SetFocus;
          end;
        end;
      end;
    end;
  end;

  // Filtro por DATA DE ABERTURA...
  if mskeAberturaI.Text <> '  /  /    ' then
  begin
    if mskeAberturaF.Text <> '  /  /    ' then
    begin
      // Valida DATAS...
      if mskeAberturaI.Text > mskeAberturaF.Text then
      begin
        messageDlg('Data de Abertura Inv�lida!', mtError, [mbOk],0);
        rError := true;
        mskeAberturaI.SetFocus;
      end
      else
      begin
        dDataAberturaI := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaI.Text));
        dDataAberturaF := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaF.Text));
        DMPrincipal.ADOQAtivo.SQL.Add('and ta.dat_abertura between ' + quotedstr(dDataAberturaI) +  ' and ' + quotedstr(dDataAberturaF));
      end;
    end
    else
    begin
      dDataAberturaI := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaI.Text));
      DMPrincipal.ADOQAtivo.SQL.Add('and ta.dat_abertura >= ' + quotedstr(dDataAberturaI));
    end;
  end
  else
  begin
    if mskeAberturaF.Text <> '  /  /    ' then
    begin
      dDataAberturaF := formatdatetime('yyyy/mm/dd', strtodate(mskeAberturaF.Text));
      DMPrincipal.ADOQAtivo.SQL.Add('and ta.dat_abertura <= ' + quotedstr(dDataAberturaF));
    end;
  end;

  // Filtro por DATA DE VENCIMENTO...
  if mskeVenctoI.Text <> '  /  /    ' then
  begin
    if mskeVenctoF.Text <> '  /  /    ' then
    begin
      if mskeVenctoI.Text > mskeVenctoF.Text then
      begin
        messageDlg('Data de Vencimento Inv�lida!', mtError, [mbOk],0);
        rError := true;
        mskeVenctoI.SetFocus;
      end
      else
      begin
        dDataVenctoI := formatdatetime('yyyy/mm/dd', strtodate(mskeVenctoI.Text));
        dDataVenctoF := formatdatetime('yyyy/mm/dd', strtodate(mskeVenctoF.Text));
        DMPrincipal.ADOQAtivo.SQL.Add('and ta.dat_vencimento between ' + quotedstr(dDataVenctoI) +  ' and ' + quotedstr(dDataVenctoF));
      end;
    end
    else
    begin
      dDataVenctoI := formatdatetime('yyyy/mm/dd', strtodate(mskeVenctoI.Text));
      DMPrincipal.ADOQAtivo.SQL.Add('and ta.dat_vencimento >= ' + quotedstr(dDataVenctoI));
    end;
  end
  else
  begin
    if mskeVenctoF.Text <> '  /  /    ' then
    begin
      dDataVenctoF := formatdatetime('yyyy/mm/dd', strtodate(mskeVenctoF.Text));
      DMPrincipal.ADOQAtivo.SQL.Add('and ta.dat_vencimento <= ' + quotedstr(dDataVenctoF));
    end;
  end;

  DMPrincipal.ADOQAtivo.SQL.Add('order by ta.nom_ativo');

  if rError = false then
  begin
    DMPrincipal.ADOQAtivo.Open;

    relAtivos := TqrRelAtivos.Create(Self);
    relAtivos.Preview;
    relAtivos.Free;
  end;
end;

procedure TfrmFiltroRelAtivos.FormCreate(Sender: TObject);
begin
  Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYSCREEN) - Height) div 2;

  shortdateformat := 'dd/mm/yyyy';
end;

procedure TfrmFiltroRelAtivos.mskeAberturaIExit(Sender: TObject);
begin
  if mskeAberturaI.Text <> '  /  /    ' then
  begin
    try
      datetostr(StrToDate(mskeAberturaI.Text));
    except
      on EConvertError do
      begin
        messageDlg('Data Inv�lida!', mtError, [mbOk],0);
        //mskeAberturaI.SetFocus;
        Abort;
      end;
    end;
  end;
end;

procedure TfrmFiltroRelAtivos.mskeAberturaFExit(Sender: TObject);
begin
  if mskeAberturaF.Text <> '  /  /    ' then
  begin
    try
      datetostr(StrToDate(mskeAberturaF.Text));
    except
      on EConvertError do
      begin
        messageDlg('Data Inv�lida!', mtError, [mbOk],0);
        //mskeAberturaF.SetFocus;
        Abort;
      end;
    end;
  end;
end;

procedure TfrmFiltroRelAtivos.mskeVenctoIExit(Sender: TObject);
begin
  if mskeVenctoI.Text <> '  /  /    ' then
  begin
    try
      datetostr(StrToDate(mskeVenctoI.Text));
    except
      on EConvertError do
      begin
        messageDlg('Data Inv�lida!', mtError, [mbOk],0);
        //mskeVenctoI.SetFocus;
        Abort;
      end;
    end;
  end;
end;

procedure TfrmFiltroRelAtivos.mskeVenctoFExit(Sender: TObject);
begin
  if mskeVenctoF.Text <> '  /  /    ' then
  begin
    try
      datetostr(StrToDate(mskeVenctoF.Text));
    except
      on EConvertError do
      begin
        messageDlg('Data Inv�lida!', mtError, [mbOk],0);
        //mskeVenctoF.SetFocus;
        Abort;
      end;
    end;
  end;
end;

end.
