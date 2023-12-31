drop table #av

select * into #rt from openquery(ge,'select * from contact_unpre.interac_resource_201106 where resultado_tecnico_ampliado =''AbandonedWhileQueued'' and fecha_inicio >= 20110601000000')
select * into #av from openquery(ge,'select * from contact_unpre.agent_state_201106 where start_time >= 20110601000000 and state = ''Ready''')

select dbo.f(start_time), dbo.f(end_time),r.usuario from #av a inner join roster_1l r on a.agent like '%'+r.usuario +'%' and campaña like '%alto valor%'
select * from #rt where dbo.f(fecha_inicio) >= 

select i.interaction_id, fecha, fecha_f, pseudoskill, a.agent, dbo.f(start_time) ready_desde, dbo.f(end_time) ready_hasta, tx_tipo_cliente 
from interaction_his i 
	inner join #av a on dbo.f(start_time)<i.fecha  and dbo.f(end_time) >i.fecha_f 
	inner join roster_1l r on a.agent like '%'+r.usuario +'%' and campaña like '%competencia%'
	inner join dt_Tipo_cliente t on replace(gvp_categ_cliente,'-','') = cd_Tipo_cliente and cd_tipo_cliente in ('0R','0G')
where fecha >= '01/06/2011'  and resultado_tecnico like '%abandon%'
and destino = '1100'
and pseudoskill = 'comercial_competencia'
and interaction_id in (select interaction_id from #rt)

select * from  #av a 
	inner join roster_1l r on a.agent like '%'+r.usuario +'%' and campaña = 'Atención Alto Valor'
	inner join #RT i on dbo.f(start_time)<DBO.F(i.fecha_INICIO)  and dbo.f(end_time) >DBO.F(i.FECHA_FIN)


SELECT * FROM #RT


	--inner join #rt rt on rt.interaction_id = i.interaction_id
	inner join dt_Tipo_cliente t on replace(gvp_categ_cliente,'-','') = cd_Tipo_cliente

select * from #rt

and dbo.f(fecha_inicio) >= '01/06/2011'


select i.interaction_id, fecha, fecha_f, i.pseudoskill, a.agent, dbo.f(start_time) ready_desde, dbo.f(end_time) ready_hasta, tx_tipo_cliente 
from interaction_his i 
	inner join #av a on dbo.f(start_time)<i.fecha  and dbo.f(end_time) >i.fecha_f 
	inner join roster_1l r on a.agent like '%'+r.usuario +'%' and campaña like 'Atención Alto Valor'
	inner join dt_Tipo_cliente t on replace(gvp_categ_cliente,'-','') = cd_Tipo_cliente and cd_tipo_cliente in ('0D','0F')
	inner join #rt rt on i.interaction_id = rt.interaction_id
where fecha >= '01/06/2011'  and i.resultado_tecnico like '%abandon%'
and i.destino = '1100'
and i.pseudoskill in ('Comercial_Alto_Valor','Comercial_Alto_Valor_Pers')



select * from dt_tipo_cliente where tx_tipo_cliente like '%competencia%'

select * from roster_1l where campaña like '%competenc%'

select * from interaction_his where pseudoskill is null and tipo_recurso = 'agent' and fecha >= '18/05/2011' and destino = '1100'

select * from skill_his where date_time >= 20110518000000 and skill like 'vag%'

select * from skill_his where date_time between 20110517000000 and 20110518000000 and skill <> 'fh' 