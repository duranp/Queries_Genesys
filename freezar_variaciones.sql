use genesys

delete freeze_variaciones
where mes between datepart(mm,dbo.pd(dateadd(month,-1,getdate()))) and  datepart(mm,getdate()) 
 and año >= datepart(year,dbo.pd(dateadd(month,-1,getdate())))


insert into freeze_variaciones
select mes,año,pcrc,'Variacion_TMO',case when sum(tmo)=0 then 0 else  STDEVP(tmo)/(avg(tmo)/6) end as variacion_tmo
from (select  datepart(year,fecha) as año,DATEPART(mm,fecha) as mes,SITE,supervisor,asistente,(Case (sum(answered)-sum(SHORTCALLS)) when '0' Then '0'    
Else     
cast((sum(talktime)+sum(nrr5))/(sum(answered)-sum(SHORTCALLS))as decimal(10,2))  
end)  
  as [TMO]
from genesys..agent_freeze as a
inner join genesys..roster_cm as r on a.asistente=r.lastname+', '+r.firstname+' ('+name+')'
group by datepart(year,fecha),DATEPART(mm,fecha),SITE,supervisor,asistente) as f
inner join GENESYS..roster_cm  as r on f.asistente=r.lastname+', '+r.firstname+' ('+name+')'
where mes between datepart(mm,dbo.pd(dateadd(month,-1,getdate()))) and  datepart(mm,getdate()) 
 and año >= datepart(year,dbo.pd(dateadd(month,-1,getdate())))
group by mes,año,pcrc


insert into freeze_variaciones

select mes,año,pcrc,'Variacion_fcr',case when 1-avg(fcr)=0 then 0 else  STDEVP(fcr)/((1-avg(fcr))/6) end as variacion_fcr
from (select  datepart(year,fecha) as año,DATEPART(mm,fecha) as mes,SITE,supervisor,asistente,Case when sum([llamadas contabilizadas])=0  Then '0'    
Else     
(sum([no rellamaron en 7])/cast(sum([llamadas contabilizadas]) as decimal(10,2)))end as fcr
from genesys..agent_freeze as a
inner join genesys..roster_cm as r on a.asistente=r.lastname+', '+r.firstname+' ('+name+')'
group by datepart(year,fecha),DATEPART(mm,fecha),SITE,supervisor,asistente) as f
inner join GENESYS..roster_cm  as r on f.asistente=r.lastname+', '+r.firstname+' ('+name+')'
where mes between datepart(mm,dbo.pd(dateadd(month,-1,getdate()))) and  datepart(mm,getdate()) 
 and año >= datepart(year,dbo.pd(dateadd(month,-1,getdate())))
group by mes,año,pcrc




insert into freeze_variaciones
select mes,año,pcrc,'Variacion_pec',case when 100-avg(pecuf)=0 then 0 else  STDEVP(pecuf)/((100-avg(pecuf))/6) end as variacion_pec
from (select  datepart(year,fecha) as año,DATEPART(mm,fecha) as mes,SITE,supervisor,asistente,Case when sum(pecuf)=0  Then '0'    
Else     
avg(pecuf)end as pecuf
from genesys..agent_freeze as a
inner join genesys..roster_cm as r on a.asistente=r.lastname+', '+r.firstname+' ('+name+')'
group by datepart(year,fecha),DATEPART(mm,fecha),SITE,supervisor,asistente) as f
inner join GENESYS..roster_cm  as r on f.asistente=r.lastname+', '+r.firstname+' ('+name+')'
where mes between datepart(mm,dbo.pd(dateadd(month,-1,getdate()))) and  datepart(mm,getdate()) 
 and año >= datepart(year,dbo.pd(dateadd(month,-1,getdate())))
group by mes,año,pcrc
