object frmAuxiliar: TfrmAuxiliar
  Left = 197
  Top = 205
  Width = 1077
  Height = 467
  Caption = 'frmAuxiliar'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnExecutar: TBitBtn
    Left = 384
    Top = 368
    Width = 75
    Height = 25
    Caption = 'EXECUTAR'
    TabOrder = 0
    OnClick = btnExecutarClick
  end
  object DBGrid1: TDBGrid
    Left = 48
    Top = 80
    Width = 985
    Height = 120
    DataSource = DMPrincipal.DSUsuario
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'usu_id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'usu_nome'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'usu_senha'
        Visible = True
      end>
  end
end
