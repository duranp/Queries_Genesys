select intervalo, ofr, at, ab, rec_proy, rec_proy-ofr gap from
(
select dbo.f(date_time)Intervalo, sum(entered)ofr, sum(answered)at, sum(abandoned)ab
from skill_his s                 
inner join pseudoskill p on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill      
where atencion = 'com' and segmento <> 'top'
and dbo.dmy(dbo.f(date_time)) = dbo.dmy(getdate())
group by dbo.f(date_time)
)x left join [indicadores\sql2k5].TCS.dbo.TRAE_INFO_GRAFICO e on intervalo = e.date and e.segmento = 'NEG_Total_No_Carterizado_+_AV'
WHERE REC_PROY IS NOT NULL

sp_helptext sp_eficiencia_dia 'com','14/05/2011'

alter procedure sp_eficiencia_dia (@atencion varchar(4), @fecha smalldatetime)        
as        
select isnull(SEGMENTO,'TOTAL ' + @ATENCION) SEGMENTO,         
sum(abandoned)+sum(answered) ofr, sum(abandoned) AB, SUM(ANSWERED) AT,        
CAST(sum(abandoned)/(sum(abandoned)+sum(answered))*100.0 AS DECIMAL(6,2)) TA,   
case when SUM(CASE WHEN SL = 20 THEN ANS_20 ELSE ANS_40 END) = 0 then 100.00 else CAST(SUM(CASE WHEN SL = 20 THEN ANS_20 ELSE ANS_40 END)/SUM(ANSWERED)*100 AS DECIMAL(6,2)) end SL             
from skill_day_SL s                   
inner join pseudoskill p on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill             
AND ATENCION = @atencion and dbo.f(date_time) = @fecha        
group by SEGMENTO with rollup        
order by SUM(ENTERED) DESC 


 sp_eficiencia 'com'