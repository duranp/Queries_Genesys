--select |* from borrar_comunicados

--INSERTA LOS CLIENTES CANDIDATOS A ENVIARSE truncate table borrar_comunicados 
INSERT INTO borrar_comunicados 
--select name,sum(1) from (
	select top 100 percent  CD_PARTY, TX_ASISTENTE, CD_TRIADA, NAME, cast(null as datetime)fecha  from cartera 
	WHERE CD_PARTY NOT IN (SELECT CD_PARTY FROM borrar_comunicados)	and  
	name  in (
'DNS505',
'DNS393',
'UNE382') order by newid()
--)x group by name

--GENERA LOS MAILS A LOS CLIENTES CANDIDATOS
insert into [10.105.8.249].cate.dbo.e_envio_generico (tx_mail, tx_body, tx_titulo)
	select distinct SWEMAILADDRESS,
	'<div style="font-family:calibri;font-size:11pt;color:darkblue;line-height:25px; text-indent:20">Estimado '+ tx_party + ',<br/>' +
	'<p>En Telefónica Negocios buscamos mejorar día a día la Atención y Satisfacción de nuestros clientes. En esta oportunidad nos acercamos para informarle que al ser seleccionado entre nuestros clientes más importantes, en el <b>Centro de Atención a Clientes de Telefónica Negocios</b>, hemos puesto a su disposición un <b>Asistente de Cuentas</b>, quien le prestará de manera <b>personalizada</b> todo el asesoramiento que usted necesita.</p>'+
	'<p>Su Asistente de Cuentas es ' + upper(tx_asistente) + ', cuyo horario laboral es de lunes a viernes de 9 a 16 hs. Lo podrá contactar vía e-mail a su casilla personal <a href="mailto:'+ tx_mail +'">'+ tx_mail +'</a></p>'+
	'<p>'+ dbo.splitindex(upper(firstname),' ',0) +' se encuentra a su disposición para responder a sus inquietudes y necesidades, como así también para canalizar consultas sobre sus facturas y trámites comerciales.</p>'+
	'<p>Asimismo, le informamos que Ud cuenta también, con un Equipo Técnico especializado, a quien podrá contactar ante un eventual inconveniente en sus servicios, a través de la casilla <A HREF="MAILTO:AtenciontecnicaTNegocios.ar@telefonica.com">AtenciontecnicaTNegocios.ar@telefonica.com</A>.</p>'+
	'<P>Sin más, lo invitamos a contactarse con nosotros y lo saludamos cordialmente.</P><BR/>'+

	'<b><span style="font-size:15pt">Centro de Atención al Cliente<br/>Telefonica Negocios<br/></span><div>',
	'Una Atención diferente'
	from  cartera u inner join dw..party p on u.cd_party = p.cd_party inner join roster_cm r on r.name = u.name
	INNER JOIN VTV..CONTACTO C ON P.CD_PARTY = C.TASA_CLIE_CODIGO
	WHERE P.CD_PARTY IN (
		SELECT CD_PARTY FROM borrar_comunicados WHERE FECHA IS NULL)
	AND U.NAME IN  (
'DNS505',
'DNS393',
'UNE382')
--MARCA LOS CANDIDATOS COMO ENVIADOS PARA NO VOLVER A ENVIAR
UPDATE borrar_comunicados SET FECHA = GETDATE() WHERE FECHA IS NULL

--select distinct dbo.splitindex(upper(firstname),' ',0) from genesys..roster_cm where name  in (
--'DNS505',
--'DNS393',
--'UNE382')

