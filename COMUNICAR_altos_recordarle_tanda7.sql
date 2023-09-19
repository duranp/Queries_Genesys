
--GENERA LOS MAILS A LOS CLIENTES CANDIDATOS
insert into [10.105.8.249].cate.dbo.e_envio_generico (tx_mail, tx_body, tx_titulo)
	select distinct SWEMAILADDRESS,
--FE DE ERRATAS	'<DIV style="font-family:calibri;font-size:11pt;color:darkblue;">Estimado cliente, debido a un error en la comunicaci�n anterior, le enviamos nuevamente los datos correctos de su Asistente de Cuentas:</DIV><BR/><BR/>'+
	'<div style="font-family:calibri;font-size:11pt;color:darkblue;line-height:25px; text-indent:20">Estimado '+ tx_party + ',<br/>' +
	'<p>En Telef�nica Negocios buscamos mejorar d�a a d�a la Atenci�n y Satisfacci�n de nuestros clientes. En esta oportunidad nos acercamos para recordarle que al ser seleccionado entre nuestros clientes m�s importantes, en el <b>Centro de Atenci�n a Clientes</b> hemos puesto a su disposici�n un <b>Asistente de Cuentas</b>, quien le prestar� de manera <b>personalizada</b> todo el asesoramiento que usted necesita.</p>'+
	'<p>Su Asistente de Cuentas es ' + upper(firstname + ' ' +lastname) + ', quien se encuentra a su disposici�n para responder inquietudes y necesidades, como as� tambi�n para canalizar consultas sobre sus facturas y tr�mites comerciales.</p>'+
	'<p>Adicionalmente, le informamos que para mejorar el seguimiento de los contactos v�a email, hemos migrado a una nueva herramienta que nos permitir� agilizar las respuestas y brindarle una gesti�n integral a sus solicitudes. Por lo expuesto, a partir de hoy, podr� contactar a su Asistente Personal ' + upper(firstname + ' ' +lastname)+ ', a su nueva casilla e-mail <a href="mailto:'+replace(tx_asistente,' ','%20') + '%20%3c'+ tx_mail +'%3e">'+ tx_mail +'</a></p>'+
	'<p>Aprovechamos para recordarle que Ud. cuenta tambi�n con un Equipo T�cnico especializado, a quien podr� contactar ante un eventual inconveniente en sus servicios, a trav�s de la casilla <A HREF="AtenciontecnicaTNegocios.ar@telefonica.com">AtenciontecnicaTNegocios.ar@telefonica.com</A> </p>'+
	'<p>Sin mas, lo invitamos a contactarse con nosotros y lo saludamos cordialmente.</p><br/>'+
	'<span style="font-size:15pt"><b>Centro de Atenci�n al Cliente<br/>Telefonica Negocios</b><br/></span><div>',
--FE DE ERRATAS 	'FE DE ERRATAS '+
	'Una Atenci�n diferente'
	from  cartera u inner join dw..party p on u.cd_party = p.cd_party inner join roster_cm r on r.name = u.name
	INNER JOIN VTV..CONTACTO C ON P.CD_PARTY = C.TASA_CLIE_CODIGO
	WHERE u.name in  (
	'UNE351',
	'UNE359',
	'UNE377',
	'UNE409',
	'UNE410')

/*


SELECT     r.name, firstName, lastName, EmployeeID, vag, sup, tx_mail, PCRC, sum(1)
FROM         roster_cm r inner join cartera c on r.name = c.name
WHERE     (r.name IN ('DNS265', 'DNS288', 'DNS267', 'DNS227', 'DNS292', 'DNS116', 'DNS291', 'DNS212', 'DNS104', 'DNS203'))
group by r.name, firstName, lastName, EmployeeID, vag, sup, tx_mail, PCRC


select distinct fc_foto from roster_cm_his  order by fc_foto

select distinct c.tx_asistente, c.name, r.* 
from cartera c 
	inner join roster_cm r on c.name = r.name 
		and r.name in (
	'UNE351',
'UNE359',
'UNE377',
'UNE409',
'UNE410')
*/



s sp_get_agentes
select * from roster_cm where lastname like '%retegui%'union all
select * from roster_cm where lastname like '%LAMBIASSE%'union all
select * from roster_cm where lastname like '%GAGLIARDO%'union all
select * from roster_cm where lastname like '%MORENO%' and firstname = 'mariano' union all
select * from roster_cm where lastname like 'CANE'union all
select * from roster_cm where lastname like '%BERETERBIDE%'union all
select * from roster_cm where lastname like '%MARTINEZ GAUNA%' and firstname = 'lourdes' union all
select * from roster_cm where lastname like '%DELUCA%' and firstname = 'MARIA DEL CARMEN'union all
select * from roster_cm where lastname like '%PEREYRA%' and firstname = 'rocio'


select * from cartera where tx_asistente like '%deluca%'

select max(fc_foto) from roster_cm_his

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

select * from roster_cm where (lastname like '%deluca%' and firstname like '%maria%' )or lastname like '%crivel%' or lastname like 'cane' or lastname like '%briatore%' or lastname like '%demaria%'


ALTER PROCEDURE sp_get_dudosos   
as  
select fecha from aprobacion where general = 1 and salvado is null and fecha >= dbo.pd(dateadd(month,-1,getdate())) order by fecha desc  


select * from dw..parque where cd_party_titular = 8137112

select * from [10.105.8.249].cate.dbo.e_envio_generico where tx_body like '%crivel%'