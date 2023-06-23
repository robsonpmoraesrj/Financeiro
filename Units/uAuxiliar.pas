unit uAuxiliar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, ImgList,
  Mask, DBActns, ActnList, DB, ADODB, uDM;
type
  TfrmAuxiliar = class(TForm)
    btnExecutar: TBitBtn;
    DBGrid1: TDBGrid;
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAuxiliar: TfrmAuxiliar;

implementation


{$R *.dfm}

procedure TfrmAuxiliar.btnExecutarClick(Sender: TObject);
var x,y,inicio,fim:integer;
begin
  x:=5;
  y:=x+1;
  inicio:=x+1;
  fim:=100+x;

  for y := inicio to fim do
  begin
    x:=x+y;
  end;

  edtX.Text:=inttostr(x);
  edtY.Text:=inttostr(y);
end;

end.
