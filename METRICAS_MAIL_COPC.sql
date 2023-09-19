select *  into #i from openquery(ge2,'select * from contact.interaction_fact_mm')
select *  into #ir from openquery(ge2,'select * from contact.interaction_resource_fact_mm')


delete from interaction_fact_mm where interaction_id in (select interaction_id from #i)
	insert into interaction_fact_mm select * from #i
delete from interaction_resource_fact_mm where interaction_resource_id in (select interaction_resource_id from #ir)
	insert into interaction_resource_fact_mm  select * from #ir

DROP TABLE #I
DROP TABLE #IR

select * from interaction_fact_mm where origen not like '%telefonica%' and origen not like '%exchange%'

select xx.*, AGENT,a.nrr4, REPLACE(a.nrr4*1.0/Q*1.0,'.',',') from (
	select dia, name, sup, pcrc, vag, sum(1) q from
	(
	select distinct dbo.dmy(ir.fecha_inicio)dia, asunto, origen, nombre_recurso name, sup, pcrc, vag 
	from interaction_resource_fact_mm ir 
		inner join interaction_fact_mm i on i.interaction_id = ir.interaction_id 
		inner join roster_cm_his r on dbo.dmy(ir.fecha_inicio)=r.fc_foto and nombre_recurso = r.name
	where ir.tipo_interaccion = 'outbound'
	and origen not like '%telefonica%' and origen not like '%exchange%'
	)x 
	group by dia, name, sup, pcrc, vag
)xx
inner join agent_day a on XX.name = a.login and a.fecha = XX.dia
ORDER BY dia, name, sup, pcrc, vag

select xx.*, AGENT, a.nrr4, REPLACE(a.nrr4*1.0/Q*1.0,'.',',') from (
	select dia, name, sup, pcrc, vag, sum(1) q from
	(
	select distinct dbo.dmy(ir.fecha_inicio)dia, asunto, origen, nombre_recurso name, sup, pcrc, vag 
	from interaction_resource_fact_mm ir 
		inner join interaction_fact_mm i on i.interaction_id = ir.interaction_id 
		inner join roster_cm_his r on dbo.dmy(ir.fecha_inicio)=r.fc_foto and nombre_recurso = r.name
	--where ir.tipo_interaccion = 'outbound'
	and origen not like '%telefonica%' and origen not like '%exchange%'
	)x 
	group by dia, name, sup, pcrc, vag
)xx
inner join agent_day a on XX.name = a.login and a.fecha = XX.dia
ORDER BY dia, name, sup, pcrc, vag

select * from roster_cm where pcrc like '%comercial_top%'

select * 



select * from agent_day where login = 'UNE342' and fecha = '20121217'

T 'VTV..ROSTER_BO'

select * from interaction_fact_mm where origen like '%sebastian.mangisch%'

select * from interaction_resource_fact_mm where interaction_id = 322642


select distinct tipo_interaccion, subtipo_interaccion, rol_recurso, resultado_tecnico from interaction_resource_fact_mm
order by tipo_interaccion, subtipo_interaccion, rol_recurso, resultado_tecnico 