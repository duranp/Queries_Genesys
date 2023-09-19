--campos auxiliares
UPDATE GENESYS..AGENT_day SET LOGIN = substring(agent, charindex('(', agent)+1,len(agent)-charindex('(', agent)-1), fecha = dbo.f(date_time)
where login is null
go



-- inserto en temporal
USE [GENESYS]
GO
/****** Objeto:  Table [dbo].[temporal_agentes]    Fecha de la secuencia de comandos: 08/30/2011 15:28:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temporal_agentes]') AND type in (N'U'))
DROP TABLE [dbo].[temporal_agentes]

select * into genesys..temporal_agentes from (
select  i.*,isnull((cant),0) as [Llamadas contabilizadas], isnull(fcr2,0) as [no rellamaron en 2],    
isnull((fcr7),0) as [no rellamaron en 7], [cantidad casos],ventas,gestion,facturacion,cobros,averias,bajas,quejas,otros,   
isnull(y.q_encuestas,0) q_encuestas ,isnull(y.q_enviados,0) Q_enviados,isnull(y.puntuacion,0) puntuacion,isnull(q_quejas,0) q_quejas   
from (select fecha fecha,  case grouping(replace(vag,'vag_cc_','')) when 1 then 'zzTotal' when 0 then replace(vag,'vag_cc_','') end site,    
case grouping(sup) when 1 then 'aaaTotal' when 0 then (case sup when '' then '[sin sup]' else sup end) end supervisor,case grouping(lastname+', '+firstname+' ('+name+')' ) when 1 then 'aaaTotal' when 0 then lastname+', '+firstname+' ('+name+')' end asistente,    
 sum(ANSWERED) as ANSWERED,
sum(ENTERED) as ENTERED,
sum(LOGINTIME) as LOGINTIME,
sum(READYTIME) as READYTIME,
sum(NOTREADYTIME) as NOTREADYTIME,
sum(NRSINESTADOS) as NRSINESTADOS,
sum(HOLDTIME) as HOLDTIME,
sum(TALKTIME) as TALKTIME,
sum(SHORTCALLS) as SHORTCALLS,
sum(BREAKTIME) as BREAKTIME,
sum(OUTBOUND) as OUTBOUND,
sum(TRANSFERRED) as TRANSFERRED,
sum(NRR0) as NRR0,
sum(NRR1) as NRR1,
sum(NRR2) as NRR2,
sum(NRR3) as NRR3,
sum(NRR4) as NRR4,
sum(NRR5) as NRR5,
sum(NRR6) as NRR6,
sum(NRR7) as NRR7,
sum(NRR8) as NRR8,
sum(NRR9) as NRR9,
sum(NRRNONE) as NRRNONE,
sum(ACW) as ACW
 from genesys..agent_day  as a    
  inner join genesys..roster_cm as r  on r.name collate database_default=a.login collate database_default    and name not in ('ATTCRET011','ATTCRET004','ATTCRET009','ATTCRET012','ATTCRET015','ATTCRET016','ATTCRET020')
 where fecha between case when datepart(day,getdate())<9 then dbo.pd(dateadd(month,-1,getdate())) else dbo.pd(getdate()) end and  getdate() --and sup not like '%colussi%'    
 group by fecha,replace(vag,'vag_cc_',''),sup,lastname+', '+firstname+' ('+name+')'  with rollup ) as i    
left join (    
 select dbo.dmy(en.timestamp)  fecha,case grouping(replace(vag,'vag_cc_','')) when 1 then 'zzTotal' when 0 then replace(vag,'vag_cc_','') end site,    
 case grouping(sup) when 1 then 'aaaTotal' when 0 then (case sup when '' then '[sin sup]' else sup end) end supervisor,case grouping(lastname+', '+firstname+' ('+name+')' ) when 1 then 'aaaTotal' when 0 then lastname+', '+firstname+' ('+name+')' end asistente,    
 sum(p10)Puntuacion, sum(1)Q_enviados, sum(case when e.id_enviado is not null then 1 else 0 end) Q_encuestas, sum(case when q.hash is not null then 1 else 0 end) Q_quejas 
from [10.105.8.249].cate.dbo.e_enviados en 
   left join [10.105.8.249].cate.dbo.e_encuestas e     on e.id_enviado = en.id_enviado     
    left  join [10.105.8.249].cate.dbo.e_quejas q    on en.tx_HASH = q.hash    
    inner join genesys..roster_cm as r  on r.name collate database_default=tx_usuario collate database_default    
 where en.timestamp between case when datepart(day,getdate())<9 then dbo.pd(dateadd(month,-1,getdate())) else dbo.pd(getdate()) end and  getdate()    
 group by dbo.dmy(en.timestamp),replace(vag,'vag_cc_',''),sup,lastname+', '+firstname+' ('+name+')' with rollup) as y on y.site collate database_default=i.site collate database_default and y.supervisor collate database_default=i.supervisor collate database_default and    
 substring(y.asistente, charindex('(', y.asistente)+1,len(y.asistente)-charindex('(', y.asistente)-1) collate database_default=substring(i.asistente, charindex('(', i.asistente)+1,len(i.asistente)-charindex('(', i.asistente)-1) collate database_default   
  and i.fecha=y.fecha
left join (    
select fecha ,case grouping(replace(vag,'vag_cc_','')) when 1 then 'zzTotal' when 0 then replace(vag,'vag_cc_','') end site,    
    case grouping(sup) when 1 then 'aaaTotal' when 0 then (case sup when '' then '[sin sup]' else sup end)  end supervisor,case grouping(lastname+', '+firstname+' ('+name+')' ) when 1 then 'aaaTotal' when 0 then lastname+', '+firstname+' ('+name+')' end asistente,sum(d.fcr2) fcr2,sum(d.fcr7) fcr7,sum(d.cant) cant    
from (select dbo.dmy(fecha) as fecha,login as agent, sum(fcr2*1) as fcr2,sum(fcr7*1)as fcr7,count(fcr7) as cant    
   from interaction_his    
   where tipo_recurso='agent' and tipo_interaction='inbound'and dbo.dmy(fecha)between case when datepart(day,getdate())<9 then dbo.pd(dateadd(month,-1,getdate())) else dbo.pd(getdate()) end and  getdate()+1    
   group by dbo.dmy(fecha),login) as d    
inner join genesys..roster_cm as r  on r.name collate database_default=d.agent collate database_default    
group by fecha,replace(vag,'vag_cc_',''),sup,lastname+', '+firstname+' ('+name+')' with rollup) as f  on i.site=f.site and i.supervisor=f.supervisor and i.asistente=f.asistente  and i.fecha=f.fecha   
left join (
select dbo.dmy(swdatecreated)fecha,case grouping(replace(vag,'vag_cc_','')) when 1 then 'zzTotal' when 0 then replace(vag,'vag_cc_','') end site,    
    case grouping(sup) when 1 then 'aaaTotal' when 0 then (case sup when '' then '[sin sup]' else sup end)  end supervisor,case grouping(lastname+', '+firstname+' ('+name+')' ) when 1 then 'aaaTotal' when 0 then lastname+', '+firstname+' ('+name+')' end asistente,count(*) as [cantidad casos],
sum(case when cctmotivoid = 7 then 1 else 0 end) Ventas,sum(case when cctmotivoid = 103 then 1 else 0 end) gestion,
sum(case when cctmotivoid = 93 then 1 else 0 end) Facturacion,sum(case when cctmotivoid = 83 then 1 else 0 end) Cobros,
sum(case when cctmotivoid = 45 then 1 else 0 end) Bajas,sum(case when cctmotivoid = 3 then 1 else 0 end) Averias,
sum(case when cctmotivoid = 9 then 1 else 0 end) Quejas,sum(case when cctmotivoid not in ( 7,103,93,83,3,9,45) then 1 else 0 end) Otros
from vtv..casos  c
inner join genesys..roster_cm as r  on r.name collate database_default=c.swcreatedby collate database_default 
where convert(datetime,(replace(swdatecreated,'-','')),20) between case when datepart(day,getdate())<9 then dbo.pd(dateadd(month,-1,getdate())) else dbo.pd(getdate()) end and  getdate()+1
group by dbo.dmy(swdatecreated),replace(vag,'vag_cc_',''),sup,lastname+', '+firstname+' ('+name+')'  with rollup) as c on i.site collate database_default =c.site collate database_default and
i.supervisor collate database_default = c.supervisor collate database_default  and i.asistente collate database_default =c.asistente collate database_default  and i.fecha=c.fecha
where I.site<>'lezicabotecnico'  ) as w

--recreo freezing table
delete agent_freeze 
where fecha >= case when datepart(day,getdate())<9 then dbo.pd(dateadd(month,-1,getdate())) else dbo.pd(getdate()) end 
insert into agent_freeze exec sp_freezar_agentes


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temporal_FREEZE]') AND type in (N'U'))
DROP TABLE [dbo].[temporal_FREEZE]

select distinct * into [dbo].[temporal_FREEZE] from agent_freeze
truncate table agent_freeze
insert into agent_freeze select * from [dbo].[temporal_FREEZE]
DROP TABLE [dbo].[temporal_FREEZE]
insert into vitacora values ('GENESYS_DIARIO',GETDATE(), 'DTS')


--borro agentes dados de baja (el caso de agentes que les reasigan id_verint y se duplica)
delete a from agent_freeze a left join roster_cm r on dbo.usr(asistente) = r.name where r.fc_baja < fecha
and fecha >= dbo.pd(dateadd(month,-1,getdate())) and answered = 0 and outbound = 0


--guardo pcrc

update a
set pcrc = r.pcrc
from
agent_freeze a left join roster_cm r on dbo.usr(asistente) = r.name
where a.pcrc is null

