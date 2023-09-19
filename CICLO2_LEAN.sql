declare @date as datetime

set @date = '10/12/2010'

select 
month(swdatecreated)mes,
--sum(case when c14.ani is not null then 1 else 0 end) ciclo14, 
sum(case when c2.ani is not null then 1 else 0 end) ciclo2, 
--sum(case when ci.party is not null then 1 else 0 end) ciclo2
cctdescripcion
	from casos ca 
		left join motivo m    on ca.cctmotivoid = m.cctmotivoid
		left join ciclo14_final c14 on c14.ani = ca.ccttelefonoreclamo
		left join #ciclo2 c2 on c2.ani = ca.ccttelefonoreclamo
where 
--swdatecreated between @date and dateadd(month,5, @date)
year(swdatecreated)=2011
--and month(swdatecreated) <> 2
and swcreatedby not in ('zcem98', 'zcem18')
group by month(swdatecreated),cctdescripcion
having sum(case when c14.ani is not null then 1 else 0 end) >0 or sum(case when c2.ani is not null then 1 else 0 end) > 0
order by month(swdatecreated),cctdescripcion


select 
month(swdatecreated)mes,
sum(case when c14.ani is not null then 1 else 0 end) ciclo14, 
sum(case when c2.ani is not null then 1 else 0 end) ciclo2, 
--sum(case when ci.party is not null then 1 else 0 end) ciclo2
cctdescripcion
	from casos ca 
		left join motivo m    on ca.cctmotivoid = m.cctmotivoid

drop table #p
select * into #p from openquery(indicadores,'select * from posventa..parque_basica')

select *  from ciclos where ciclo in (4,6)


insert into ciclos select * from ciclo_4_6
drop table #anis

select * into #anis from ciclos c inner join #p p on c.[cuenta atis] = p.cd_cuenta_atis

select distinct ciclo from ciclos

select distinct ciclo from #anis

select 
month(swdatecreated)mes,
ciclo,
sum(case when c14.ani is not null then 1 else 0 end) ciclo14, 
--sum(case when c2.ani is not null then 1 else 0 end) ciclo2, 
--sum(case when ci.party is not null then 1 else 0 end) ciclo2
cctdescripcion
	from casos ca 
		left join motivo m    on ca.cctmotivoid = m.cctmotivoid
		left join #anis c14 on c14.ani = ca.ccttelefonoreclamo		
where 
--swdatecreated between @date and dateadd(month,5, @date)
year(swdatecreated)=2011
--and month(swdatecreated) <> 2
and swcreatedby not in ('zcem98', 'zcem18')
group by ciclo, month(swdatecreated),cctdescripcion
having sum(case when c14.ani is not null then 1 else 0 end) >0
order by month(swdatecreated),cctdescripcion




select * from roster_bo
select * from ciclo24_final

update r
set cota = u.swuser
from roster_bo r inner join sw_user u on r.inbox = u.swdefaultinbox where sup = 'ejecutivos'
SELECT * FROM GENESYS..ROSTER_CM WHERE NAME = 'ATT398'

select * from vitacora where [user] = 'tasa\salomonma' order by timestamp desc

select * from roste where swuser = 'PYM174'



select *  from ciclo2 


delete  from ciclo14_final where [cuenta ciclo 05] <> '#n/a'
select sum(1), count(distinct ani) from #ciclo2
/*
select * into ciclo14_old from ciclo14
drop table ciclo14

select * into #p from indicadores.posventa.dbo.parque_basica

select c.*, p.ani into #ciclo2 
from ciclo2 c inner join #p p on c.[cd cuenta atis] = p.cd_cuenta_atis

*/

select * from ciclo14_final


select tx_tipo_cliente, site, campaña, sum(1) from interaction_his i 
	inner join dt_tipo_cliente t 
		on i.gvp_categ_cliente = t.cd_Tipo_cliente 
	left join roster_1l r 
		on login = r.usuario
where dbo.dmy(fecha) = dbo.dmy(getdate()-1)
and tx_tipo_cliente like 'alto v%'
and tipo_interaction = 'inbound' and tipo_recurso = 'agent' and campaña not like '%n t%'
group by tx_tipo_cliente, site, campaña

select * from interaction_his where gvp_categ_cliente is  null and tipo_interaction = 'inbound' and tipo_recurso = 'agent'

select gvp_postdiscado, replace(origen,'+54',''),* 
from interaction_his 
where pseudoskill = 'comercial' and dbo.dmy(fecha) = dbo.dmy(getdate()-1) and tipo_recurso = 'agent'

sp_helptext dmy
CREATE FUNCTION DMY  (@DATE SMALLDATETIME)      
RETURNS SMALLDATETIME AS      
BEGIN     
    
-- RETURN right('0'+cast(day(@DATE) as varchar(2)),2) + '/' + right('0'+cast(month(@DATE) as varchar(2)),2) + '/' + cast(year(@DATE) as char(4))    
 RETURN convert(varchar(10), @date, 103)    
END 

convert(varchar(10),dateadd(day,(-1*day(@date))+1,@date), 103)


SELECT * FROM WFM_LLAMADASdbo.SP_GET_LLAMADAS_PROY

sp_helptext SP_GET_LLAMADAS_PROY

  
CREATE PROCEDURE SP_GET_LLAMADAS_PROY (@DATE SMALLDATETIME, @SEGMENTO VARCHAR(40))        
AS        
select intervalo, ofr, at, ab, rec_proy, cast(((ofr/rec_proy)-1)*100 as numeric(6,2)) gap, cast(ab/ofr*100 as numeric(6,2))  TA from        
(        
select dbo.f(date_time)Intervalo, sum(entered)ofr, sum(answered)at, sum(abandoned)ab        
from skill_his s                         
inner join pseudoskill p on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill              
where atencion = @SEGMENTO and segmento <> CASE WHEN @SEGMENTO = 'COM' THEN 'top' ELSE '' END        
and dbo.dmy(dbo.f(date_time)) = dbo.dmy(@DATE)        
group by dbo.f(date_time)        
)x         
 left join WFM_LLAMADAS e on intervalo = e.date and e.segmento = CASE WHEN @SEGMENTO = 'COM' THEN 'NEG_Total_No_Carterizado_+_AV' ELSE '' END        
WHERE OFR > 0        
order by intervalo 

select intervalo, ofr, at, ab, rec_proy, cast(((ofr/rec_proy)-1)*100 as numeric(6,2)) gap, cast(ab/ofr*100 as numeric(6,2))  TA from        
(        
select  sum(entered)ofr, sum(answered)at, sum(abandoned)ab        
from skill_his s                         
inner join pseudoskill p on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill              
where atencion ='com' and segmento <> 'top' 
and dbo.dmy(dbo.f(date_time)) = dbo.dmy(getdate()-1)        
group by dbo.f(date_time)        
)x         
 left join WFM_LLAMADAS e on intervalo = e.date and e.segmento = CASE WHEN @SEGMENTO = 'COM' THEN 'NEG_Total_No_Carterizado_+_AV' ELSE '' END        
WHERE OFR > 0        
order by intervalo 

sp_helptext sp_eficiencia

select     
             
isnull(segmento,'TOTAL ' + 'com')Segmento,  sum(abandoned)+sum(answered) ofr, round(sum(abandoned)/(sum(abandoned)+sum(answered))*100.0,2,2) TA           
from skill_his s                 
 inner join pseudoskill p on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill                
 and dbo.dmy(dbo.f(date_time)) = dbo.dmy(getdate())+cast(isnull(-1,0) as datetime) and skill <> 'fh' and atencion = 'com'            
group by segmento with rollup              having sum(entered)>0  
order by sum(abandoned)+sum(answered) desc   

sp_helptext sp_eficiencia_dia

SP_VITACORA 'ALGO','OTRO'

SP_HELPTEXT SP_LIMPIO_VAGS

select sum(answered) from skill_day where dbo.dmy(dbo.f(date_Time)) = dbo.dmy(getdate()-1) and skill <> 'fh'

  
ALTER procedure sp_limpio_vags    
as    
delete c    
 from bcp_roster_cm c     
  inner join bcp_roster_cm c2    
   on c.name = c2.name and c.vag <> c2.vag    
  inner join vags v    
   on charindex(c.vag, v.tx_padre)>0 and c2.vag=tx_vag    
delete from roster_cm where firstName + '|' + lastName in (select firstName + '|' + lastName from bcp_roster_cm)    
update roster_cm set fc_baja = getdate() where fc_baja is null    
insert into roster_cm ([name], firstName, lastName, EmployeeID, vag, sup) select [name], firstName, lastName, EmployeeID, vag, sup from bcp_roster_cm    
update roster_cm set sup = replace(sup,'?','ñ')

EXEC SP_VITACORA 'ROSTER_CM','AUTO'

SELECT * FROM VITACORA ORDER BY TIMESTAMP DESC

SELECT * FROM ROSTER_CM WHERE fc_baja is NOT null 

select * from agent_sk_day order by date_time desc

delete from stats_online where timestamp not in (
	select timestamp from stats_online s 
	where timestamp = (select max(timestamp) from stats_online where dbo.dmy(s.timestamp) = dbo.dmy(timestamp)))


select * from stats_online where tx_vq like '%competencia%' order by timestamp desc

select a.*, p.segmento from agent_sk_day a left join pseudoskill p on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill  where atencion = 'tec'  
  

select len(segmento) from pseudoskill where segmento = 'voz'

select * from pseudoskill
  
  

sp_helptext sp_adh

select * from trae_erlang where segmento = 'neg_comercial_atento' and dbo.dmy(date) = dbo.dmy(getdate())
order by date

select * from sys.objects where type ='p' and name like '%ccpulse%'

sp_helptext sp_ccpulse_req

  
alter procedure sp_ccpulse_req   
@segmento varchar(100)  
as  
SELECT sum(req_stf) FROM TRAE_ERLANG WHERE GETDATE() BETWEEN DATE and DATEADD(Minute,15,DATE) 
and case when segmento in ('NEG_Mercedes_No_Personalizado','NEG_Mercedes_Personalizado') then 'Mercedes' else segmento end = @segmento
  
  
  
  
select month(cctfechacontacto)mes , vag, sum(1)q, sum(case when swpersonid is not null then 1 else 0 end) con_mail, sum(case when dbo.dmy(cctfechacontacto) = dbo.dmy(swdatecreated) then 1 else 0 end) creado from hoy h left join contacto c on h.cctpersonid = c.swpersonid
inner join genesys..roster_cm r on h.swcreatedby = r.name
group by month(cctfechacontacto),vag
order by month(cctfechacontacto),vag
  
  
  
  
  
  
  

select * from stats_online s
	left join pseudoskill p 
		on replace(REPLACE(tx_vq,'_apy',''),'vq_','') = p.pseudoskill 

s sp_pendientes

alter procedure sp_pendientes(@action varchar(10)=null, @not_action varchar(10)=null, @tx_tipo_cliente varchar(50)=null, @tx_gestor varchar(50)=null, @GRP VARCHAR(10) = NULL, @triada varchar(50) = null)                         
as                                
select CASE GROUPING(sup) WHEN 1 THEN 'TOTAL' WHEN 0 THEN SUP END SUP,                                 
CASE GROUPING(ISNULL(nombres,SWRECEIVER)) WHEN 1 THEN 'TOTAL' WHEN 0 THEN ISNULL(nombres,SWRECEIVER) END NOMBRES,                                
sum(1)Q,                            
isnull(avg(case when datediff(hour,i.swdatecreated,getdate())>48 then (datediff(hour,i.swdatecreated,getdate())-48)/24.0 else null end),0) 'tm_atraso(dias)',                              
round(SUM(CASE WHEN datediff(hour,i.swdatecreated,getdate()) <=48                THEN 1 ELSE 0 END)*1.0 / SUM(1)*100.0,2) '%0-2 T',                                
round(SUM(CASE WHEN datediff(hour,i.swdatecreated,getdate()) between 49  and 120 THEN 1 ELSE 0 END)*1.0 / SUM(1)*100.0,2) '%3-5 T',                                
round(SUM(CASE WHEN datediff(hour,i.swdatecreated,getdate()) between 121 and 168 THEN 1 ELSE 0 END)*1.0 / SUM(1)*100.0,2) '%5-7 T',                                
round(SUM(CASE WHEN datediff(hour,i.swdatecreated,getdate()) >169                THEN 1 ELSE 0 END)*1.0 / SUM(1)*100.0,2) '%>=8 T',                                
isnull(avg(case when datediff(hour,i.swdatereceived,getdate())>48                then (datediff(hour,i.swdatereceived,getdate())-48)/24.0 else null end),0) 'tm_atraso(dias)',                              
round(SUM(CASE WHEN datediff(hour,i.swdatereceived,getdate()) <=48                THEN 1 ELSE 0 END)*1.0 / SUM(1)*100.0,2) '%0-2 i',                                
round(SUM(CASE WHEN datediff(hour,i.swdatereceived,getdate()) between 49  and 120 THEN 1 ELSE 0 END)*1.0 / SUM(1)*100.0,2) '%3-5 i',                                
round(SUM(CASE WHEN datediff(hour,i.swdatereceived,getdate()) between 121 and 168 THEN 1 ELSE 0 END)*1.0 / SUM(1)*100.0,2) '%5-7 i',                        
round(SUM(CASE WHEN datediff(hour,i.swdatereceived,getdate()) >169                THEN 1 ELSE 0 END)*1.0 / SUM(1)*100.0,2) '%>=8 i',
(select   sum(1) from pendientes i2 where i2.swactiontaken = 'gestionado' and i2.swreceiver = i.swreceiver) q_gest                                           
from PENDIENTES i       
 inner join roster_bo r on i.swreceiver COLLATE Latin1_General_CS_AS =r.inbox COLLATE Latin1_General_CS_AS        
 inner join casos c on  c.swcaseid = i.swcaseid       
 inner join clientes cl on c.swcustomerid = cl.swcustomerid      
 Left join dt_tipo_cliente t on cl.tasa_tcli_codigo = t.cd_tipo_cliente      
 left join genesys..cartera ca on cl.tasa_clie_codigo = ca.cd_party    
where                   
(isnull(@not_action,'vargas')<>swactiontaken AND isnull(@action,swactiontaken) = swactiontaken OR SWACTIONTAKEN IS NULL)            
and swdatereceived > dateadd(year,-2,getdate())      
and isnull(@tx_tipo_cliente,t.tx_Tipo_cliente) = t.tx_Tipo_cliente      
AND ISNULL(@GRP,T.GRP) = T.GRP   
and isnull(@tx_gestor,isnull(ca.name,'algo')) = isnull(ca.name,'algo')    
and isnull(@triada,isnull(cast(ca.cd_triada as varchar(50)),'algo')) = isnull(cast(ca.cd_triada as varchar(50)),'algo')    
group by sup ,ISNULL(nombres,SWRECEIVER) with rollup                                
order by sup desc,case grouping(ISNULL(nombres,SWRECEIVER)) when 1 then 'zzzTotal' when 0 then ISNULL(nombres,SWRECEIVER) end desc         








select * from v_parque_tb_sp