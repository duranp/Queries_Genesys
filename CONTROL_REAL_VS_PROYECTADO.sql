DECLARE @fi SMALLDATETIME, @ff SMALLDATETIME, @SEGMENTO VARCHAR(40)

SET @FI  = '01/04/2012'
SET @FF  = '30/04/2012'


 SELECT A.FECHA INTERVALO, V.pcrc atencion, CAST(CASE WHEN SUM(ANSWERED-SHORTCALLS) = 0 THEN 0 ELSE SUM(TALKTIME+NRR5)/(SUM(ANSWERED-SHORTCALLS)) END AS INT) TMO           
 FROM AGENT_HIS A     
  INNER JOIN ROSTER_CM R ON A.LOGIN = R.NAME     
  inner join vags v  on r.vag = v.tx_vag  AND ISNULL(V.SUP,R.SUP) = R.SUP   
 WHERE FECHA between dbo.dmy(@fi) and isnull(@ff,@ff)   --          AND V.pcrc = @SEGMENTO
 GROUP BY  A.FECHA, V.pcrc         
      
 select  pcrc atencion,           
   fecha intervalo, sum(entered)ofr, sum(answered)at, sum(abandoned)ab , sum(ans_20)  ans_20,sum(ans_40) ans_40,sum(sl) as sl                 
 from skill_his s                                   
 inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(skill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill       
where fecha between @fi and @ff --AND PCRC = @SEGMENTO
 group by pcrc, fecha                 
      
select W.ATENCION, X.INTERVALO, OFR, AT, AB, REC_PROY,       
case when rec_proy = 0 then 0 else cast(((ofr/rec_proy)-1)*100 as numeric(6,2)) end GAP,           
case when ofr = 0 then 0 else cast(ab/ofr*100 as numeric(6,2)) end TA,      
(case at when '0' then '0' else CAST((CASE WHEN SL = 20 THEN ANS_20 ELSE ANS_40 END)/(at+ab)*100 AS DECIMAL(6,2)) end )as SL       
, aG.TMO, W.TMO_PROY,          
case when W.TMO_PROY = 0 then 0 else cast(((AG.TMO*1.0/W.TMO_PROY*100.0)-100) as numeric(6,2)) end GAP_TMO          
from                  
(            
 select  pcrc atencion,           
   fecha intervalo, sum(entered)ofr, sum(answered)at, sum(abandoned)ab , sum(ans_20)  ans_20,sum(ans_40) ans_40,sum(sl) as sl                 
 from skill_his s                                   
 inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(skill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill       
where fecha between @fi and @ff --AND PCRC = @SEGMENTO
 group by pcrc, fecha                 
)x                   
 left join           
(          
 select SEGMENTO ATENCION,  SUM(e.rec_proy) REC_PROY, AVG(e.tmo_proy) TMO_PROY, date intervalo from WFM_LLAMADAS e       
 where date  between dbo.dmy(@fi) and isnull(@ff,@ff) -- AND SEGMENTO = @SEGMENTO      
 GROUP BY SEGMENTO, DATE          
)w          
 on x.intervalo = W.intervalo and x.atencion = W.atencion                  
 left join           
(          
 SELECT A.FECHA INTERVALO, V.pcrc atencion, CAST(CASE WHEN SUM(ANSWERED-SHORTCALLS) = 0 THEN 0 ELSE SUM(TALKTIME+NRR5)/(SUM(ANSWERED-SHORTCALLS)) END AS INT) TMO           
 FROM AGENT_HIS A     
  INNER JOIN ROSTER_CM R ON A.LOGIN = R.NAME     
  inner join vags v  on r.vag = v.tx_vag  AND ISNULL(V.SUP,R.SUP) = R.SUP   
 WHERE FECHA between dbo.dmy(@fi) and isnull(@ff,@ff)   --          AND V.pcrc = @SEGMENTO
 GROUP BY  A.FECHA, V.pcrc         
) ag          
 on x.intervalo = ag.intervalo and x.atencion = ag.atencion       
WHERE OFR > 0 --and x.atencion =@SEGMENTO        
and dbo.dmy(X.intervalo) between dbo.dmy(@fi) and isnull(@ff,@ff)        
order by x.intervalo  

select top 10 * from agent_his

[SP_GET_LLAMADAS_PROY] '01/04/2012','10/04/2012', 'NEG_CARTERIZADO'

 select  pcrc atencion,   fecha Intervalo, sum(entered)ofr, sum(answered)at, sum(abandoned)ab , sum(ans_20)  ans_20,sum(ans_40) ans_40,sum(sl) as sl                 
 from skill_his s                                   
 inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(skill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill       
where  fecha  between '08/05/2012' and '09/05/2012' AND PCRC = 'NEG_Retención_No_Pers'
 group by pcrc, fecha

SELECT SEGMENTO, MAX(DATE) FROM WFM_LLAMADAS GROUP BY SEGMENTO

SELECT SUM(1) FROM SKILL_HIS

UPDATE SKILL_hIS SET FECHA = DBO.F(DATE_TIME) WHERE FECHA IS NULL





 select  pcrc atencion,           
   fecha intervalo, sum(entered)ofr, sum(answered)at, sum(abandoned)ab , sum(ans_20)  ans_20,sum(ans_40) ans_40,sum(sl) as sl                 
 from skill_his s                                   
 inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(skill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill       
where fecha between '01/05/2012' and '08/05/2012'
 group by pcrc, fecha    

select min(fecha) from skill_his where  fecha between '01/05/2012' and '08/05/2012'

SELECT SUM(1) FROM SKILL_HIS WHERE FECHA BETWEEN '01/04/2012' and '30/04/2012'