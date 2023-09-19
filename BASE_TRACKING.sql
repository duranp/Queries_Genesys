
select * into #ir from interaction_det where dbo.f(fecha_inicio) >= getdate()-30
select * into #i from interaction_his where fecha >= getdate()-30


select distinct genesys.dbo.dmy(audio_start_TIME) fecha, callid, login, postdiscado 
into #verint from genesys..verint_neg v inner join appencuesta..respuestas r on cast(v.callid as varchar(30)) = r.respuesta 
where idpregunta in (
select id from appencuesta..preguntas
where pregunta like '%ID Impact 360%'
)
and isnumeric(respuesta) = 1

select ir.*, i.gvp_postdiscado, 
case	when exists(	select * from #verint 
					where fecha = dbo.dmy(dbo.f(ir.fecha_inicio)) 
					and i.gvp_postdiscado = postdiscado 
					and login = dbo.usr(nombre_recurso)
					) 
		then 1 else 0 
end monitoreado
into #final
from #ir ir 
	inner join #i i 
		on ir.interaction_id = i.interaction_id

select * from #final

--mail
select fecha, dbo.splitindex(r.respuesta,',',0) collate database_default idmon 
into #m
from appencuesta..respuestas r 
where isnumeric(respuesta)=0
and idpregunta in (
select id from appencuesta..preguntas
where pregunta like '%ID Impact 360%')

select distinct mail, dbo.dmy(enddate) from monitoreo_mail v 
	inner join #M m on v.id = m.idmon


select distinct ir.*, i.origen from interaction_resource_fact_mm ir 
	inner join interaction_fact_mm i on ir.interaction_id = i.interaction_id
	inner join vtv..contacto c on i.origen = c.swemailaddress
where resultado_tecnico  = 'completed' and ir.tipo_interaccion = 'outbound' and media_name = 'email' 
and origen not like '%telefonica%' and ir.fecha_fin >= '20130101'
order by ir.interaction_id

select * from monitoreo_mail 

select * from vtv..contacto c inner join dw..party p on c.tasa_clie_codigo = p.cd_party
and swdatecreated = (select max(swdatecreated) from vtv..contacto where swemailaddress = c.swemailaddress)


SELECT * into #out FROM openquery(ge2,'
select ir.interaction_id, ir.nombre_recurso, ir.fecha_inicio, replace(destino,''-'','''') * 1 DESTINO
from contact.interac_resource_201301 ir
        inner join contact.skill_agent_stamp s
              on contact.usr(ir.nombre_recurso) = s.id_agente
                 and ir.fecha_inicio between s.start_time and s.end_time
                 and s.skill in (''PCRC_POSVENTA_ASEGUR_CALIDAD'',''PCRC_RETENCION_OUT'',''VAG_PCRC_POSVENTA_COMERCIAL'')
        inner join contact.interaction_201301 i
                on ir.interaction_id = i.interaction_id
where
substr(ir.fecha_inicio,1,8) >= ''20130101''
and ir.TIPO_INTERACTION = ''Outbound''
and ir.servicio = ''UNPRE''
and ir.resultado_tecnico = ''Completed''
')

select dbo.trunc15(destino),
case	when exists(	select * from #verint 
					where fecha = dbo.dmy(dbo.f(o.fecha_inicio)) 
					and o.destino = postdiscado 
					and login = dbo.usr(nombre_recurso)
					) 
		then 1 else 0 
end monitoreado,
* from #out o 
inner join dw..parque p on dbo.trunc15(destino) = p.ani

select * from #out where isnumeric(destino) = 1
s f
create function trunc15 (@ani as varchar(15))
returns bigint as
begin
	return case when len(@ani)>10 then left(@ani,charindex('15',@ani)-1)+ substring(@ani,charindex('15',@ani)+2,10) else @ani end
end

select * from 

use rete

SELECT * FROM ESTADOS E INNER JOIN TAREAS T ON E.ID_TAREA = T.ID_TAREA --AND TX_RESPONSABLE = 'GESTION_DE_FRIO'
INNER JOIN PROMOS PR ON PR.ID_PROMO = T.ID_PROMO 
INNER JOIN CLS_PROMOS P ON PR.CD_PROMO = P.CD_PROMO AND TX_PROMO LIKE '%RETE%'

SELECT * FROM CASOS_BAG

SELECT T.NAME ,* FROM SYSCOLUMNS C INNER JOIN SYSOBJECTS T ON C.ID = T.ID WHERE C.NAME = 'ID_CASO'

SELECT * FROM ANIS
GENESYS.DBO.SO 'CASO'

select charindex('12','341277777')	

select * from openquery(ge2,'select substr(date_time,1,8) , SUM(1), SUM(ANSWERED) from contact.agent_day where substr(date_time,1,8) >= ''20130101'' and customer = ''AG_RPT_UNPRE'' GROUP BY substr(date_time,1,8) ORDER BY substr(date_time,1,8) ')

select      c.id_caso, c.cd_party, a.ani, max(e.timestamp),case	when exists(	select * from #verint 
					where fecha = genesys.dbo.dmy(max(e.timestamp))
					and a.ani= postdiscado 
					) 
		then 1 else 0 end
from  vw_tareas t
            inner join vw_estados e on e.id_tarea = t.id_tarea and e.cd_usuario <> 'SYSTEM' and cd_estado not in (2,3,37,56)
            inner join vw_promos p on p.id_promo = t.id_promo
            inner join vw_anis a on a.id_ani = p.id_ani
            inner join vw_casos c on c.id_caso = a.id_caso
where t.cd_tarea in (select cd_tarea from cls_tareas where tx_tarea like '%FRIO%')
            and e.timestamp > '20130101'
group by c.id_caso, c.cd_party, a.ani

select * from openquery(ge2,'select * from contact.interac_resource_201301 where servicio = ''UNPRE'' and resultado_tecnico_ampliado like ''%oute%''')


select * from openquery(ge2,'select distinct resultado_tecnico_ampliado from contact.interac_resource_201301 where servicio = ''UNPRE''') 