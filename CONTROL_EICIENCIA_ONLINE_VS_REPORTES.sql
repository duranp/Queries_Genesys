--todo un dia en particular
select * from (
select case when grouping(pseudoskill) = 1 then 'Total' else pseudoskill end pseudoskill,                             
 sum(abandoned)+sum(answered) ofr, sum(abandoned) AB, SUM(ANSWERED) AT,                            
 case when sum(abandoned) = 0 then 0 else CAST(sum(abandoned)/(sum(abandoned)+sum(answered))*100.0 AS DECIMAL(6,2)) end TA,                       
 case when SUM(CASE WHEN SL = 20 THEN ANS_20 ELSE ANS_40 END) = 0 then 100.00 else CAST(SUM(CASE WHEN SL = 20 THEN ANS_20 ELSE ANS_40 END)/(SUM(ANSWERED)+SUM(ABANDONED))*100 AS DECIMAL(6,2)) end SL                                 
 from skill_day s                                       
 inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(skill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill                                  
 AND ATENCION = 'com' and dbo.f(date_time) = dbo.dmy(getdate()-1)
 group by pseudoskill with rollup 
)s 
left join 
(
select        
case when grouping(tx_vq) = 1 then 'Total' else tx_vq end tx_vq,        
sum(case when tx_stat = 'Total_Calls_Answered' then valor else 0 end) AT,        
sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end) AB,        
sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end) OFR,        
sum(case when tx_stat = 'CurrNumberWaitingCalls' then valor else 0 end) Wait,        
cast(case when sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end) = 0 then 0 else sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end)*1.0 /sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end)*100.0   
end as numeric(6,2)) TA        
from stats_online s left join (select distinct replace(pseudoskill,'_oun','') ps, atencion from pseudoskill) p on replace(s.tx_vq,'vq_','') collate Modern_Spanish_CS_AS = ps collate Modern_Spanish_CS_AS        
where dbo.dmy(getdate()-1) = dbo.dmy(timestamp)  and atencion in ('com')      
group by tx_vq with rollup        
)o
on s.pseudoskill = replace(tx_vq,'vq_','') 



--una cola en particular

select * from (
select day(dbo.f(date_time))dia, pseudoskill,                             
 sum(abandoned)+sum(answered) ofr, sum(abandoned) AB, SUM(ANSWERED) AT,                            
 case when sum(abandoned) = 0 then 0 else CAST(sum(abandoned)/(sum(abandoned)+sum(answered))*100.0 AS DECIMAL(6,2)) end TA,                       
 case when SUM(CASE WHEN SL = 20 THEN ANS_20 ELSE ANS_40 END) = 0 then 100.00 else CAST(SUM(CASE WHEN SL = 20 THEN ANS_20 ELSE ANS_40 END)/(SUM(ANSWERED)+SUM(ABANDONED))*100 AS DECIMAL(6,2)) end SL                                 
 from skill_day s                                       
 inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(skill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill                                  
 AND ATENCION = 'com' and dbo.f(date_time) between  dbo.dmy(getdate()-1) and getdate()
and skill like 'Comercial_competencia_fm%'
 group by pseudoskill,day(dbo.f(date_time)) --with rollup 
)s 
left join 
(
select        day(dbo.dmy(timestamp))dia, tx_vq,        
sum(case when tx_stat = 'Total_Calls_Answered' then valor else 0 end) AT,        
sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end) AB,        
sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end) OFR,        
sum(case when tx_stat = 'CurrNumberWaitingCalls' then valor else 0 end) Wait,        
cast(case when sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end) = 0 then 0 else sum(case when tx_stat = 'Total_Calls_Abandoned' then valor else 0 end)*1.0 /sum(case when tx_stat = 'Total_Calls_Entered' then valor else 0 end)*100.0   
end as numeric(6,2)) TA        
from stats_online s left join (select distinct replace(pseudoskill,'_oun','') ps, atencion from pseudoskill) p on replace(s.tx_vq,'vq_','') collate Modern_Spanish_CS_AS = ps collate Modern_Spanish_CS_AS        
where dbo.dmy(timestamp)between dbo.dmy(getdate()-1) and getdate() and atencion in ('com')   and tx_vq = 'vq_Comercial_competencia_fm'   
group by tx_vq,day(dbo.dmy(timestamp)) --with rollup        
)o
on s.pseudoskill = replace(tx_vq,'vq_','') and s.dia = o.dia


select distinct pseudoskill from interaction_det 
where REPLACE(REPLACE(dbo.splitindex(pseudoskill,'|',0),'_apy',''),'_TRIADA','')  = 'Comercial_Competencia'
and dbo.dmy(dbo.f(fecha_inicio)) = '20130115'