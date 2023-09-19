--select * INTO BASE_COMPETENCIA from TEMPDB..BASE_COMPETENCIA

--INSERTA LOS CLIENTES CANDIDATOS A ENVIARSE truncate table borrar_comunicados 
--select * from borrar_comunicados where fecha is null
INSERT INTO borrar_comunicados 
--select name,sum(1) from (
	select top 100 percent CD_PARTY, NOMBRES TX_ASISTENTE, SEXTETO CD_TRIADA, NAME, cast(null as datetime)fecha  from base_compETENCIA
	WHERE CD_PARTY NOT IN (SELECT CD_PARTY FROM borrar_comunicados)	and  
	name  in (
            'DNS334',
            'DNS313',
            'DNS482',
            'DNS476',
            'DNS156',
            'LOPEZCI',
            'DNS314',
            'DNS100',
            'DNS376') order by newid()
--)x group by name
--SELECT * FROM base_compETENCIA
--delete from 

--GENERA LOS MAILS A LOS CLIENTES CANDIDATOS
insert into [10.105.8.249].cate.dbo.e_envio_generico (tx_mail, tx_body, tx_titulo)
	select 
--top 1 'sebastian.mangisch@telefonica.com,jorge.bernardez@telefonica.com,roberto.rico@telefonica.com',
	DISTINCT C.SWEMAILADDRESS,
	'<div style="font-family:calibri;font-size:11pt;color:darkblue;line-height:25px; text-indent:30">Estimado '+ tx_party + ',<br/>' +
	'<p>En Telefónica Negocios buscamos mejorar día a día la Atención y Satisfacción de nuestros clientes. En esta oportunidad nos acercamos para informarle que al ser seleccionado entre nuestros clientes más '+
	'importantes, en nuestro <b>Centro de Atención</B> hemos puesto a su disposición un <b>Asistente de Cuentas</b>, quien le prestará de manera <b>personalizada</b> todo el asesoramiento que usted necesita. </p>'+
	'<p>Su Asistente de Cuentas es <b>'+upper(lastname +' ' + firstname)+'</b>, a quien podrá contactar vía e-mail a su casilla personal <a href="mailto:'+r.tx_mail+'"><b>'+r.tx_mail+'</b></a></p>'+
	'<p><b>'+ upper(firstname) +'</B> se encuentra a su disposición para dar respuesta a sus requerimientos comerciales y  necesidades de comunicación, como así también para canalizar dudas y consultas sobre sus facturas y servicios.</p>'+
	'<p>Si desea comunicarse telefónicamente, también lo podrá hacer en forma gratuita al 0800-333-9000 (opción 2), y un integrante del equipo de <b>'+ upper(firstname) +'</B>, exclusivo de atención a Empresas y Pymes dará respuesta a su necesidad.</p>'+
	'<p>Sin más, lo invitamos a contactarse con nosotros y lo saludamos cordialmente.</p><br/>'+
	'<span style="font-size:15pt;  text-indent:0"><b>Centro de Atención al Cliente<br/>Telefonica Negocios<br/>0800-333-9000</b><br/></span><div>',
	'Una Atención diferente'
	from  base_competencia u inner join dw..party p on u.cd_party = p.cd_party inner join roster_cm r on r.name = u.name
	INNER JOIN VTV..CONTACTO C ON P.CD_PARTY = C.TASA_CLIE_CODIGO
	WHERE P.CD_PARTY IN (
		SELECT CD_PARTY FROM borrar_comunicados WHERE FECHA IS NULL)

--MARCA LOS CANDIDATOS COMO ENVIADOS PARA NO VOLVER A ENVIAR
UPDATE borrar_comunicados SET FECHA = GETDATE() WHERE FECHA IS NULL

/*
delete from borrar_comunicados WHERE FECHA IS NULL
roster_cm 
where lastname = 'albanese'

select * from roster_cm where name in (
'DNS334',
'DNS313',
'DNS482',
'DNS476',
'DNS156',
'LOPEZCI',
'DNS314',
'DNS100',
'DNS376')

select * from base_compfm

update statistics interaction_his
select * from borrar_comunicados where dbo.dmy(fecha) = dbo.dmy(getdate())
and cd_party in (select tasa_clie_codigo from vtv..contacto)
select distinct u.cd_party
from  base_competencia u left join dw..party p on u.cd_party = p.cd_party inner join roster_cm r on r.name = u.name
	left JOIN VTV..CONTACTO C ON P.CD_PARTY = C.TASA_CLIE_CODIGO
	WHERE P.CD_PARTY IN (
		SELECT CD_PARTY FROM borrar_comunicados WHERE FECHA IS NULL)
and c.swemailaddress is null
select * FROM  sys.sysdatabases
INNER JOIN sys.sysaltfiles ON sys.sysdatabases.dbid = sys.sysaltfiles.dbid
      WHERE (sys.sysaltfiles.fileid = 2)

select * from sys.sysaltfiles O
*/

