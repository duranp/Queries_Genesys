--select * from borrar_comunicados
--
--SELECT DISTINCT [USUARIO LC (ASESOR 1)],R.*, substring(tx_mail,17,2) FROM TEMPDB..CARTERAS_MASIVOS M INNER JOIN ROSTER_CM R ON M.[USUARIO LC (ASESOR 1)] = R.NAME
--update m set sexteto = substring(tx_mail,17,2) FROM TEMPDB..CARTERAS_MASIVOS M INNER JOIN ROSTER_CM R ON M.[USUARIO LC (ASESOR 1)] = R.NAME
--select * from TEMPDB..CARTERAS_MASIVOS M 
Joe%20Schmoe%20%3cjschmoe@abc.com%3e

--INSERTA LOS CLIENTES CANDIDATOS A ENVIARSE truncate table borrar_comunicados 
INSERT INTO borrar_comunicados 
--select name,sum(1) from (
	select top 100 percent  CD_PARTY, TX_ASISTENTE, CD_TRIADA, NAME, cast(null as datetime)fecha  from cartera 
	WHERE CD_PARTY NOT IN (SELECT CD_PARTY FROM borrar_comunicados)	and  
	name  in (
'DDC172',
--'DDC726',
'DDE063',
'DDE096',
'DDE100',
'DDE102',
'DNS283',
'DNS495',
'DNS498') order by newid()
--)x group by name
select sum(1) from borrar_comunicados where fecha is null

--GENERA LOS MAILS A LOS CLIENTES CANDIDATOS
insert into [10.105.8.249].cate.dbo.e_envio_generico (tx_mail, tx_body, tx_titulo)
	select distinct SWEMAILADDRESS,
	'<div style="font-family:calibri;font-size:11pt;color:darkblue;line-height:25px; text-indent:20">Estimado '+ tx_party + ',<br/>' +
	'<p>En Telef�nica Negocios buscamos mejorar d�a a d�a la Atenci�n y Satisfacci�n de nuestros clientes. En esta oportunidad nos acercamos para informarle que al ser seleccionado entre nuestros clientes m�s importantes, en nuestro <B>Centro de Atenci�n</B> hemos puesto a su disposici�n un <B>Asistente de Cuentas</b>, quien le prestar� de manera <b>personalizada</b> todo el asesoramiento que usted necesita.</p>'+
	'<p>Su Asistente de Cuentas es <b>' + upper(tx_asistente) +'</b>, a quien podr� contactar v�a e-mail a su casilla personal <a href="mailto:'+replace(tx_asistente,' ','%20') + '%20%3c'+ tx_mail +'%3e">'+ tx_mail +'</a></p>'+
	'<p><b>'+ DBO.SPLITINDEX(upper(firstname),' ',0) +'</b> se encuentra a su disposici�n para dar respuesta a sus requerimientos comerciales y necesidades de comunicaci�n, como as� tambi�n para canalizar dudas y consultas sobre sus facturas y servicios.</p>'+
	'<p>Si desea comunicarse telef�nicamente, tambi�n lo podr� hacer en forma gratuita al 0800-333-9000 (opci�n 2), y un integrante del equipo de <b>' + DBO.SPLITINDEX(upper(firstname),' ',0)  + '</b>, exclusivo de atenci�n a Empresas y Pymes dar� respuesta a su necesidad.</p>'+
	'<p>Sin m�s, lo invitamos a contactarse con nosotros y lo saludamos cordialmente.</p>'+

	'<b><span style="font-size:15pt">Centro de Atenci�n al Cliente<br/>Telefonica Negocios<br/>0800-333-9000</b><br/></span><div>',
	'Una Atenci�n diferente'
	from  cartera u inner join dw..party p on u.cd_party = p.cd_party inner join roster_cm r on r.name = u.name
	INNER JOIN VTV..CONTACTO C ON P.CD_PARTY = C.TASA_CLIE_CODIGO
	WHERE P.CD_PARTY IN (
		SELECT CD_PARTY FROM borrar_comunicados WHERE FECHA IS NULL)

--MARCA LOS CANDIDATOS COMO ENVIADOS PARA NO VOLVER A ENVIAR
UPDATE borrar_comunicados SET FECHA = GETDATE() WHERE FECHA IS NULL



/*

select * from genesys..roster_cm where name  in (
'DDC172',
--'DDC726',
'DDE063',
'DDE096',
'DDE100',
'DDE102',
'DNS283',
'DNS495',
'DNS498')

*/



select * from sysobjects where name


SELECT * INTO #Ir FROM OPENQUERY(GE2,'SELECT * FROM CONTACT.INTERACTION_resource_FACT_MM')

select * from #i order by fecha_inicio desc where lower(origen) like '%mangi%'

select * from #i where interaction_id = 308090
select * from #ir where interaction_id = 308090