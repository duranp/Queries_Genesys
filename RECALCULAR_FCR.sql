drop table #i
--SETEO FECHAS
DECLARE @DESDE AS DATETIME, @HASTA AS DATETIME
SET @DESDE = '20121201'--case when datepart(day,getdate())<9 then dbo.pd(dateadd(month,-1,getdate())) else dbo.pd(getdate()) end 
SET @HASTA = getdate()

--FCR

select fecha ,case grouping(replace(vag,'vag_cc_','')) when 1 then 'zzTotal' when 0 then replace(vag,'vag_cc_','') end site,    
    case grouping(sup) when 1 then 'aaaTotal' when 0 then (case sup when '' then '[sin sup]' else sup end)  end supervisor,case grouping(lastname+', '+firstname+' ('+name+')' ) when 1 then 'aaaTotal' when 0 then lastname+', '+firstname+' ('+name+')' end asistente,sum(d.fcr2) fcr2,sum(d.fcr7) fcr7,sum(d.cant) cant    
into #i
from (
    select dbo.dmy(fecha) as fecha,login as agent, sum(fcr2*1) as fcr2,sum(fcr7*1)as fcr7,sum(case when fcr2 is not null then 1 else 0 end) as cant    
    from interaction_his    
    where tipo_recurso='agent' and tipo_interaction='inbound'and dbo.dmy(fecha) between dbo.dmy(@DESDE-8) and  @HASTA+1    
    group by dbo.dmy(fecha),login) as d    
inner join genesys..roster_cm_his as r  on r.name collate database_default=d.agent collate database_default and r.fc_foto = d.fecha
group by fecha,replace(vag,'vag_cc_',''),sup,lastname+', '+firstname+' ('+name+')' with rollup



update a
set [no rellamaron en 2] = isnull(fcr2,0), [no rellamaron en 7]= isnull(fcr7,0), [llamadas contabilizadas]=cant
from agent_freeze a 
    inner join #i i 
        on a.fecha = i.fecha 
        and a.supervisor = i.supervisor 
        and a.asistente = i.asistente 
        and a.site = i.site

select * into agent_freeze_201212 from agent_freeze where fecha between '20121201' and getdate()

from agent_freeze a 
    left join #i i 
        on a.fecha = i.fecha 
        and a.supervisor = i.supervisor 
        and a.asistente = i.asistente 
        and a.site = i.site
where a.fecha  between '20121201' and getdate() --and a.asistente = 'FARIAS, GABRIELA SOLANGE (DDE068)'
and i.asistente is null
order by a.fecha

select * from interaction_his where login = 'ATT369' and fecha between '20121201' and '20121231'

select * from agent_freeze 
where asistente = 'Gonzalez, Jose (ATT369)' AND fecha >= '20121202'
order by fecha
SELECT * FROM AGENT_FREEZE WHERE PCRC IS NULL AND FECHA >= '20121202' AND ASISTENTE <> 'aaaTotal' AND ANSWERED = 0

select * from roster_cm_his where name = 'dde068' order by fc_foto

select * from roster_cm_his where lastname like '%DEL VALLE%' order by fc_foto

select * from #i where fecha = '20121202'
select * from roster_cm_his where fc_foto = '20121201'


select i.*, [no rellamaron en 2],[no rellamaron en 7],[llamadas contabilizadas]
from agent_freeze a 
    inner join #i i 
        on a.fecha = i.fecha 
        and a.supervisor = i.supervisor 
        and a.asistente = i.asistente 
        and a.site = i.site
where a.site = 'atento_salta' 
and a.supervisor = 'aaatotal'
and a.fecha = '05/12/2012'

select fecha, sum(1) from #i group by fecha order by fecha
select * from genesys..interaccion_fact_mm
SELECT MAX(FECHA) FROM BRUTA


select * from interaction_his where fecha is null

select sum(1), day(fecha) from interaction_his 
fecha  between '20131223' and getdate()
group by day(fecha)
GO
SELECT TOP 1 *
 FROM ROSTER_CM

DBCC OPENTRAN
DROP TABLE #I
select  
    object_name(P.object_id) as TableName, 
    resource_type, resource_description
from
    sys.dm_tran_locks L
    join sys.partitions P on L.resource_associated_entity_id = p.hobt_id

SELECT *
from
    sys.dm_tran_locks L

select fc_foto, sum(1)
 from roster_cm_his 
group by fc_foto
order by fc_foto


  select dbo.dmy(fecha) as fecha,login as agent, sum(fcr2*1) as fcr2,sum(fcr7*1)as fcr7,sum(case when fcr2 is not null then 1 else 0 end) as cant    
    from interaction_his    
    where tipo_recurso='agent' and tipo_interaction='inbound'and dbo.dmy(fecha) between dbo.dmy(@HASTA-8) and  @HASTA+1    
    group by dbo.dmy(fecha),login