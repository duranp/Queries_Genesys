select DBO.F(date_Time) FECHA, atencion, SEGMENTO, 
sum(abandoned)+sum(answered) ofr, sum(abandoned) AB, 
round(sum(abandoned)/(sum(abandoned)+sum(answered))*100.0,2,2) TA     
from skill_day s           
inner join pseudoskill p on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill     
AND ATENCION IN ('COM','TEC')
group by date_time, atencion, SEGMENTO WITH ROLLUP
order by date_Time, ATENCION, SEGMENTO
