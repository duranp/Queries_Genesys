alter procedure sp_enviar_invitacion_aseguramiento
as
select cl.tasa_clie_codigo,c.swcaseid,cctcerradopor,hash,swemailaddress,
            '<table style="font-family:arial" cellpadding=0 cellspacing=0>'
			+ ' <tr> '
            + '  <td width=595 height=608 bgcolor=white style="border:.75pt solid black;vertical-align:top;background:white">'
            + '    <table style="font-family:verdana;color:Gray">'
            + '        <tr><td><center><img alt="Encuesta de Calidad" src="http://www.satisfaccion.speedy.com.ar/img/' 
			+ CASE WHEN ((DAY(GETDATE())>=8 AND MONTH(GETDATE())=12) OR (DAY(GETDATE())<=7 AND MONTH(GETDATE())=1)) THEN 'HEADER_FEST.PNG' ELSE 'HEADER_NEW.PGN' END
			+ '"/></center></td></tr>'
            + '        <tr><td><center><div style="margin-top:40px;color:darkblue;;font-weight:800;align=center">Encuesta de Satisfacción de clientes<BR /><BR /></div></center></td></tr>'
            + '        <tr><td style="font-size:12;color:Gray">Estimado ' + tx_PARTY + '</td></tr>'
            + '        <tr><td><div style="font-size:12;color:Gray"><center><BR />'
            + '      Lo invitamos a responder una breve encuesta referida al contacto que mantuvo recientemente con nuestro sector de Calidad por el seguimiento a su solicitud. Sus respuestas nos proporcionarán información muy valiosa, que será utilizada para detectar oportunidades de mejora, y nos permitirá brindarle el servicio que Ud y su Empresa se merecen.'
            + ' <br /><br />'
            + '      Desde ya, le agradecemos su tiempo.'
            + '    <br /><br />'
            + '      Para responder la encuesta haga click <a href="HTTP://WWW.SATISFACCION.SPEEDY.COM.AR/DEFAULT_2.ASP?HASH=' + hash + '">aquí</a></br>'
            + '<DIV style="font-size:10"> Si tiene inconvenientes para acceder al link por favor copie y pegue la siguiente direccion en su navegador:<br/> HTTP://WWW.SATISFACCION.SPEEDY.COM.AR/DEFAULT_2.ASP?HASH=' + hash + '</DIV>'
            + '    <br /><br /><br /></center>'
            + 'Cordialmente,    '
            + 'Sector aseguramiento de calidad'
            + 'Centro de Atención al Cliente (0800-333-9000)    '
            + 'Telefónica Negocios</div>'
            + '<br/><br/> <center><img alt="Certificacion ISO 9001" src="http://www.satisfaccion.speedy.com.ar/img/iso_new.jpg"/></center></td></tr>'
            + '    </table>'
            + '  </td>'
            + '  </tr>'
            + '  </table>' tx_BODY, 'Invitación a encuesta' tx_titulo
into #t
FROM VTV..CASOS C WITH (NOLOCK)
	INNER JOIN VTV..ROSTER_BO R WITH (NOLOCK) ON C.CCTCERRADOPOR = R.COTA AND SUP = 'Gestion_de_Aseguramiento_de_Calidad' 
	INNER JOIN VTV..CLIENTES CL WITH (NOLOCK) ON C.SWCUSTOMERID = CL.SWCUSTOMERID
	INNER JOIN DW..PARTY P		WITH (NOLOCK) ON CL.TASA_CLIE_CODIGO = P.CD_PARTY
	inner join vtv..hoy h		WITH (NOLOCK) on c.swcaseid = h.cctcaseid
	inner join vtv..contacto co WITH (NOLOCK) on h.cctpersonid = co.swpersonid
	cross apply (select cast(newid() as varchar(100))hash)id
WHERE 
DBO.DMY(SWDATERESOLVED) >= DBO.DMY(GETDATE()-3)
AND CCTSOLUCIONID IN (
	165,166,167,168,169,3412,3422,3423,3428,3430,12648,12653,14318,14321,14324,14325,14319,14320,14322,14323,14326,14327,14333,14335)
and c.swcaseid not in (select cd_caso from [10.105.8.249].cate.dbo.e_enviados)



INSERT INTO [10.105.8.249].cate.dbo.[E_ENVIADOS]                          
	([CD_PARTY],[CD_CASO],[TX_USUARIO],[TX_HASH],[TX_MAIL],[TX_CELULAR])   
select tasa_clie_codigo,swcaseid,cctcerradopor,hash,swemailaddress,'ASEG' from #t

insert into [10.105.8.249].cate.dbo.e_envio_generico
      (tx_mail, tx_titulo,tx_body)  
select swemailaddress,tx_titulo, tx_body from #t

drop table #t

select distinct c.cctdescripcion from vtv..clasificacion c inner join vtv..submotivo s on c.cctsubmotivoid = s.cctsubmotivoid inner join vtv..motivo m on m.cctmotivoid = s.cctmotivoid where 
cctclasificacionid IN (
	165,166,167,168,169,3412,3422,3423,3428,3430,12648,12653,14318,14321,14324,14325,14319,14320,14322,14323,14326,14327,14333,14335)

select cast(cctclasificacionid as varchar(max))+',' from vtv..clasificacion where cctdescripcion in (
'Contactado - Con cierre',
'Contactado Insatisfecho',
'Contactado Satisfecho',
'Contactado - Sin cierre')

select * from vtv..clasificacion where cctdescripcion like '%sin%'
select * from vtv..clasificacion where cctclasificacionid =
14144.00000
165,166,167,168,169,170,171,172,173,174,3412,3413,3421,3422,3423,3424,3427,3428,3430,3435,12648,12653,14318,14321,14324,14325,14319,14320,14322,14323,14326,14327,14333,14335


genesys.dbo.s sp_enviar_invitacion_aseguramiento

165,166,167,168,169,170,171,172,173,174,3412,3413,3421,3422,3423,3424,3427,3428,3430,3435,12648,12653,14318,14321,14324,14325,14319,14320,14322,14323,14326,14327,14333,14335

select top 10 * from [10.105.8.249].cate.dbo.e_enviados where tx_celular = 'aseg'

select * from vtv..vw_casos where swcaseid = 17572948  
select * from vtv..casos where swcaseid = 17572948  
select * from vtv..hoy where swcaseid = 17572948  
select * from vtv..contacto c where swpersonid = (select cctpersonid from vtv..hoy where swcaseid = 17572948)

select top 10 * from [10.105.8.249].cate.dbo.e_enviados 
where cd_caso = 17572948