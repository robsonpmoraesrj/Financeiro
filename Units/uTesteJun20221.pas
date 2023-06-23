unit uTesteJun20221;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.formcreate(Sender: TObject);
var
  lista: tstringlist;
begin
  lista:=tstringlist.Create;
  lista.Add('Brasil');
  lista.Add('Venezuela');
  lista.Add('Chile');
  lista.Add('Uruguai');

  showmessage(lista.Strings[4])
end;

end.
 