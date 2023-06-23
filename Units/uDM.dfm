object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  Left = 196
  Top = 148
  Height = 631
  Width = 1140
  object ConLOGIN1: TADOConnection
    ConnectionString = 
      'FILE NAME=C:\USUARIOS\Robson\Projetos-Delphi\Financeiro\DBFINANC' +
      'EIRO.udl.txt;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'MSDASQL.1'
    Left = 976
    Top = 16
  end
  object datasetAux2: TADODataSet
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_ativo'
    Parameters = <>
    Left = 992
    Top = 88
  end
  object ADODSUsuario: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_usuario order by usu_nome'
    Parameters = <>
    Left = 40
    Top = 16
    object ADODSUsuariousu_id: TIntegerField
      FieldName = 'usu_id'
    end
    object ADODSUsuariousu_nome: TStringField
      FieldName = 'usu_nome'
      Size = 40
    end
    object ADODSUsuariousu_senha: TStringField
      FieldName = 'usu_senha'
      Size = 30
    end
  end
  object DSUsuario: TDataSource
    DataSet = ADODSUsuario
    Left = 40
    Top = 72
  end
  object ADODSInvestidor: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_proprietario order by nom_proprietario'
    Parameters = <>
    Left = 136
    Top = 16
    object ADODSInvestidorcod_proprietario: TAutoIncField
      FieldName = 'cod_proprietario'
      ReadOnly = True
    end
    object ADODSInvestidornom_proprietario: TStringField
      FieldName = 'nom_proprietario'
      Size = 60
    end
  end
  object DSInvestidor: TDataSource
    DataSet = ADODSInvestidor
    Left = 136
    Top = 72
  end
  object DSAlocacao: TDataSource
    DataSet = ADODSAlocacao
    Left = 236
    Top = 72
  end
  object ADODSAlocacao: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 
      'select * from t_investimento where cod_status in (1,3) order by ' +
      'cod_carteira, dat_atualizacao desc'#13#10#13#10'--select * from t_investim' +
      'ento order by dsc_investimento'
    Parameters = <>
    Left = 232
    Top = 16
    object ADODSAlocacaocod_investimento: TAutoIncField
      FieldName = 'cod_investimento'
      ReadOnly = True
    end
    object ADODSAlocacaodsc_investimento: TStringField
      FieldName = 'dsc_investimento'
      Size = 60
    end
    object ADODSAlocacaocod_proprietario: TIntegerField
      FieldName = 'cod_proprietario'
    end
    object ADODSAlocacaocod_carteira: TIntegerField
      FieldName = 'cod_carteira'
    end
    object ADODSAlocacaocod_status: TIntegerField
      FieldName = 'cod_status'
    end
    object ADODSAlocacaocod_tipoinvestimento: TIntegerField
      FieldName = 'cod_tipoinvestimento'
    end
    object ADODSAlocacaodat_abertura: TDateTimeField
      FieldName = 'dat_abertura'
    end
    object ADODSAlocacaodat_vencimento: TDateTimeField
      FieldName = 'dat_vencimento'
    end
    object ADODSAlocacaocod_ativo: TIntegerField
      FieldName = 'cod_ativo'
    end
    object ADODSAlocacaovlr_alocado: TBCDField
      FieldName = 'vlr_alocado'
      Precision = 14
      Size = 2
    end
    object ADODSAlocacaovlr_atualizado: TBCDField
      FieldName = 'vlr_atualizado'
      Precision = 14
      Size = 2
    end
    object ADODSAlocacaodat_atualizacao: TDateTimeField
      FieldName = 'dat_atualizacao'
    end
    object ADODSAlocacaodsc_observacao: TStringField
      FieldName = 'dsc_observacao'
      Size = 60
    end
    object ADODSAlocacaonro_cotas: TBCDField
      FieldName = 'nro_cotas'
      DisplayFormat = '#######0.00'
      EditFormat = '#######0.00'
      Precision = 10
      Size = 2
    end
    object ADODSAlocacaoInvestidor: TStringField
      FieldKind = fkLookup
      FieldName = 'Investidor'
      LookupDataSet = ADODSInvestidor
      LookupKeyFields = 'cod_proprietario'
      LookupResultField = 'nom_proprietario'
      KeyFields = 'cod_proprietario'
      Lookup = True
    end
    object ADODSAlocacaoSituacao: TStringField
      FieldKind = fkLookup
      FieldName = 'Situacao'
      LookupDataSet = ADODSStatus
      LookupKeyFields = 'cod_status'
      LookupResultField = 'dsc_status'
      KeyFields = 'cod_status'
      Lookup = True
    end
    object ADODSAlocacaoTipo: TStringField
      FieldKind = fkLookup
      FieldName = 'Tipo'
      LookupDataSet = ADODSTipInvest
      LookupKeyFields = 'cod_tipoinvestimento'
      LookupResultField = 'dsc_tipoinvestimento'
      KeyFields = 'cod_tipoinvestimento'
      Lookup = True
    end
    object ADODSAlocacaoCarteira: TStringField
      FieldKind = fkLookup
      FieldName = 'Carteira'
      LookupDataSet = ADODSCarteira
      LookupKeyFields = 'cod_carteira'
      LookupResultField = 'nom_carteira'
      KeyFields = 'cod_carteira'
      Lookup = True
    end
  end
  object ADODSTipInvest: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_tipoinvestimento order by dsc_tipoinvestimento'
    Parameters = <>
    Left = 344
    Top = 16
    object ADODSTipInvestcod_tipoinvestimento: TAutoIncField
      FieldName = 'cod_tipoinvestimento'
      ReadOnly = True
    end
    object ADODSTipInvestdsc_tipoinvestimento: TStringField
      FieldName = 'dsc_tipoinvestimento'
      Size = 60
    end
    object ADODSTipInvestcod_caracteristica: TIntegerField
      FieldName = 'cod_caracteristica'
    end
    object ADODSTipInvestdsc_caracteristica: TStringField
      FieldName = 'dsc_caracteristica'
      Size = 60
    end
  end
  object ADODSStatus: TADODataSet
    Active = True
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_status order by dsc_status'
    Parameters = <>
    Left = 440
    Top = 16
    object ADODSStatuscod_status: TAutoIncField
      FieldName = 'cod_status'
      ReadOnly = True
    end
    object ADODSStatusdsc_status: TStringField
      FieldName = 'dsc_status'
      Size = 30
    end
  end
  object ADODSGestor: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_gestorinvestimento order by dsc_gestor'
    Parameters = <>
    Left = 528
    Top = 16
    object ADODSGestorcod_gestor: TAutoIncField
      FieldName = 'cod_gestor'
      ReadOnly = True
    end
    object ADODSGestordsc_gestor: TStringField
      DisplayWidth = 60
      FieldName = 'dsc_gestor'
      Size = 60
    end
    object ADODSGestorcto_gestor: TStringField
      DisplayWidth = 40
      FieldName = 'cto_gestor'
      Size = 40
    end
  end
  object DSTipInvest: TDataSource
    DataSet = ADODSTipInvest
    Left = 344
    Top = 72
  end
  object DSStatus: TDataSource
    DataSet = ADODSStatus
    Left = 440
    Top = 72
  end
  object DSGestor: TDataSource
    DataSet = ADODSGestor
    Left = 528
    Top = 72
  end
  object ADODSCarteira: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_carteira order by nom_carteira'
    Parameters = <>
    Left = 608
    Top = 16
    object ADODSCarteiracod_carteira: TAutoIncField
      FieldName = 'cod_carteira'
      ReadOnly = True
    end
    object ADODSCarteiranom_carteira: TStringField
      FieldName = 'nom_carteira'
      Size = 40
    end
    object ADODSCarteiradat_criacao: TDateTimeField
      FieldName = 'dat_criacao'
    end
    object ADODSCarteiracod_proprietario: TIntegerField
      FieldName = 'cod_proprietario'
    end
    object ADODSCarteiracod_status: TIntegerField
      FieldName = 'cod_status'
    end
    object ADODSCarteiraStatus: TStringField
      FieldKind = fkLookup
      FieldName = 'Status'
      LookupDataSet = ADODSStatus
      LookupKeyFields = 'cod_status'
      LookupResultField = 'dsc_status'
      KeyFields = 'cod_status'
      Size = 15
      Lookup = True
    end
    object ADODSCarteiraInvestidor: TStringField
      FieldKind = fkLookup
      FieldName = 'Investidor'
      LookupDataSet = ADODSInvestidor
      LookupKeyFields = 'cod_proprietario'
      LookupResultField = 'nom_proprietario'
      KeyFields = 'cod_proprietario'
      Size = 30
      Lookup = True
    end
  end
  object DSCarteira: TDataSource
    DataSet = ADODSCarteira
    Left = 608
    Top = 72
  end
  object ADODSAtivo: TADODataSet
    Active = True
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_ativo order by nom_ativo'
    Parameters = <>
    Left = 688
    Top = 16
    object ADODSAtivocod_ativo: TAutoIncField
      FieldName = 'cod_ativo'
      ReadOnly = True
    end
    object ADODSAtivonom_ativo: TStringField
      FieldName = 'nom_ativo'
      Size = 60
    end
    object ADODSAtivocod_caracteristica: TIntegerField
      FieldName = 'cod_caracteristica'
    end
    object ADODSAtivodsc_caracteristicaativo: TStringField
      FieldName = 'dsc_caracteristicaativo'
      Size = 60
    end
    object ADODSAtivocod_tipoinvestimento: TIntegerField
      FieldName = 'cod_tipoinvestimento'
    end
    object ADODSAtivodat_abertura: TDateTimeField
      FieldName = 'dat_abertura'
    end
    object ADODSAtivodat_vencimento: TDateTimeField
      FieldName = 'dat_vencimento'
    end
    object ADODSAtivocod_gestor: TIntegerField
      FieldName = 'cod_gestor'
    end
  end
  object DSAtivo: TDataSource
    DataSet = ADODSAtivo
    Left = 688
    Top = 72
  end
  object ADODSCaracteristica: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_caracteristica order by dsc_caracteristica'
    Parameters = <>
    Left = 776
    Top = 16
    object ADODSCaracteristicacod_caracteristica: TAutoIncField
      FieldName = 'cod_caracteristica'
      ReadOnly = True
    end
    object ADODSCaracteristicadsc_caracteristica: TStringField
      FieldName = 'dsc_caracteristica'
      Size = 60
    end
  end
  object DSCaracteristica: TDataSource
    DataSet = ADODSCaracteristica
    Left = 776
    Top = 72
  end
  object ADOQTipInvest: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select t.* , c.dsc_caracteristica'#10
      ''
      '  from t_tipoinvestimento t'#10
      ''
      '     , t_caracteristica c'#10
      ''
      ' where t.cod_caracteristica = c.cod_caracteristica'#10
      ''
      ' order by dsc_tipoinvestimento')
    Left = 832
    Top = 392
    object ADOQTipInvestcod_tipoinvestimento: TAutoIncField
      FieldName = 'cod_tipoinvestimento'
      ReadOnly = True
    end
    object ADOQTipInvestdsc_tipoinvestimento: TStringField
      FieldName = 'dsc_tipoinvestimento'
      Size = 60
    end
    object ADOQTipInvestcod_caracteristica: TIntegerField
      FieldName = 'cod_caracteristica'
    end
    object ADOQTipInvestdsc_caracteristica: TStringField
      FieldName = 'dsc_caracteristica'
      Size = 60
    end
    object ADOQTipInvestdsc_caracteristica_1: TStringField
      FieldName = 'dsc_caracteristica_1'
      Size = 60
    end
  end
  object dsqTipInvest: TDataSource
    DataSet = ADOQTipInvest
    Left = 832
    Top = 448
  end
  object ADOQAtivo: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select ta.*, tg.*, ti.*, tc.*'#10
      ''
      '  from t_ativo ta,'#10
      ''
      '       t_gestorinvestimento tg,'#10
      ''
      '       t_tipoinvestimento ti,'#10
      ''
      '       t_caracteristica tc'#10
      ''
      ' where ta.cod_gestor = tg.cod_gestor'#10
      ''
      '   and ta.cod_tipoinvestimento = ti.cod_tipoinvestimento'#10
      ''
      '   and ti.cod_caracteristica = tc.cod_caracteristica')
    Left = 40
    Top = 392
    object ADOQAtivocod_ativo: TAutoIncField
      FieldName = 'cod_ativo'
      ReadOnly = True
    end
    object ADOQAtivonom_ativo: TStringField
      FieldName = 'nom_ativo'
      Size = 30
    end
    object ADOQAtivodsc_caracteristicaativo: TStringField
      FieldName = 'dsc_caracteristicaativo'
      Size = 30
    end
    object ADOQAtivocod_tipoinvestimento: TIntegerField
      FieldName = 'cod_tipoinvestimento'
    end
    object ADOQAtivodat_abertura: TDateTimeField
      FieldName = 'dat_abertura'
      OnSetText = ADOQAtivodat_aberturaSetText
    end
    object ADOQAtivodat_vencimento: TDateTimeField
      FieldName = 'dat_vencimento'
      OnSetText = ADOQAtivodat_vencimentoSetText
    end
    object ADOQAtivocod_gestor: TIntegerField
      FieldName = 'cod_gestor'
    end
    object ADOQAtivocod_gestor_1: TAutoIncField
      FieldName = 'cod_gestor_1'
      ReadOnly = True
    end
    object ADOQAtivodsc_gestor: TStringField
      FieldName = 'dsc_gestor'
      Size = 30
    end
    object ADOQAtivocto_gestor: TStringField
      FieldName = 'cto_gestor'
      Size = 30
    end
    object ADOQAtivocod_tipoinvestimento_1: TAutoIncField
      FieldName = 'cod_tipoinvestimento_1'
      ReadOnly = True
    end
    object ADOQAtivodsc_tipoinvestimento: TStringField
      FieldName = 'dsc_tipoinvestimento'
      Size = 30
    end
    object ADOQAtivocod_caracteristica: TIntegerField
      FieldName = 'cod_caracteristica'
    end
    object ADOQAtivocod_caracteristica_1: TAutoIncField
      FieldName = 'cod_caracteristica_1'
      ReadOnly = True
    end
    object ADOQAtivodsc_caracteristica: TStringField
      FieldName = 'dsc_caracteristica'
      Size = 30
    end
  end
  object dsqAtivo: TDataSource
    DataSet = ADOQAtivo
    Left = 128
    Top = 392
  end
  object ADOQFechamento: TADOQuery
    Connection = ConLOGIN2
    Parameters = <>
    Left = 40
    Top = 456
  end
  object dsFechamento: TDataSource
    Left = 128
    Top = 456
  end
  object ADOQAlocacoes: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '/* Relat'#243'rio de Aloca'#231#245'es */'
      'select ti.dsc_investimento'
      #9' , tt.dsc_tipoinvestimento'
      '     , ti.dsc_observacao'
      '     , tc.nom_carteira'
      '     , tp.nom_proprietario'
      '     , FORMAT(ti.vlr_alocado, '#39'C'#39', '#39'pt-br'#39') as vlr_alocado'
      '     , FORMAT(ti.vlr_atualizado, '#39'C'#39', '#39'pt-br'#39') as vlr_atualizado'
      '     , ti.dat_abertura'
      '     , ti.dat_vencimento'
      '     , ti.dat_atualizacao'
      '     , ti.nro_cotas'
      '     , ts.dsc_status'
      '  from t_investimento ti'
      '     , t_tipoinvestimento tt'
      '     , t_ativo ta'
      '     , t_carteira tc'
      '     , t_proprietario tp'
      '     , t_status ts'
      ' where ti.cod_ativo = ta.cod_ativo'
      '   and ta.cod_tipoinvestimento = tt.cod_tipoinvestimento'
      '   and ti.cod_carteira = tc.cod_carteira'
      '   and tc.cod_proprietario = tp.cod_proprietario'
      '   and ti.cod_status = ts.cod_status'
      
        ' order by ti.dsc_investimento, tt.dsc_tipoinvestimento, ti.dsc_o' +
        'bservacao, ti.dat_abertura, tc.nom_carteira ')
    Left = 32
    Top = 520
    object ADOQAlocacoesdsc_investimento: TStringField
      FieldName = 'dsc_investimento'
      Size = 60
    end
    object ADOQAlocacoesdsc_tipoinvestimento: TStringField
      FieldName = 'dsc_tipoinvestimento'
      Size = 60
    end
    object ADOQAlocacoesdsc_observacao: TStringField
      FieldName = 'dsc_observacao'
      Size = 60
    end
    object ADOQAlocacoesnom_carteira: TStringField
      FieldName = 'nom_carteira'
      Size = 40
    end
    object ADOQAlocacoesnom_proprietario: TStringField
      FieldName = 'nom_proprietario'
      Size = 60
    end
    object ADOQAlocacoesvlr_alocado: TWideStringField
      FieldName = 'vlr_alocado'
      ReadOnly = True
      Size = 4000
    end
    object ADOQAlocacoesvlr_atualizado: TWideStringField
      FieldName = 'vlr_atualizado'
      ReadOnly = True
      Size = 4000
    end
    object ADOQAlocacoesdat_abertura: TDateTimeField
      FieldName = 'dat_abertura'
    end
    object ADOQAlocacoesdat_vencimento: TDateTimeField
      FieldName = 'dat_vencimento'
    end
    object ADOQAlocacoesdat_atualizacao: TDateTimeField
      FieldName = 'dat_atualizacao'
    end
    object ADOQAlocacoesnro_cotas: TBCDField
      FieldName = 'nro_cotas'
      Precision = 10
      Size = 2
    end
    object ADOQAlocacoesdsc_status: TStringField
      FieldName = 'dsc_status'
      Size = 30
    end
  end
  object dsAlocacoes: TDataSource
    Left = 128
    Top = 520
  end
  object dsValidaComp: TDataSource
    DataSet = ADOQValidaComp
    Left = 232
    Top = 448
  end
  object ADOQValidaComp: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pdtcomp'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'select top 1 * from t_fechamento where competencia = :pdtcomp;')
    Left = 224
    Top = 392
  end
  object ADOQRentab: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select ti.dsc_investimento, '
      'tt.dsc_tipoinvestimento, '
      'ti.dsc_observacao, '
      'tc.nom_carteira, '
      'sum(ti.nro_cotas) as cotas, '
      'FORMAT(sum(ti.vlr_alocado), '#39'C'#39', '#39'pt-br'#39') as vlr_alocado, '
      'FORMAT(sum(ti.vlr_atualizado), '#39'C'#39', '#39'pt-br'#39') as vlr_atualizado, '
      
        'FORMAT(sum(ti.vlr_atualizado - ti.vlr_alocado), '#39'C'#39', '#39'pt-br'#39') as' +
        ' vlr_ret_liq, '
      'ts.dsc_status '
      'from t_investimento ti, '
      't_ativo ta, '
      't_tipoinvestimento tt, '
      't_carteira tc, '
      't_status ts '
      'where ti.cod_ativo = ta.cod_ativo '
      'and ta.cod_tipoinvestimento = tt.cod_tipoinvestimento'
      'and ti.cod_carteira = tc.cod_carteira '
      'and ti.cod_status = ts.cod_status '
      
        'group by ti.dsc_investimento, tt.dsc_tipoinvestimento, ti.dsc_ob' +
        'servacao, tc.nom_carteira, ts.dsc_status')
    Left = 320
    Top = 392
    object ADOQRentabdsc_investimento: TStringField
      FieldName = 'dsc_investimento'
      Size = 60
    end
    object ADOQRentabdsc_tipoinvestimento: TStringField
      FieldName = 'dsc_tipoinvestimento'
      Size = 60
    end
    object ADOQRentabdsc_observacao: TStringField
      FieldName = 'dsc_observacao'
      Size = 60
    end
    object ADOQRentabnom_carteira: TStringField
      FieldName = 'nom_carteira'
      Size = 40
    end
    object ADOQRentabvlr_alocado: TWideStringField
      FieldName = 'vlr_alocado'
      ReadOnly = True
      Size = 4000
    end
    object ADOQRentabvlr_atualizado: TWideStringField
      FieldName = 'vlr_atualizado'
      ReadOnly = True
      Size = 4000
    end
    object ADOQRentabvlr_ret_liq: TWideStringField
      FieldName = 'vlr_ret_liq'
      ReadOnly = True
      Size = 4000
    end
    object ADOQRentabdsc_status: TStringField
      FieldName = 'dsc_status'
      Size = 30
    end
    object ADOQRentabcotas: TBCDField
      FieldName = 'cotas'
      ReadOnly = True
      Precision = 32
      Size = 2
    end
  end
  object dsqRentab: TDataSource
    DataSet = ADOQRentab
    Left = 408
    Top = 392
  end
  object ADODSMovimento: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_movimento'
    Parameters = <>
    Left = 880
    Top = 16
    object ADODSMovimentocod_movimento: TAutoIncField
      FieldName = 'cod_movimento'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object ADODSMovimentocod_ativo: TIntegerField
      FieldName = 'cod_ativo'
    end
    object ADODSMovimentocod_carteira: TIntegerField
      FieldName = 'cod_carteira'
    end
    object ADODSMovimentotip_movimento: TStringField
      FieldName = 'tip_movimento'
      FixedChar = True
      Size = 1
    end
    object ADODSMovimentovlr_unitario: TBCDField
      FieldName = 'vlr_unitario'
      Precision = 12
      Size = 2
    end
    object ADODSMovimentovlr_movimento: TBCDField
      FieldName = 'vlr_movimento'
      Precision = 11
      Size = 2
    end
    object ADODSMovimentovlr_outras_despesas: TBCDField
      FieldName = 'vlr_outras_despesas'
      Precision = 12
      Size = 2
    end
    object ADODSMovimentodat_movimento: TDateTimeField
      FieldName = 'dat_movimento'
    end
    object ADODSMovimentocat_movimento: TStringField
      FieldName = 'cat_movimento'
      Size = 1
    end
    object ADODSMovimentoAtivo: TStringField
      FieldKind = fkLookup
      FieldName = 'Ativo'
      LookupDataSet = ADODSAtivo
      LookupKeyFields = 'cod_ativo'
      LookupResultField = 'nom_ativo'
      KeyFields = 'cod_ativo'
      Lookup = True
    end
    object ADODSMovimentoCarteira: TStringField
      FieldKind = fkLookup
      FieldName = 'Carteira'
      LookupDataSet = ADODSCarteira
      LookupKeyFields = 'cod_carteira'
      LookupResultField = 'nom_carteira'
      KeyFields = 'cod_carteira'
      Lookup = True
    end
    object ADODSMovimentoqtd_cotas: TBCDField
      FieldName = 'qtd_cotas'
      DisplayFormat = '#######0.00'
      EditFormat = '#######0.00'
      Precision = 10
      Size = 2
    end
  end
  object DSMovimento: TDataSource
    DataSet = ADODSMovimento
    Left = 884
    Top = 72
  end
  object ADOQMovto: TADOQuery
    Connection = ConLOGIN2
    Parameters = <>
    SQL.Strings = (
      'select * from t_investimento ti'
      ''
      '')
    Left = 511
    Top = 400
    object ADOQMovtocod_investimento: TAutoIncField
      FieldName = 'cod_investimento'
      ReadOnly = True
    end
    object ADOQMovtocod_ativo: TIntegerField
      FieldName = 'cod_ativo'
    end
    object ADOQMovtodsc_investimento: TStringField
      FieldName = 'dsc_investimento'
      Size = 30
    end
    object ADOQMovtovlr_alocado: TBCDField
      FieldName = 'vlr_alocado'
      Precision = 11
      Size = 2
    end
    object ADOQMovtovlr_atualizado: TBCDField
      FieldName = 'vlr_atualizado'
      Precision = 11
      Size = 2
    end
    object ADOQMovtocod_proprietario: TIntegerField
      FieldName = 'cod_proprietario'
    end
    object ADOQMovtocod_carteira: TIntegerField
      FieldName = 'cod_carteira'
    end
    object ADOQMovtocod_status: TIntegerField
      FieldName = 'cod_status'
    end
    object ADOQMovtodat_inicio_investimento: TDateField
      FieldName = 'dat_inicio_investimento'
    end
    object ADOQMovtodat_fim_investimento: TDateField
      FieldName = 'dat_fim_investimento'
    end
    object ADOQMovtodat_atualizacao: TDateField
      FieldName = 'dat_atualizacao'
    end
    object ADOQMovtodsc_observacao: TStringField
      FieldName = 'dsc_observacao'
      Size = 30
    end
    object ADOQMovtonro_cotas: TSmallintField
      FieldName = 'nro_cotas'
    end
  end
  object dsqMovto: TDataSource
    DataSet = ADOQMovto
    Left = 596
    Top = 398
  end
  object ADOQPerformace: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        '/* Query estat'#237'stica para listar a performace dos ativos ao long' +
        'o do ano... */'#10
      ''
      'select '#10
      ''
      '  tf.dsc_investimento,'#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(tf.vlr_alocado, 2' +
        '),'#39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as vlr_alocado,'#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 1) then tf.vlr_atualizado else 0 end), 2),' +
        #39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as janeiro, '#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 2) then tf.vlr_atualizado else 0 end), 2),' +
        #39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as fevereiro, '#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 3) then tf.vlr_atualizado else 0 end), 2),' +
        #39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as marco, '#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 4) then tf.vlr_atualizado else 0 end), 2),' +
        #39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as abril, '#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 5) then tf.vlr_atualizado else 0 end), 2),' +
        #39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as maio, '#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 6) then tf.vlr_atualizado else 0 end), 2),' +
        #39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as junho, '#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 7) then tf.vlr_atualizado else 0 end), 2),' +
        #39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as julho,'#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 8) then tf.vlr_atualizado else 0 end), 2),' +
        #39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as agosto,'#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 9) then tf.vlr_atualizado else 0 end), 2),' +
        #39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as setembro,'#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 10) then tf.vlr_atualizado else 0 end), 2)' +
        ','#39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as outubro,'#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 11) then tf.vlr_atualizado else 0 end), 2)' +
        ','#39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as novembro,'#10
      ''
      
        '  CONCAT('#39'R$ '#39', REPLACE(REPLACE(REPLACE(FORMAT(sum(case when (mo' +
        'nth(tf.competencia) = 12) then tf.vlr_atualizado else 0 end), 2)' +
        ','#39'.'#39','#39';'#39'),'#39','#39','#39'.'#39'),'#39';'#39','#39','#39')) as dezembro'#10
      ''
      'from t_fechamento tf'#10
      ''
      '   , t_investimento ti'#10
      ''
      'where tf.cod_investimento = ti.cod_investimento'#10
      ''
      '  and tf.cod_carteira = 1'#10
      ''
      '  and ti.cod_status = 1'#10
      ''
      'group by tf.dsc_investimento')
    Left = 320
    Top = 464
    object ADOQPerformacedsc_investimento: TStringField
      FieldName = 'dsc_investimento'
      Size = 30
    end
    object ADOQPerformacevlr_alocado: TStringField
      FieldName = 'vlr_alocado'
      ReadOnly = True
      Size = 53
    end
    object ADOQPerformacejaneiro: TStringField
      FieldName = 'janeiro'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformacefevereiro: TStringField
      FieldName = 'fevereiro'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformacemarco: TStringField
      FieldName = 'marco'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformaceabril: TStringField
      FieldName = 'abril'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformacemaio: TStringField
      FieldName = 'maio'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformacejunho: TStringField
      FieldName = 'junho'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformacejulho: TStringField
      FieldName = 'julho'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformaceagosto: TStringField
      FieldName = 'agosto'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformacesetembro: TStringField
      FieldName = 'setembro'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformaceoutubro: TStringField
      FieldName = 'outubro'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformacenovembro: TStringField
      FieldName = 'novembro'
      ReadOnly = True
      Size = 82
    end
    object ADOQPerformacedezembro: TStringField
      FieldName = 'dezembro'
      ReadOnly = True
      Size = 82
    end
  end
  object dsqPerformace: TDataSource
    DataSet = ADOQPerformace
    Left = 408
    Top = 464
  end
  object ConLOGIN2: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=FINANCEIRO;Data Source=RMORAES'
    DefaultDatabase = 'FINANCEIRO'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB.1'
    Left = 920
    Top = 184
  end
  object ADODataSet1: TADODataSet
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_ativo'
    Parameters = <>
    Left = 1024
    Top = 184
  end
  object ADOQPesqCarteira: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '/* Relat'#243'rio de Rentabilidade */  '
      'select * from t_carteira order by nom_carteira')
    Left = 704
    Top = 392
    object ADOQPesqCarteiracod_carteira: TAutoIncField
      FieldName = 'cod_carteira'
      ReadOnly = True
    end
    object ADOQPesqCarteiranom_carteira: TStringField
      FieldName = 'nom_carteira'
      Size = 40
    end
    object ADOQPesqCarteiradat_criacao: TDateTimeField
      FieldName = 'dat_criacao'
    end
    object ADOQPesqCarteiracod_proprietario: TIntegerField
      FieldName = 'cod_proprietario'
    end
    object ADOQPesqCarteiracod_status: TIntegerField
      FieldName = 'cod_status'
    end
  end
  object DSPesqCarteira: TDataSource
    DataSet = ADOQPesqCarteira
    Left = 704
    Top = 448
  end
  object ADODSTpProvento: TADODataSet
    Active = True
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_tipprovento order by dsc_tipprovento'
    Parameters = <>
    Left = 40
    Top = 152
    object ADODSTpProventocod_tipprovento: TAutoIncField
      FieldName = 'cod_tipprovento'
      ReadOnly = True
    end
    object ADODSTpProventodsc_tipprovento: TStringField
      FieldName = 'dsc_tipprovento'
      Size = 40
    end
    object ADODSTpProventoobs_tipprovento: TStringField
      FieldName = 'obs_tipprovento'
      Size = 60
    end
  end
  object DSTpProvento: TDataSource
    DataSet = ADODSTpProvento
    Left = 40
    Top = 208
  end
  object ADODSProvento: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 
      'select * from t_provento order by  competencia desc, dat_pagamen' +
      'to desc, cod_carteira'
    Parameters = <>
    Left = 136
    Top = 152
    object ADODSProventocod_provento: TAutoIncField
      FieldName = 'cod_provento'
      ReadOnly = True
    end
    object ADODSProventocod_tipprovento: TIntegerField
      FieldName = 'cod_tipprovento'
    end
    object ADODSProventocompetencia: TDateTimeField
      FieldName = 'competencia'
    end
    object ADODSProventocod_ativo: TIntegerField
      FieldName = 'cod_ativo'
    end
    object ADODSProventodat_pagamento: TDateTimeField
      FieldName = 'dat_pagamento'
    end
    object ADODSProventovlr_por_cota_acao: TBCDField
      FieldName = 'vlr_por_cota_acao'
      Precision = 12
      Size = 2
    end
    object ADODSProventoqtd_cotas: TBCDField
      FieldName = 'qtd_cotas'
      DisplayFormat = '#######0.00'
      EditFormat = '#######0.00'
      Precision = 10
      Size = 2
    end
    object ADODSProventovlr_total: TBCDField
      FieldName = 'vlr_total'
      Precision = 12
      Size = 2
    end
    object ADODSProventodsc_observacao: TStringField
      FieldName = 'dsc_observacao'
      Size = 60
    end
    object ADODSProventocod_carteira: TIntegerField
      FieldName = 'cod_carteira'
    end
    object ADODSProventoAtivo: TStringField
      FieldKind = fkLookup
      FieldName = 'Ativo'
      LookupDataSet = ADODSAtivo
      LookupKeyFields = 'cod_ativo'
      LookupResultField = 'nom_ativo'
      KeyFields = 'cod_ativo'
      Lookup = True
    end
    object ADODSProventoTpProv: TStringField
      FieldKind = fkLookup
      FieldName = 'TpProv'
      LookupDataSet = ADODSTpProvento
      LookupKeyFields = 'cod_tipprovento'
      LookupResultField = 'dsc_tipprovento'
      KeyFields = 'cod_tipprovento'
      Lookup = True
    end
    object ADODSProventoCarteira: TStringField
      FieldKind = fkLookup
      FieldName = 'Carteira'
      LookupDataSet = ADODSCarteira
      LookupKeyFields = 'cod_carteira'
      LookupResultField = 'nom_carteira'
      KeyFields = 'cod_carteira'
      Lookup = True
    end
  end
  object DSProvento: TDataSource
    DataSet = ADODSProvento
    Left = 136
    Top = 208
  end
  object ADODSSitMeta: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_situacao_meta order by dsc_sitmeta'
    Parameters = <>
    Left = 232
    Top = 152
    object ADODSSitMetacod_sitmeta: TAutoIncField
      FieldName = 'cod_sitmeta'
      ReadOnly = True
    end
    object ADODSSitMetadsc_sitmeta: TStringField
      FieldName = 'dsc_sitmeta'
      Size = 40
    end
    object ADODSSitMetadsc_observacao: TStringField
      FieldName = 'dsc_observacao'
      Size = 60
    end
  end
  object DSSitMeta: TDataSource
    DataSet = ADODSSitMeta
    Left = 232
    Top = 208
  end
  object ADODSMeta: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_meta'
    Parameters = <>
    Left = 344
    Top = 152
    object ADODSMetacod_meta: TAutoIncField
      FieldName = 'cod_meta'
      ReadOnly = True
    end
    object ADODSMetadsc_meta: TStringField
      FieldName = 'dsc_meta'
      Size = 60
    end
    object ADODSMetadat_inicial: TDateTimeField
      FieldName = 'dat_inicial'
    end
    object ADODSMetadat_final: TDateTimeField
      FieldName = 'dat_final'
    end
    object ADODSMetavlr_inicial: TBCDField
      FieldName = 'vlr_inicial'
      DisplayFormat = '###,##0.00'
      Precision = 14
      Size = 2
    end
    object ADODSMetavlr_final: TBCDField
      FieldName = 'vlr_final'
      DisplayFormat = '###,##0.00'
      Precision = 14
      Size = 2
    end
    object ADODSMetavlr_atual: TBCDField
      FieldName = 'vlr_atual'
      DisplayFormat = '###,##0.00'
      Precision = 14
      Size = 2
    end
    object ADODSMetacod_sitmeta: TIntegerField
      FieldName = 'cod_sitmeta'
    end
    object ADODSMetadsc_observacao: TStringField
      FieldName = 'dsc_observacao'
      Size = 60
    end
    object ADODSMetadat_atualizacao: TDateTimeField
      FieldName = 'dat_atualizacao'
    end
    object ADODSMetaSituacao: TStringField
      FieldKind = fkLookup
      FieldName = 'Situacao'
      LookupDataSet = ADODSSitMeta
      LookupKeyFields = 'cod_sitmeta'
      LookupResultField = 'dsc_sitmeta'
      KeyFields = 'cod_sitmeta'
      Lookup = True
    end
    object ADODSMetapct_atingido: TBCDField
      FieldName = 'pct_atingido'
      Precision = 5
      Size = 2
    end
  end
  object DSMeta: TDataSource
    DataSet = ADODSMeta
    Left = 344
    Top = 208
  end
  object ADOQProventos: TADOQuery
    Connection = ConLOGIN2
    Parameters = <>
    SQL.Strings = (
      'select sum(vlr_total) as valor_total from t_provento;'
      ''
      '')
    Left = 511
    Top = 472
    object ADOQProventosvalor_total: TBCDField
      FieldName = 'valor_total'
      ReadOnly = True
      Precision = 32
      Size = 2
    end
  end
  object dsqProventos: TDataSource
    DataSet = ADOQProventos
    Left = 596
    Top = 470
  end
  object ADODSCambio: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 'select * from t_cambio'
    Parameters = <>
    Left = 440
    Top = 152
    object ADODSCambiocod_cambio: TAutoIncField
      FieldName = 'cod_cambio'
      ReadOnly = True
    end
    object ADODSCambiodat_solicitacao: TDateTimeField
      FieldName = 'dat_solicitacao'
    end
    object ADODSCambiodat_cambio: TDateTimeField
      FieldName = 'dat_cambio'
    end
    object ADODSCambiocod_carteira: TIntegerField
      FieldName = 'cod_carteira'
    end
    object ADODSCambiocod_proprietario: TIntegerField
      FieldName = 'cod_proprietario'
    end
    object ADODSCambiovlr_aporte_br: TBCDField
      FieldName = 'vlr_aporte_br'
      DisplayFormat = '###,###,##0.00'
      Precision = 14
      Size = 2
    end
    object ADODSCambiovlr_aporte_us: TBCDField
      FieldName = 'vlr_aporte_us'
      DisplayFormat = '###,###,##0.00'
      Precision = 14
      Size = 2
    end
    object ADODSCambiovlr_taxas: TBCDField
      FieldName = 'vlr_taxas'
      DisplayFormat = '###,###,##0.00'
      Precision = 14
      Size = 2
    end
    object ADODSCambiovlr_final_br: TBCDField
      FieldName = 'vlr_final_br'
      DisplayFormat = '###,###,##0.00'
      Precision = 14
      Size = 2
    end
    object ADODSCambiovlr_cotacao_dolar: TBCDField
      FieldName = 'vlr_cotacao_dolar'
      DisplayFormat = '#,###,###,##0.0000'
      Precision = 14
      Size = 2
    end
    object ADODSCambiodsc_observacao: TStringField
      FieldName = 'dsc_observacao'
      Size = 60
    end
    object ADODSCambiodat_cadastro: TDateTimeField
      FieldName = 'dat_cadastro'
    end
    object ADODSCambiocod_status: TIntegerField
      FieldName = 'cod_status'
    end
    object ADODSCambioProprietario: TStringField
      FieldKind = fkLookup
      FieldName = 'Proprietario'
      LookupDataSet = ADODSInvestidor
      LookupKeyFields = 'cod_proprietario'
      LookupResultField = 'nom_proprietario'
      KeyFields = 'cod_proprietario'
      Lookup = True
    end
    object ADODSCambioCarteira: TStringField
      FieldKind = fkLookup
      FieldName = 'Carteira'
      LookupDataSet = ADODSCarteira
      LookupKeyFields = 'cod_carteira'
      LookupResultField = 'nom_carteira'
      KeyFields = 'cod_carteira'
      Lookup = True
    end
    object ADODSCambioSituacao: TStringField
      FieldKind = fkLookup
      FieldName = 'Situacao'
      LookupDataSet = ADODSStatus
      LookupKeyFields = 'cod_status'
      LookupResultField = 'dsc_status'
      KeyFields = 'cod_status'
      Lookup = True
    end
  end
  object DSCambio: TDataSource
    DataSet = ADODSCambio
    Left = 440
    Top = 208
  end
  object ADOQProventosAno: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        '/* Query estat'#237'stica para listar os proventos dos ativos ao long' +
        'o do ano... */ '
      'select '
      'ta.nom_ativo, '
      'FORMAT(a.val_atualizado,'#39'C'#39', '#39'pt-br'#39') as val_atualizado,'
      'FORMAT(a.nro_cotas, '#39'N'#39', '#39'pt-br'#39') as nro_cotas,'
      
        'FORMAT((a.val_atualizado / a.nro_cotas), '#39'C'#39', '#39'pt-br'#39') as preco_' +
        'medio,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 1) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as janeiro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 2) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as fevereiro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 3) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as marco,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 4) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as abril,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 5) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as maio,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 6) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as junho,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 7) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as julho,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 8) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as agosto,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 9) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as setembro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 10) then tr.vlr_to' +
        'tal else 0 end), '#39'C'#39', '#39'pt-br'#39') as outubro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 11) then tr.vlr_to' +
        'tal else 0 end), '#39'C'#39', '#39'pt-br'#39') as novembro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 12) then tr.vlr_to' +
        'tal else 0 end), '#39'C'#39', '#39'pt-br'#39') as dezembro,'
      'FORMAT(sum(tr.vlr_total), '#39'C'#39', '#39'pt-br'#39') as total'
      
        'from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nr' +
        'o_cotas) as nro_cotas, ti.cod_ativo'
      '        FROM t_investimento ti  '
      '       WHERE 1=1'
      #9'   GROUP BY ti.cod_ativo) a'
      '   , t_provento tr'#9'    '
      '   , t_ativo ta '
      'where a.cod_ativo = tr.cod_ativo'
      '  and ta.cod_ativo = tr.cod_ativo'
      'group by ta.nom_ativo, a.val_atualizado, a.nro_cotas'
      'order by ta.nom_ativo')
    Left = 256
    Top = 536
    object ADOQProventosAnonom_ativo: TStringField
      FieldName = 'nom_ativo'
      Size = 60
    end
    object ADOQProventosAnopreco_medio: TWideStringField
      FieldName = 'preco_medio'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnojaneiro: TWideStringField
      FieldName = 'janeiro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnofevereiro: TWideStringField
      FieldName = 'fevereiro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnomarco: TWideStringField
      FieldName = 'marco'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnoabril: TWideStringField
      FieldName = 'abril'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnomaio: TWideStringField
      FieldName = 'maio'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnojunho: TWideStringField
      FieldName = 'junho'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnojulho: TWideStringField
      FieldName = 'julho'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnoagosto: TWideStringField
      FieldName = 'agosto'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnosetembro: TWideStringField
      FieldName = 'setembro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnooutubro: TWideStringField
      FieldName = 'outubro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnonovembro: TWideStringField
      FieldName = 'novembro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnodezembro: TWideStringField
      FieldName = 'dezembro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnoval_atualizado: TWideStringField
      FieldName = 'val_atualizado'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnonro_cotas: TWideStringField
      FieldName = 'nro_cotas'
      ReadOnly = True
      Size = 4000
    end
    object ADOQProventosAnototal: TWideStringField
      FieldName = 'total'
      ReadOnly = True
      Size = 4000
    end
  end
  object dsProventosAno: TDataSource
    Left = 360
    Top = 536
  end
  object ADOQTotalInvestido: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      
        'IF Object_ID('#39'tempDB..#temp_totinvestimentos'#39','#39'U'#39') is not null D' +
        'ROP TABLE #temp_totinvestimentos'
      ''
      'select ta.nom_ativo, a.val_atualizado'
      'INTO #temp_totinvestimentos'
      
        'from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nr' +
        'o_cotas) as nro_cotas, ti.cod_ativo'
      '        FROM t_investimento ti  '
      '       WHERE 1=1'
      #9'   GROUP BY ti.cod_ativo) a'
      '   , t_provento tr'#9'    '
      '   , t_ativo ta '
      'where a.cod_ativo = tr.cod_ativo'
      '  and ta.cod_ativo = tr.cod_ativo'
      '  and ta.cod_tipoinvestimento = 2'
      'group by ta.nom_ativo, a.val_atualizado'
      ''
      ''
      
        'select FORMAT(sum(t.val_atualizado),'#39'C'#39', '#39'pt-br'#39') as val_investi' +
        'do from #temp_totinvestimentos t')
    Left = 920
    Top = 392
    object ADOQTotalInvestidoval_investido: TWideStringField
      FieldName = 'val_investido'
      ReadOnly = True
      Size = 4000
    end
  end
  object DSQTotalInvestido: TDataSource
    DataSet = ADOQTotalInvestido
    Left = 920
    Top = 448
  end
  object ADOQCambio: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select tm.dat_solicitacao'
      '     , tm.dat_cambio'
      #9' , tc.nom_carteira'
      #9' , tp.nom_proprietario'
      #9' , FORMAT(tm.vlr_aporte_br, '#39'C'#39', '#39'pt-br'#39') as vlr_aporte_br'
      #9' , FORMAT(tm.vlr_taxas, '#39'C'#39', '#39'pt-br'#39') as vlr_taxas'
      #9' , FORMAT(tm.vlr_final_br, '#39'C'#39', '#39'pt-br'#39') as vlr_final_br'
      
        #9' , '#39'R$ '#39' + cast(tm.vlr_cotacao_dolar as varchar) as vlr_cotacao' +
        '_dolar'
      #9' --, FORMAT(tm.vlr_aporte_us, '#39'C'#39', '#39'en-us'#39') as vlr_aporte_us'
      #9' , tm.vlr_aporte_us'
      '                 , tm.dat_cadastro'
      #9' , ts.dsc_status as situacao'
      #9' , tm.dsc_observacao'
      '  from t_cambio tm'
      '     , t_carteira tc'
      #9' , t_proprietario tp'
      #9' , t_status ts'
      ' where tm.cod_carteira = tc.cod_carteira'
      '   and tm.cod_proprietario = tp.cod_proprietario'
      '   and tm.cod_status = ts.cod_status'
      ' order by dat_cambio desc, nom_carteira, nom_proprietario')
    Left = 1032
    Top = 392
    object ADOQCambiodat_solicitacao: TDateTimeField
      FieldName = 'dat_solicitacao'
    end
    object ADOQCambiodat_cambio: TDateTimeField
      FieldName = 'dat_cambio'
    end
    object ADOQCambionom_carteira: TStringField
      FieldName = 'nom_carteira'
      Size = 40
    end
    object ADOQCambionom_proprietario: TStringField
      FieldName = 'nom_proprietario'
      Size = 60
    end
    object ADOQCambiovlr_aporte_br: TWideStringField
      FieldName = 'vlr_aporte_br'
      ReadOnly = True
      Size = 4000
    end
    object ADOQCambiovlr_taxas: TWideStringField
      FieldName = 'vlr_taxas'
      ReadOnly = True
      Size = 4000
    end
    object ADOQCambiovlr_final_br: TWideStringField
      FieldName = 'vlr_final_br'
      ReadOnly = True
      Size = 4000
    end
    object ADOQCambiovlr_cotacao_dolar: TStringField
      FieldName = 'vlr_cotacao_dolar'
      ReadOnly = True
      Size = 33
    end
    object ADOQCambiodat_cadastro: TDateTimeField
      FieldName = 'dat_cadastro'
    end
    object ADOQCambiosituacao: TStringField
      FieldName = 'situacao'
      Size = 30
    end
    object ADOQCambiodsc_observacao: TStringField
      FieldName = 'dsc_observacao'
      Size = 60
    end
    object ADOQCambiovlr_aporte_us: TBCDField
      FieldName = 'vlr_aporte_us'
      Precision = 14
      Size = 2
    end
  end
  object dsqCambio: TDataSource
    DataSet = ADOQCambio
    Left = 1072
    Top = 344
  end
  object ADOQMovimentos: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '/* Listagem das movimenta'#231#245'es  - relat'#243'rio */'
      'select tc.nom_carteira'
      '     , cast(tm.dat_movimento as date) as dat_movimento'
      #9' , ta.nom_ativo'
      #9' , tm.tip_movimento'
      #9' , tm.qtd_cotas'
      #9' , tm.vlr_unitario'
      #9' , tm.vlr_outras_despesas'
      #9' , tm.vlr_movimento'
      #9' , tm.cat_movimento'
      #9' , tp.nom_proprietario'
      #9' , ti.dsc_tipoinvestimento'
      '  from t_movimento tm'
      '     , t_carteira tc'
      #9' , t_ativo ta'
      #9' , t_proprietario tp'
      #9' , t_tipoinvestimento ti'
      ' where tm.cod_carteira = tc.cod_carteira'
      '   and tm.cod_ativo = ta.cod_ativo'
      '   and tc.cod_proprietario = tp.cod_proprietario'
      '   and ta.cod_tipoinvestimento = ti.cod_tipoinvestimento'
      
        ' order by tm.cod_carteira, tm.dat_movimento asc, tm.cod_ativo, t' +
        'm.vlr_movimento')
    Left = 464
    Top = 544
    object ADOQMovimentosnom_carteira: TStringField
      FieldName = 'nom_carteira'
      Size = 40
    end
    object ADOQMovimentosdat_movimento: TWideStringField
      FieldName = 'dat_movimento'
      ReadOnly = True
      Size = 10
    end
    object ADOQMovimentosnom_ativo: TStringField
      FieldName = 'nom_ativo'
      Size = 60
    end
    object ADOQMovimentostip_movimento: TStringField
      FieldName = 'tip_movimento'
      Size = 1
    end
    object ADOQMovimentosqtd_cotas: TBCDField
      FieldName = 'qtd_cotas'
      DisplayFormat = '###,##0.00'
      Precision = 10
      Size = 2
    end
    object ADOQMovimentosvlr_unitario: TBCDField
      FieldName = 'vlr_unitario'
      DisplayFormat = '###,###,##0.00'
      Precision = 12
      Size = 2
    end
    object ADOQMovimentosvlr_outras_despesas: TBCDField
      FieldName = 'vlr_outras_despesas'
      DisplayFormat = '###,###,##0.00'
      Precision = 12
      Size = 2
    end
    object ADOQMovimentosvlr_movimento: TBCDField
      FieldName = 'vlr_movimento'
      DisplayFormat = '###,###,##0.00'
      Precision = 14
      Size = 2
    end
    object ADOQMovimentoscat_movimento: TStringField
      FieldName = 'cat_movimento'
      Size = 1
    end
    object ADOQMovimentosnom_proprietario: TStringField
      FieldName = 'nom_proprietario'
      Size = 60
    end
    object ADOQMovimentosdsc_tipoinvestimento: TStringField
      DisplayWidth = 30
      FieldName = 'dsc_tipoinvestimento'
      Size = 60
    end
  end
  object dsMovimentos: TDataSource
    Left = 552
    Top = 536
  end
  object ADOQPesqStatus: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from t_status')
    Left = 704
    Top = 504
    object ADOQPesqStatuscod_status: TAutoIncField
      FieldName = 'cod_status'
      ReadOnly = True
    end
    object ADOQPesqStatusdsc_status: TStringField
      FieldName = 'dsc_status'
      Size = 30
    end
  end
  object DSPesqStatus: TDataSource
    DataSet = ADOQPesqStatus
    Left = 704
    Top = 552
  end
  object ADODSAnuncioProvento: TADODataSet
    AutoCalcFields = False
    Connection = ConLOGIN2
    CursorType = ctStatic
    CommandText = 
      'select * from t_prev_proventos order by  dat_anuncio, dat_pagame' +
      'nto, cod_ativo'
    Parameters = <>
    Left = 568
    Top = 152
    object ADODSAnuncioProventocod_prev_proventos: TAutoIncField
      FieldName = 'cod_prev_proventos'
      ReadOnly = True
    end
    object ADODSAnuncioProventodat_anuncio: TDateTimeField
      FieldName = 'dat_anuncio'
    end
    object ADODSAnuncioProventocod_ativo: TIntegerField
      FieldName = 'cod_ativo'
    end
    object ADODSAnuncioProventodat_com: TDateTimeField
      FieldName = 'dat_com'
    end
    object ADODSAnuncioProventodat_pagamento: TDateTimeField
      FieldName = 'dat_pagamento'
    end
    object ADODSAnuncioProventocod_tipprovento: TIntegerField
      FieldName = 'cod_tipprovento'
    end
    object ADODSAnuncioProventovlr_bruto: TBCDField
      FieldName = 'vlr_bruto'
      Precision = 12
    end
    object ADODSAnuncioProventopct_ir: TBCDField
      FieldName = 'pct_ir'
      DisplayFormat = '##0.00'
      EditFormat = '##0.00'
      Precision = 3
      Size = 2
    end
    object ADODSAnuncioProventovlr_ir: TBCDField
      FieldName = 'vlr_ir'
      DisplayFormat = '########0.0000'
      EditFormat = '########0.0000'
      Precision = 12
    end
    object ADODSAnuncioProventovlr_liquido: TBCDField
      FieldName = 'vlr_liquido'
      DisplayFormat = '########0.0000'
      EditFormat = '########0.0000'
      Precision = 12
    end
    object ADODSAnuncioProventocod_status: TIntegerField
      FieldName = 'cod_status'
    end
    object ADODSAnuncioProventoAtivo: TStringField
      FieldKind = fkLookup
      FieldName = 'Ativo'
      LookupDataSet = ADODSAtivo
      LookupKeyFields = 'cod_ativo'
      LookupResultField = 'nom_ativo'
      KeyFields = 'cod_ativo'
      Lookup = True
    end
    object ADODSAnuncioProventoTpProv: TStringField
      FieldKind = fkLookup
      FieldName = 'TpProv'
      LookupDataSet = ADODSTpProvento
      LookupKeyFields = 'cod_tipprovento'
      LookupResultField = 'dsc_tipprovento'
      KeyFields = 'cod_tipprovento'
      Lookup = True
    end
    object ADODSAnuncioProventoSituacao: TStringField
      FieldKind = fkLookup
      FieldName = 'Situacao'
      LookupDataSet = ADODSStatus
      LookupKeyFields = 'cod_status'
      LookupResultField = 'dsc_status'
      KeyFields = 'cod_status'
      Lookup = True
    end
  end
  object DSAnuncioProvento: TDataSource
    DataSet = ADODSAnuncioProvento
    Left = 568
    Top = 208
  end
  object ADOQAnunciosProventos: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        '/* Listagem dos an'#250'ncios e pagamento de proventos a receber ou j' +
        #225' recebidos - 10/03/2023 */'
      
        'select CONVERT(varchar(10),tp.dat_pagamento,103) dt_pagamento, C' +
        'ONVERT(varchar(10),tp.dat_com,103) dt_com, tp.cod_ativo, ta.nom_' +
        'ativo'
      
        '     , tp.cod_tipprovento, tv.dsc_tipprovento, tp.vlr_bruto, tp.' +
        'pct_ir, tp.vlr_ir, tp.vlr_liquido, tp.cod_status'
      
        #9' , tu.dsc_status, tr.nom_proprietario, ti.nro_cotas, (ti.nro_co' +
        'tas * tp.vlr_liquido) valor_a_receber'
      
        '  from t_prev_proventos tp, t_ativo ta, t_tipprovento tv, t_inve' +
        'stimento ti, t_proprietario tr, t_status tu'
      ' where 1=1'
      '   and tp.cod_ativo = ta.cod_ativo'
      '   and tp.cod_status = tu.cod_status'
      '   and tp.cod_tipprovento = tv.cod_tipprovento'
      '   --and tp.cod_status = 1'
      '   and ti.cod_status = 1'
      '   and tp.cod_ativo = ti.cod_ativo'
      '   and ti.cod_proprietario = tr.cod_proprietario'
      '   --and tp.dat_pagamento = '#39'13/01/2023'#39
      'order by tp.dat_pagamento, tp.cod_ativo, tr.cod_proprietario')
    Left = 856
    Top = 520
    object ADOQAnunciosProventosdt_pagamento: TWideStringField
      FieldName = 'dt_pagamento'
      ReadOnly = True
      Size = 10
    end
    object ADOQAnunciosProventosdt_com: TWideStringField
      FieldName = 'dt_com'
      ReadOnly = True
      Size = 10
    end
    object ADOQAnunciosProventoscod_ativo: TIntegerField
      FieldName = 'cod_ativo'
    end
    object ADOQAnunciosProventosnom_ativo: TStringField
      FieldName = 'nom_ativo'
      Size = 60
    end
    object ADOQAnunciosProventoscod_tipprovento: TIntegerField
      FieldName = 'cod_tipprovento'
    end
    object ADOQAnunciosProventosdsc_tipprovento: TStringField
      FieldName = 'dsc_tipprovento'
      Size = 40
    end
    object ADOQAnunciosProventosvlr_bruto: TBCDField
      FieldName = 'vlr_bruto'
      Precision = 12
    end
    object ADOQAnunciosProventospct_ir: TBCDField
      FieldName = 'pct_ir'
      Precision = 5
      Size = 2
    end
    object ADOQAnunciosProventosvlr_ir: TBCDField
      FieldName = 'vlr_ir'
      Precision = 12
    end
    object ADOQAnunciosProventosvlr_liquido: TBCDField
      FieldName = 'vlr_liquido'
      Precision = 12
    end
    object ADOQAnunciosProventoscod_status: TIntegerField
      FieldName = 'cod_status'
    end
    object ADOQAnunciosProventosdsc_status: TStringField
      FieldName = 'dsc_status'
      Size = 30
    end
    object ADOQAnunciosProventosnom_proprietario: TStringField
      FieldName = 'nom_proprietario'
      Size = 60
    end
    object ADOQAnunciosProventosnro_cotas: TBCDField
      FieldName = 'nro_cotas'
      Precision = 10
      Size = 2
    end
    object ADOQAnunciosProventosvalor_a_receber: TBCDField
      FieldName = 'valor_a_receber'
      ReadOnly = True
      currency = True
      Precision = 23
      Size = 6
    end
  end
  object dsAnunciosProventos: TDataSource
    Left = 984
    Top = 520
  end
  object ADOQConProventosAno: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        '/* Query estat'#237'stica para listar os proventos dos ativos ao long' +
        'o do ano - consulta em tela... */'
      'select ta.nom_ativo,'
      'FORMAT(a.val_atualizado,'#39'C'#39', '#39'pt-br'#39') as val_atualizado,'
      'FORMAT(a.nro_cotas, '#39'N'#39', '#39'pt-br'#39') as nro_cotas,'
      
        'FORMAT((a.val_atualizado / a.nro_cotas), '#39'C'#39', '#39'pt-br'#39') as preco_' +
        'medio,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 1) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as janeiro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 2) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as fevereiro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 3) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as marco,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 4) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as abril,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 5) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as maio,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 6) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as junho,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 7) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as julho,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 8) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as agosto,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 9) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as setembro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 10) then tr.vlr_to' +
        'tal else 0 end), '#39'C'#39', '#39'pt-br'#39') as outubro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 11) then tr.vlr_to' +
        'tal else 0 end), '#39'C'#39', '#39'pt-br'#39') as novembro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 12) then tr.vlr_to' +
        'tal else 0 end), '#39'C'#39', '#39'pt-br'#39') as dezembro,'
      'FORMAT(sum(tr.vlr_total), '#39'C'#39', '#39'pt-br'#39') as total,'
      'FORMAT((sum(tr.vlr_total)/12), '#39'C'#39', '#39'pt-br'#39') as media'
      
        'from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nr' +
        'o_cotas) as nro_cotas, ti.cod_ativo'
      'FROM t_investimento ti, t_tipoinvestimento te'
      'WHERE 1=1'
      'and ti.cod_status <> 4'
      'and ti.cod_tipoinvestimento = te.cod_tipoinvestimento'
      '--and ti.cod_proprietario = '#39'1'#39
      'GROUP BY ti.cod_ativo) a'
      ', t_provento tr'
      ', t_ativo ta'
      ', t_carteira tc'
      ', t_proprietario tp'
      ', t_investimento ti2'
      ', t_tipoinvestimento te2'
      'where a.cod_ativo = tr.cod_ativo'
      'and ta.cod_ativo = tr.cod_ativo'
      'and tr.cod_carteira = tc.cod_carteira'
      'and tc.cod_proprietario = tp.cod_proprietario'
      'and ti2.cod_proprietario = tc.cod_proprietario'
      'and ti2.cod_carteira = tc.cod_carteira'
      'and ti2.cod_ativo = ta.cod_ativo'
      'and ti2.cod_status <> 4'
      'and ti2.cod_tipoinvestimento = te2.cod_tipoinvestimento'
      '--and tp.cod_proprietario = '#39'1'#39
      'and tr.competencia between '#39'01-01-2023'#39' and '#39'31-12-2023'#39
      'group by ta.nom_ativo, a.val_atualizado, a.nro_cotas'
      'order by ta.nom_ativo')
    Left = 520
    Top = 320
    object ADOQConProventosAnonom_ativo: TStringField
      FieldName = 'nom_ativo'
      Size = 60
    end
    object ADOQConProventosAnoval_atualizado: TWideStringField
      FieldName = 'val_atualizado'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnonro_cotas: TWideStringField
      FieldName = 'nro_cotas'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnopreco_medio: TWideStringField
      FieldName = 'preco_medio'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnojaneiro: TWideStringField
      FieldName = 'janeiro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnofevereiro: TWideStringField
      FieldName = 'fevereiro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnomarco: TWideStringField
      FieldName = 'marco'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnoabril: TWideStringField
      FieldName = 'abril'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnomaio: TWideStringField
      FieldName = 'maio'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnojunho: TWideStringField
      FieldName = 'junho'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnojulho: TWideStringField
      FieldName = 'julho'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnoagosto: TWideStringField
      FieldName = 'agosto'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnosetembro: TWideStringField
      FieldName = 'setembro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnooutubro: TWideStringField
      FieldName = 'outubro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnonovembro: TWideStringField
      FieldName = 'novembro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnodezembro: TWideStringField
      FieldName = 'dezembro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnototal: TWideStringField
      FieldName = 'total'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConProventosAnomedia: TWideStringField
      FieldName = 'media'
      ReadOnly = True
      Size = 4000
    end
  end
  object dsConProventosAno: TDataSource
    DataSet = ADOQConProventosAno
    Left = 640
    Top = 312
  end
  object ADOQConAux1: TADOQuery
    Connection = ConLOGIN2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        '/* Query estat'#237'stica para listar os proventos dos ativos ao long' +
        'o do ano - consulta em tela... */'
      'select '
      'FORMAT(a.val_atualizado,'#39'C'#39', '#39'pt-br'#39') as val_atualizado,'
      'FORMAT(a.nro_cotas, '#39'N'#39', '#39'pt-br'#39') as nro_cotas,'
      
        'FORMAT((a.val_atualizado / a.nro_cotas), '#39'C'#39', '#39'pt-br'#39') as preco_' +
        'medio,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 1) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as janeiro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 2) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as fevereiro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 3) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as marco,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 4) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as abril,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 5) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as maio,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 6) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as junho,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 7) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as julho,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 8) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as agosto,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 9) then tr.vlr_tot' +
        'al else 0 end), '#39'C'#39', '#39'pt-br'#39') as setembro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 10) then tr.vlr_to' +
        'tal else 0 end), '#39'C'#39', '#39'pt-br'#39') as outubro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 11) then tr.vlr_to' +
        'tal else 0 end), '#39'C'#39', '#39'pt-br'#39') as novembro,'
      
        'FORMAT(sum(case when (month(tr.competencia) = 12) then tr.vlr_to' +
        'tal else 0 end), '#39'C'#39', '#39'pt-br'#39') as dezembro,'
      'FORMAT(sum(tr.vlr_total), '#39'C'#39', '#39'pt-br'#39') as total,'
      'FORMAT((sum(tr.vlr_total)/12), '#39'C'#39', '#39'pt-br'#39') as media'
      
        'from (SELECT sum(ti.vlr_atualizado) as val_atualizado, sum(ti.nr' +
        'o_cotas) as nro_cotas --, ti.cod_ativo'
      '        FROM t_investimento ti, t_tipoinvestimento te'
      '       WHERE 1=1'
      '         and ti.cod_tipoinvestimento = te.cod_tipoinvestimento'
      '         and ti.cod_status <> 4) a'
      '         --and ti.cod_proprietario = '#39'1'#39') a'
      '      --GROUP BY ti.vlr_atualizado, ti.nro_cotas) a'
      ', t_provento tr'
      ', t_ativo ta'
      ', t_carteira tc'
      ', t_proprietario tp'
      ', t_investimento ti2'
      ', t_tipoinvestimento te2'
      'where ta.cod_ativo = tr.cod_ativo'
      'and tr.cod_carteira = tc.cod_carteira'
      'and tc.cod_proprietario = tp.cod_proprietario'
      'and ti2.cod_proprietario = tc.cod_proprietario'
      'and ti2.cod_carteira = tc.cod_carteira'
      'and ti2.cod_ativo = ta.cod_ativo'
      'and ti2.cod_status <> 4'
      'and ti2.cod_tipoinvestimento = te2.cod_tipoinvestimento'
      'and tr.competencia between '#39'01-01-2023'#39' and '#39'31-12-2023'#39
      'group by a.val_atualizado, a.nro_cotas')
    Left = 744
    Top = 304
    object ADOQConAux1val_atualizado: TWideStringField
      Alignment = taRightJustify
      FieldName = 'val_atualizado'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1nro_cotas: TWideStringField
      Alignment = taRightJustify
      FieldName = 'nro_cotas'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1preco_medio: TWideStringField
      Alignment = taRightJustify
      FieldName = 'preco_medio'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1janeiro: TWideStringField
      Alignment = taRightJustify
      FieldName = 'janeiro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1fevereiro: TWideStringField
      Alignment = taRightJustify
      FieldName = 'fevereiro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1marco: TWideStringField
      Alignment = taRightJustify
      FieldName = 'marco'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1abril: TWideStringField
      Alignment = taRightJustify
      FieldName = 'abril'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1maio: TWideStringField
      Alignment = taRightJustify
      FieldName = 'maio'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1junho: TWideStringField
      Alignment = taRightJustify
      FieldName = 'junho'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1julho: TWideStringField
      Alignment = taRightJustify
      FieldName = 'julho'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1agosto: TWideStringField
      Alignment = taRightJustify
      FieldName = 'agosto'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1setembro: TWideStringField
      Alignment = taRightJustify
      FieldName = 'setembro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1outubro: TWideStringField
      Alignment = taRightJustify
      FieldName = 'outubro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1novembro: TWideStringField
      Alignment = taRightJustify
      FieldName = 'novembro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1dezembro: TWideStringField
      Alignment = taRightJustify
      FieldName = 'dezembro'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1total: TWideStringField
      Alignment = taRightJustify
      FieldName = 'total'
      ReadOnly = True
      Size = 4000
    end
    object ADOQConAux1media: TWideStringField
      Alignment = taRightJustify
      FieldName = 'media'
      ReadOnly = True
      Size = 4000
    end
  end
end
