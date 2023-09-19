--CONEX:CS_CUSTOMER
use GENESYS

select * from monitoreo_mail 
WHERE MAIL = 'municipalidad@generalballivian.gov.ar'
order by startdate desc


select * from roster_cm where name = 'une419'

select month(fecha_inicio), day(fecha_inicio), sum(1) from interaction_fact_mm 
where fecha_inicio >= '20121201'
AND tipo_interaccion like 'inbound%' and tipo_interaccion not like '%NDR' and asunto <> 'Telefonica Negocios: Respuesta automatica recepcion email.' and origen not like '%telefonica%'
group by month(fecha_inicio), day(fecha_inicio)
order by month(fecha_inicio)DESC, day(fecha_inicio)

select 
case	when tx_tipo_cliente like 'alto%'	then 'altos' 
		when tx_tipo_cliente like 'top%'	then 'top' 
		when tx_tipo_cliente is null		then 'S/D' 
		else 'MASIVOS' END ,
 year(fecha_fin), month(fecha_fin), sum(case when datediff(hour,fecha_inicio,fecha_fin) >=25 then 1 else 0 end), sum(1) 
from interaction_fact_mm i 
	left join (SELECT TASA_CLIE_CODIGO, SWEMAILADDRESS FROM VTV..CONTACTO CO WHERE SWDATECREATED = (SELECT MAX(SWDATECREATED) FROM VTV..CONTACTO WHERE SWEMAILADDRESS = CO.SWEMAILADDRESS)) co2 on i.origen = co2.swemailaddress 
	left  join dw..party p on co2.tasa_clie_codigo = p.cd_party
	left  join dt_tipo_cliente t on p.cd_tipo_cliente = t.cd_tipo_cliente
where fecha_fin is not null and tipo_interaccion like 'inbound%' and tipo_interaccion not like '%NDR' and asunto <> 'Telefonica Negocios: Respuesta automatica recepcion email.' and origen not like '%telefonica%'
group by CASE when tx_tipo_cliente like 'alto%'	then 'altos' 
		when tx_tipo_cliente like 'top%'	then 'top' 
		when tx_tipo_cliente is null		then 'S/D' 
		else 'MASIVOS' END, year(fecha_fin), month(fecha_fin)
order by CASE when tx_tipo_cliente like 'alto%'	then 'altos' 
		when tx_tipo_cliente like 'top%'	then 'top' 
		when tx_tipo_cliente is null		then 'S/D' 
		else 'MASIVOS' END, year(fecha_fin), month(fecha_fin)





SELECT * FROM interaction_fact_mm
where fecha_fin BETWEEN '01/12/2012' AND '31/12/2012' and tipo_interaccion like 'inbound%' and tipo_interaccion not like '%NDR' and origen not like '%telefonica%'
and origen not in (select swemailaddress from vtv..contacto)
tipo_interaccion like 'inbound%' and tipo_interaccion not like '%NDR' and origen not like '%telefonica%'
and asunto <> 'Telefonica Negocios: Respuesta automatica recepcion email.'


SELECT month(fecha_inicio), pcrc, sup, ir.nombre_recurso+ ' ' + agent_first_name + ' ' + agent_last_name  
FROM INTERACTION_RESOURCE_FACT_MM ir left join roster_cm r on ir.nombre_recurso = r.name
WHERE INTERACTION_ID  IN (
SELECT INTERACTION_ID FROM INTERACTION_FACT_MM
WHERE 
fecha_inicio >= '01/12/2012' and
tipo_interaccion like 'inbound%' and tipo_interaccion not like '%NDR' and origen not like '%telefonica%'
and asunto <> 'Telefonica Negocios: Respuesta automatica recepcion email.') and tipo_interaccion = 'inbound'


SELECT * FROM INTERACTION_FACT_MM WHERE INTERACTION_ID = 264816
SELECT * FROM INTERACTION_RESOURCE_FACT_MM WHERE INTERACTION_ID = 264816



select max(fecha_inicio) from interaction_resource_fact_mm where interaction_id = 408128
select *  from interaction_fact_mm where interaction_id = 408128

select * from interaction_fact_mm ir
where(
 exists (
	select interaction_resource_id from interaction_resource_fact_mm  where 
	tipo_interaccion = 'inbound' and subtipo_interaccion = 'InboundCustomerReply' 
	and rol_recurso = 'routedto' and tipo_recurso = 'agent' and interaction_id = ir.interaction_id)
and exists (
	select interaction_resource_id from interaction_resource_fact_mm  where 
	tipo_interaccion = 'Outbound' and subtipo_interaccion = 'OutboundReply' 
	and rol_recurso = 'Initiated' and tipo_recurso = 'agent' and interaction_id = ir.interaction_id)
and exists (
	select interaction_resource_id from interaction_resource_fact_mm  where 
	tipo_interaccion = 'Outbound' and subtipo_interaccion = 'OutboundReply' 
	and rol_recurso = 'Puller' and tipo_recurso = 'agent' and interaction_id = ir.interaction_id)
)
and year(fecha_inicio) = 2013 and fecha_fin is null
