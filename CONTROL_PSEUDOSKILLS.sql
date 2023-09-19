
select skill, sum(entered) 
from skill_day_SL s
        left join pseudoskill p 
			on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill
where dbo.f(date_time) >= '01/08/2011' and segmento is null
group by skill order by sum(entered) desc
