
alter procedure sp_get_stats_ppp (@pcrc as varchar(100)=null,@rounded bit = null,@date datetime = null)
as

SELECT s.pcrc, dbo.utc(s.timestamp) timestamp, cast(case when at+ab= 0 then 0 else ab*1.0/(at+ab)*100.0 end as decimal(6,2))TA15,
CallWait,ocio, at+ab Vol,nr_total NR, AgentesLogin, Log15, req_stf 
from (
	select pr.pcrc,timestamp,
	sum(case when tx_stat = 'Total_Calls_Answered' then valor else 0 end) AT,      
	sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end) AB,      
	sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end) OFR,      
	sum(case when tx_stat = 'AGENTES_LOGIN' then valor else 0 end) AGENTESLOGIN,   
	--sum(case when tx_stat = 'Total_Login_Time' then valor else 0 end) LOGINTIME,
	sum(case when tx_stat = 'CurrNumberWaitingCalls' then valor else 0 end) CallWait,
	sum(case when tx_stat = 'CurrNumberWaitStatuses' then valor else 0 end) Ocio,
	cast((sum(case when tx_stat = 'Total_Login_Time' then valor else 0 end)-( sum(case when tx_stat = 'Total_Not_Ready_Time' then valor else 0 end)-sum(case when tx_stat = 'Total_Not_Ready_Time_OTROS   ' then valor else 0 end) ))/900.0 as decimal(4,2)) Log15,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses'then valor else 0 end)NR_TOTAL/*,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_BREAK'then valor else 0 end) [Break],
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_CAPACITACION'then valor else 0 end) Capa,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_COACHING'then valor else 0 end) Coach,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_EXPRESS'then valor else 0 end) Expr,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_LECTURA'then valor else 0 end) Lect,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_OTROS'then valor else 0 end) Otros,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_RESOLUCION'then valor else 0 end) Res,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_TOILETTE'then valor else 0 end) Baño,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_VARIOS'then valor else 0 end) Varios,
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses_VISUAL'then valor else 0 end) Visual*/
	from stats_ppp P 
		LEFT JOIN PCRC PR ON (P.OBJETO = PR.PCRC or p.objeto = PR.vq)	
	where isnull(@pcrc,pr.pcrc)=pr.pcrc and 
		timestamp between isnull(dbo.dmy(@date),getdate()-0.083) and isnull(dbo.dmy(@date+1),getdate())
	and datepart(minute,timestamp)%case when isnull(@rounded,1) = 1 then 15 else 1 end = 0 
	group by pr.pcrc, timestamp
)s
left join trae_erlang e on e.date = dbo.i(s.timestamp) and e.segmento = replace(s.pcrc,'VAG_PCRC_','')
order by s.pcrc, s.timestamp

select dbo.dmy(null)
select getdate()-0.083
select sum(1) from dw..parque
	from stats_ppp P 
		LEFT JOIN PCRC PR ON (P.OBJETO = PR.PCRC or p.objeto = PR.vq)	
	where isnull( 'VAG_PCRC_COMERCIAL_MASIVOS',pr.pcrc)=pr.pcrc and 
		timestamp between isnull(@pcrc,getdate()-0.083) and isnull(dbo.dmy(@pcrc),getdate())
	and datepart(minute,timestamp)%case when isnull(@rounded,1) = 1 then 15 else 1 end = 0 
	group by pr.pcrc, timestamp

select isnull(null,getdate()-0.083), isnull(dbo.dmy(null),getdate())

s sp_get_statsppp

delete from stats_ppp where timestamp = '20120718 10:03'

select cast(dbo.utc(getdate()) as datetime)

select * from pcrc
sp_get_stats_ppp 'VAG_PCRC_COMERCIAL_MASIVOS',0
drop index i_timestamp on stats_ppp
select dbo.utc(getdate())
s f
create function UTC (@datetime as datetime)
returns bigint as
begin 
return cast(datediff(second,'19700101',@datetime) as bigint)*1000
end

delete from stats_ppp where datepart(minute,timestamp)%15 > 0 and timestamp < dbo.dmy(getdate())

select 30%15

delete from stats_ppp where timestamp = '20120718 10:00'

select dateadd(second,1342605600000/1000,'19700101')

select * from bcp_roster_cm

s sp_graph


s sp_get_statsppp_fr

select * from sys.objects where name like '%gra%'



  
ALTER PROCEDURE sp_get_statsppp_fr    
as        
SELECT s.pcrc, timestamp, cast(case when at+ab= 0 then 0 else ab*1.0/(at+ab)*100.0 end as decimal(6,2))TA15,at+ab Vol,rec_proy Vol_proy,
CallWait,ocio, AgentesLogin, nr_total NR, Log15, req_stf req, case when req_stf = 0 then 0 else cast(log15/req_stf as decimal(4,2))*100 end ADH
from (    
	select pr.pcrc, TIMESTAMP,    
	sum(case when tx_stat = 'Total_Calls_Answered' then valor else 0 end) AT,          
	sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end) AB,          
	sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end) OFR,          
	sum(case when tx_stat = 'AGENTES_LOGIN' then valor else 0 end) AGENTESLOGIN,       
	--sum(case when tx_stat = 'Total_Login_Time' then valor else 0 end) LOGINTIME,    
	sum(case when tx_stat = 'CurrNumberWaitingCalls' then valor else 0 end) CallWait,    
	sum(case when tx_stat = 'CurrNumberWaitStatuses' then valor else 0 end) Ocio,    
	(sum(case when tx_stat = 'Total_Login_Time' then valor else 0 end)-( sum(case when tx_stat = 'Total_Not_Ready_Time' then valor else 0 end)-sum(case when tx_stat = 'Total_Not_Ready_Time_OTROS   ' then valor else 0 end) ))/900.0 Log15,    
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses'then valor else 0 end)NR_TOTAL
	from freeze_statsppp P     
		LEFT JOIN PCRC PR ON (P.OBJETO = PR.PCRC or p.objeto = PR.vq)     
	group by pr.pcrc, TIMESTAMP    
)s    
left join trae_erlang e		on e.date = dbo.i(s.timestamp) and e.segmento = replace(s.pcrc,'VAG_PCRC_','')   
left join wfm_llamadas v	on v.date = dbo.i(s.timestamp) and v.segmento =  replace(s.pcrc,'VAG_PCRC_','')   
order by s.pcrc 

select top 10 * from wfm_llamadas order by date desc

alter procedure sp_get_ppp_notready (@pcrc varchar(100))
as
select replace(tx_stat,'CurrNumberNotReadyStatuses_','')tx_stat, valor from freeze_statsppp where objeto = @pcrc and tx_stat like 'CurrNumberNotReadyStatuses_%' and valor >0

sp_get_ppp_notready 'VAG_PCRC_COMERCIAL_MASIVOS'
grant exec on sp_get_ppp_notready to web
select * from act_proceso
update act_proceso set timestamp = getdate()-1
select * from openquery(ge2,'select max(date_time) from contact.skill_201207')


select * from bcp_stats_ppp
select * from freeze_statsppp where objeto like '%rete%'

select * from trae_erlang where date = '19/07/2012 13:00'



	select pr.pcrc,  dbo.i(timestamp),  sum(req_stf),
	sum(case when tx_stat = 'Total_Calls_Answered' then valor else 0 end) AT,          
	sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end) AB,          
	sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end) OFR,          
	sum(case when tx_stat = 'AGENTES_LOGIN' then valor else 0 end) AGENTESLOGIN,       
	--sum(case when tx_stat = 'Total_Login_Time' then valor else 0 end) LOGINTIME,    
	sum(case when tx_stat = 'CurrNumberWaitingCalls' then valor else 0 end) CallWait,    
	sum(case when tx_stat = 'CurrNumberWaitStatuses' then valor else 0 end) Ocio,    
	(sum(case when tx_stat = 'Total_Login_Time' then valor else 0 end)-( sum(case when tx_stat = 'Total_Not_Ready_Time' then valor else 0 end)-sum(case when tx_stat = 'Total_Not_Ready_Time_OTROS   ' then valor else 0 end) ))/900.0 Log15,    
	sum(case when tx_stat = 'CurrNumberNotReadyStatuses'then valor else 0 end)NR_TOTAL
	from freeze_statsppp P     
		LEFT JOIN PCRC PR ON (P.OBJETO = PR.PCRC or p.objeto = PR.vq)     
		left join trae_erlang e		on e.date = dbo.i(timestamp) and e.segmento = replace(pr.pcrc,'VAG_PCRC_','')   
	group by pr.pcrc,  dbo.i(timestamp), req_stf   

select * from trae_erlang where segmento = 'COMERCIAL_TOP' and date = '19/07/2012 13:00'



insert into monitoreo_mail select * from openquery(ge2,'select id,strattribute1 mail, startdate-3/24 startdate, enddate-3/24 enddate, username, subject, structuredtex1 body1, structuredtex2 body2  from contact.monitoreo_mail_201207 where mediatypeid = ''email''')

select id,strattribute1 mail, startdate-3/24 startdate, enddate-3/24 enddate, username, subject, structuredtex1 body1, structuredtex2 body2  from contact.monitoreo_mail_201207 where mediatypeid = 'email'

select * from #t where text1 is not null

DELETE FROM MONITOREO_MAIL WHERE STARTDATE
>= DBO.PD(GETDATE())
select getdate()-(3.0/24)

select * from act_proceso

update act_proceso set timestamp = getdate()-1



select t.*,tx_tipo_cliente  from #t t left join dw..parque p on t.ani = p.ani left join dt_tipo_cliente tc on p.cd_tipo_cliente = tc.cd_tipo_cliente
order by t.ani

select * from pseudoskill where pseudoskill like '%epi%'

select fecha, login, pseudoskill, gvp_postdiscado, gvp_categ_cliente into #t from interaction_his where pseudoskill like 'comercial_competencia_fm%' or pseudoskill like 'Comercial_Episcopado%'
and fecha >= '01/01/2012'

select month(fecha), isnull(p.cd_party_titular,gvp_postdiscado) cliente_o_ani, tx_tipo_cliente,
case	when pseudoskill like 'comercial_competencia_fm%'  then 'competencia_fm'
		when pseudoskill like 'Comercial_Episcopado%' then 'episcaopado'
end tipo_cliente,
sum(1)
 from #t t 
	left join dw..parque p on t.gvp_postdiscado = p.ani
	left join dt_tipo_cliente tc on p.cd_tipo_cliente = tc.cd_tipo_cliente
group by month(fecha), p.cd_party_titular,
case	when pseudoskill like 'comercial_competencia_fm%'  then 'competencia_fm'
		when pseudoskill like 'Comercial_Episcopado%' then 'episcaopado'
end, isnull(p.cd_party_titular,gvp_postdiscado), tx_tipo_cliente


select * from dt_tipo_cliente
update pseudoskill
set vq = 0
where pseudoskill = 'transferencia_multiconferencia'

s sp_get_vqs
select * from roster_cm where pcrc = 'vag_pcrc_comercial_top' and fc_baja is null

select top 0 * into freeze_stats_online from stats_online 
select max(timestamp) from stats_online

s sp_ins_STATS_ONLINE}
s sp_del_stats_online

ALTER PROCEDURE sp_del_stats_online  
as  
delete from bcp_stats_online where dbo.dmy(timestamp) = dbo.dmy(getdate())

ALTER PROCEDURE SP_INS_STATS_ONLINE (@TX_VQ VARCHAR(150), @TX_STAT VARCHAR(30), @VALOR INT)  
AS  
INSERT INTO bcp_STATS_ONLINE (TX_VQ, TX_STAT, VALOR) VALUES (@TX_VQ, @TX_STAT, @VALOR)  


s sp_limpio_statsppp
sp_limpio_stats_online

alter PROCEDURE sp_limpio_stats_online
as  
delete from stats_online where dbo.dmy(timestamp) = dbo.dmy(getdate())
insert into stats_online select * from bcp_stats_online  where dbo.dmy(timestamp) = dbo.dmy(getdate())
delete from freeze_stats_online  
insert into freeze_stats_online select * from bcp_stats_online where dbo.dmy(timestamp) = dbo.dmy(getdate())

select * from freeze_stats_online


s sp_get_stats_online

  
ALTER PROCEDURE SP_INS_STATS_ONLINE (@TX_VQ VARCHAR(150), @TX_STAT VARCHAR(30), @VALOR INT)    
AS    
INSERT INTO bcp_STATS_ONLINE (TX_VQ, TX_STAT, VALOR, timestamp) VALUES (@TX_VQ, @TX_STAT, @VALOR, getdate()) 


delete from bcp_stats_online where  timestamp is null

  
ALTER PROCEDURE sp_get_stats_online (@fecha as smalldatetime= null)      
as      
select      
case when grouping(atencion) = 1 then 'Atencion Total' else atencion end atencion,      
case when grouping(tx_vq) = 1 then 'Total' else tx_vq end tx_vq,      
sum(case when tx_stat = 'Total_Calls_Answered' then valor else 0 end) AT,      
sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end) AB,      
sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end) OFR,      
sum(case when tx_stat = 'CurrNumberWaitingCalls' then valor else 0 end) Wait,      
cast(case when sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end) = 0 then 0 else sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end)*1.0 /sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end)*100.0   
  
    
end as numeric(6,2)) TA      
from freeze_stats_online s left join (select distinct replace(pseudoskill,'_oun','') ps, atencion from pseudoskill) p on replace(s.tx_vq,'vq_','') = ps      
where isnull(dbo.dmy(@fecha),dbo.dmy(getdate())) = dbo.dmy(timestamp)  and atencion not in ('tec_114')    
group by atencion, tx_vq with rollup      
order by case when grouping(tx_vq) = 1 then tx_vq else atencion end asc, sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end) desc 

insert into vitacora_CAMBIOS VALUES(GETDATE(),'NUEVO CIRCUITO: Cuando un cliente carterizado indica que no conoce a su asistente en la encueta postllamado envia un mail informativo al RAC.')

select * from stats_online
where dbo.dmy(timestamp) = dbo.dmy(getdate())

update vitacora_cambios 
set texto = 'NUEVO CIRCUITO: Cuando un cliente carterizado indica que no conoce a su asistente en la encueta postllamado envia un mail informativo al RAC.'
where dbo.dmy(timestamp) = dbo.dmy(getdate())

select * from vitacora_cambios