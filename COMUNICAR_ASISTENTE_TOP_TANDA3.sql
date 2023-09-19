
--GENERA LOS MAILS A LOS CLIENTES CANDIDATOS
insert into [10.105.8.249].cate.dbo.e_envio_generico (tx_mail, tx_body, tx_titulo)
	select distinct SWEMAILADDRESS,
--FE DE ERRATAS	'<DIV style="font-family:calibri;font-size:11pt;color:darkblue;">Estimado cliente, debido a un error en la comunicación anterior, le enviamos nuevamente los datos correctos de su Asistente de Cuentas:</DIV><BR/><BR/>'+
	'<div style="font-family:calibri;font-size:11pt;color:darkblue;line-height:25px; text-indent:20">Estimado '+ tx_party + ',<br/>' +
	'<p>En Telefónica Negocios buscamos mejorar día a día la Atención y Satisfacción de nuestros clientes. En esta oportunidad nos acercamos para recordarle que al ser seleccionado entre nuestros clientes más importantes, en el <b>Centro de Atención a Clientes</b> hemos puesto a su disposición un <b>Asistente de Cuentas</b>, quien le prestará de manera <b>personalizada</b> todo el asesoramiento que usted necesita.</p>'+
	'<p>Su Asistente de Cuentas es ' + upper(firstname + ' ' +lastname) + ', quien se encuentra a su disposición para responder inquietudes y necesidades, como así también para canalizar consultas sobre sus facturas y trámites comerciales.</p>'+
	'<p>Adicionalmente, le informamos que para mejorar el seguimiento de los contactos vía email, hemos migrado a una nueva herramienta que nos permitirá agilizar las respuestas y brindarle una gestión integral a sus solicitudes. Por lo expuesto, a partir de hoy, podrá contactar a su Asistente Personal ' + upper(firstname + ' ' +lastname)+ ', a su nueva casilla e-mail <a href="mailto:'+replace(tx_asistente,' ','%20') + '%20%3c'+ r.tx_mail +'%3e">'+ r.tx_mail +'</a></p>'+

	'<p>Aprovechamos para recordarle que también cuentan con un Asistente Técnico, encargado de seguir junto a usted cualquier inconveniente que pudiera presentarse en sus servicios. Su Asistente Técnico es '+ asistente_tecnico +', a quien podrá contactar vía e-mail a su casilla personal <a href="mailto:'+replace(asistente_tecnico,' ','%20') + '%20%3c'+ t.tx_mail +'%3e">'+ t.tx_mail +'</a> o bien en forma telefónica de lunes a viernes de 8 a 19 hs, en nuestro Centro de Atención Técnico (opción 3) </p>'+

	'<p>Cabe aclarar que tanto su Asistente de Cuentas como su Asistente Técnico, trabajan en equipo con su <b><u>Ejecutivo de Cuentas</u></b>, con el objetivo de brindarle toda la calidad, soporte, asesoramiento y servicio que Ud y su empresa merecen.<P>'+
	'<p>Sin mas, lo invitamos a contactarse con nosotros y lo saludamos cordialmente.</p><br/>'+
	'<span style="font-size:15pt"><b>Centro de Atención al Cliente<br/>Telefonica Negocios</b><br/></span><div>',
--FE DE ERRATAS 	'FE DE ERRATAS '+
	'Una Atención diferente'
	from  cartera u inner join dw..party p on u.cd_party = p.cd_party inner join roster_cm r on r.name = u.name
	INNER JOIN VTV..CONTACTO C ON P.CD_PARTY = C.TASA_CLIE_CODIGO
	inner join tempdb..tecnico t on u.cd_party = t.cd_party
	WHERE u.name in (
'CCC448',
'UNE312',
'UNE341',
'UNE350',
'UNE381',
'UNE383',
'UNE386',
'UNE392',
'UNE419',
'UNE422',
'UNE424')
/*

select * from licencias where name in (

'CCC448',
'UNE312',
'UNE341',
'UNE350',
'UNE381',
'UNE383',
'UNE386',
'UNE392',
'UNE419',
'UNE422',
'UNE424')
SELECT     r.name, firstName, lastName, EmployeeID, vag, sup, tx_mail, PCRC, sum(1)
FROM         roster_cm r inner join cartera c on r.name = c.name
WHERE     (r.name IN ('CCC448',
--'UNE312',
--'UNE341',
--'UNE350',
'UNE381',
'UNE383',
'UNE386',
'UNE392',
'UNE419',
'UNE422',
'UNE424'))
group by r.name, firstName, lastName, EmployeeID, vag, sup, tx_mail, PCRC


select distinct fc_foto from roster_cm_his  order by fc_foto

select distinct c.tx_asistente, c.name, r.* 
from cartera c 
	inner join roster_cm r on c.name = r.name 
		and r.name in (
'UNE436',
'UNE373',
'UNE346',
'UNE956',
'UNE366',
'UNE356')

*/
select distinct r.* from roster_cm r inner join cartera u on r.name = u.name where pcrc like '%comercial_top%' and r.name <> 'UNE380'


s sp_get_agentes
select * from roster_cm where lastname like '%caricatto%'union all
select * from roster_cm where lastname like '%TESTTI%'union all
select * from roster_cm where lastname like '%GAGLIARDO%'union all
select * from roster_cm where lastname like '%REYES%' and firstname = 'carolina' union all
select * from roster_cm where lastname like 'zunino' and firstname = 'gaston' union all
select * from roster_cm where lastname like '%matthys%' and firstname = 'florencia' 

s sp_eficiencia
LUCIANA AGLAE CARICATTO
VANESA MARIA TESTTI

CAROLINA REYES

GASTON ZUNINO
MARIA FLORENCIA MATTHYS

select * from cartera where tx_asistente like '%deluca%'
dbo.so 'stats'
select max(fc_foto) from roster_cm_his
select * from freeze_stats_online where tx_stat = ''
select * from bcp_roster_cm

select * from cartera

select * from roster_cm where name in (
'UNE377',
'UNE409','une410')
select max(fecha)

select * from estructura 
where a1 in ('UNE377') and tasa_clie_codigo not in (select cd_party from cartera where tx_asistente = 'MARIA DEL CARMEN DELUCA')

DELETE FROM CARTERA WHERE CD_TRIADA IN (
SELECT CD_TRIADA FROM TEMPDB..NUEVAS_CARTERAS_TOPALTOS)
INSERT INTO CARTERA SELECT     CAST(d_party AS BIGINT), TX_ASITENTE, CAST(CD_TRIADA AS INT),NAME FROM         TEMPDB.dbo.NUEVAS_CARTERAS_TOPALTOS
SELECT TOP 10 * FROM CARTERA

select sum(1) from estructura
select * from cartera c full join estructura e on c.cd_party = e.tasa_clie_codigo
and c.name <> e.a1
select * from cartera where cd_party = 10850

select * from dw..party where cd_party = 10850
DELETE FROM ESTRUCTURA WHERE TASA_CLIE_CODIGO IS NULL 
dbo.so 'dudo'

s sp_get_dudosos

select distinct tx_asistente, name from cartera where name in ('UNE410','UNE377', 'UNE409', 'une410')

 UNE351

MARIA DEL CARMEN DELUCA   UNE377


PAMELA YANEL CANE                   UNE409

SOLEDAD CRIVELLI                          UNE410

VIRGINIA DEMARIA                       UNE359

select * from roster_cm where (lastname like '%deluca%' and firstname like '%maria%' )or lastname like '%crivel%' or lastname like 'cane' or lastname like '%briatore%' or lastname like '%demaria%'


ALTER PROCEDURE sp_get_dudosos   
as  
select fecha from aprobacion where general = 1 and salvado is null and fecha >= dbo.pd(dateadd(month,-1,getdate())) order by fecha desc  


select * from dw..parque where cd_party_titular = 8137112

SELECT * FROM #T

SELECT ID_AGENTE,NOMBRE_RECURSO, SUP,PCRC, DBO.CONCATENATE(SKILL)SKILL FROM #T T LEFT JOIN ROSTER_CM R ON T.ID_AGENTE = R.NAME
GROUP BY ID_AGENTE,NOMBRE_RECURSO, SUP, PCRC
SELECT * FROM #
SELECT * INTO #T FROM OPENQUERY(GE2,'select * from contact.skill_agent_stamp where customer = ''UNPRE'' and end_time = ''20250101000000'' and UPPER(skill) like ''SK_%''')

select * from roster_cm where sup = 'SUP_PIETRAGALLO_JUAN_P'

select * from e_enviados

select * 	from  cartera u 
	WHERE u.name in (

'UNE436',
'UNE373',
'UNE346',
'UNE956',
'UNE366',
'UNE356')
and cd_party in (select cd_party from tempdb..tecnico)

select * from tempdb..tecnico where cd_party  in (select cd_party from cartera)

select * from roster_cm where name in (

'UNE436',
'UNE373',
'UNE346',
'UNE956',
'UNE366',
'UNE356')


	from  cartera u inner join dw..party p on u.cd_party = p.cd_party inner join roster_cm r on r.name = u.name
	INNER JOIN VTV..CONTACTO C ON P.CD_PARTY = C.TASA_CLIE_CODIGO
	inner join tempdb..tecnico t on u.cd_party = t.cd_party
	WHERE u.name in (

'CCC448',
'UNE312',
'UNE341',
'UNE350',
'UNE381',
'UNE383',
'UNE386',
'UNE392',
'UNE419',
'UNE422',
'UNE424')
select convert(datetime,'30/12/1899 12:30:00 p.m.')
select dateadd(hour,case when intervalo like 'p.m' then 12 else 0 end,'12:30:00')
select left(fecha,10)+' '+dateadd(hour,case when intervalo like '%p.m.' and substring(intervalo,12,2) <12  then 12 else 0 end,substring(intervalo,12,8)),* from tempdb..programacion