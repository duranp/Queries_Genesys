  SELECT CONVERT(VARCHAR(10),A.FECHA,108),CONVERT(VARCHAR(10),DBO.DMY(A.FECHA),103)DIA,   
 cd_triada, pcrc,


  SUM(TALKTIME+NRR5)TT, 
SUM(ANSWERED-SHORTCALLS) ANSWERED, 
REPLACE(cast((sum(logintime)-(sum(notreadytime)-sum(nrr4)-sum(nrr5))) / 900 as decimal(8,2)),'.',',') L,  

  (Case sum(talktime)+ sum(readytime) + SUM(isnull(nrr5,0)) + SUM(isnull(nrr1,0))+ SUM(isnull(nrr2,0))+ SUM(isnull(nrr3,0))+ SUM(isnull(nrr6,0))+ SUM(isnull(nrr7,0))+ SUM(isnull(nrr8,0)) when '0' Then '0'        
  Else         
  100* convert(decimal(12,2),(sum(talktime)+ sum(isnull(nrr5,0))+ sum(readytime)) /cast(sum(talktime)+ sum(readytime) + SUM(isnull(nrr0,0)) + SUM(isnull(nrr1,0))+ SUM(isnull(nrr2,0))+ SUM(isnull(nrr3,0))+ SUM(isnull(nrr5,0)) + SUM(isnull(nrr6,0))+ SUM(isnull(nrr7,0))+ SUM(isnull(nrr8,0)) as decimal(12,2)))end) Util,  
  (CASE SUM(TALKTIME)+SUM(nrr5)+sum(nrr4)+sum(readytime) WHEN '0' THEN '0' ELSE        
  CAST(100*((SUM (talktime)+sum(isnull(nrr5,0))+sum(isnull(nrr4,0)))/ CAST(SUM(ISNULL(nrr5,0))+SUM(ISNULL(nrr4,0))+sum(talktime)+sum(readytime)AS DECIMAL(12,2) ))AS DECIMAL(12,2))END) Ocup,  
  sum(nrr2+nrr3+nrr7) capa,  
  
  (Case sum(talktime)+ sum(readytime) + SUM(isnull(nrr5,0)) + SUM(isnull(nrr1,0))+ SUM(isnull(nrr2,0))+ SUM(isnull(nrr3,0))+ SUM(isnull(nrr6,0))+ SUM(isnull(nrr7,0))+ SUM(isnull(nrr8,0)) when '0' Then '0'        
  Else         
  100* convert(decimal(12,2),(sum(talktime)+ sum(isnull(nrr5,0))+ sum(readytime)) )end) Util_nume,  
  
  (Case sum(talktime)+ sum(readytime) + SUM(isnull(nrr5,0)) + SUM(isnull(nrr1,0))+ SUM(isnull(nrr2,0))+ SUM(isnull(nrr3,0))+ SUM(isnull(nrr6,0))+ SUM(isnull(nrr7,0))+ SUM(isnull(nrr8,0)) when '0' Then '0'        
  Else         
  cast(sum(talktime)+ sum(readytime) + SUM(isnull(nrr0,0)) + SUM(isnull(nrr1,0))+ SUM(isnull(nrr2,0))+ SUM(isnull(nrr3,0))+ SUM(isnull(nrr5,0)) + SUM(isnull(nrr6,0))+ SUM(isnull(nrr7,0))+ SUM(isnull(nrr8,0)) as decimal(12,2))end) Util_deno,  
    
  (CASE SUM(TALKTIME)+SUM(nrr5)+sum(nrr4)+sum(readytime) WHEN '0' THEN '0' ELSE        
  CAST(100*((SUM (talktime)+sum(isnull(nrr5,0))+sum(isnull(nrr4,0))))AS DECIMAL(12,2))END) Ocup_nume,  
    
  (CASE SUM(TALKTIME)+SUM(nrr5)+sum(nrr4)+sum(readytime) WHEN '0' THEN '0' ELSE        
  CAST(( CAST(SUM(ISNULL(nrr5,0))+SUM(ISNULL(nrr4,0))+sum(talktime)+sum(readytime)AS DECIMAL(12,2) ))AS DECIMAL(12,2))END) Ocup_deno  
  
select distinct tx_stat from stats_ppp where tx_stat like '%total_ready%'
--select A.FECHA, cd_triada, sum(1)  
  FROM AGENT_HIS A 
		INNER JOIN ROSTER_CM R ON A.LOGIN = R.NAME  
		inner join triada_asistente t on a.login = t.name  
  WHERE a.FECHA  between '01/08/2012' and '18/08/2012' and datepart(hour,fecha) between 9 and 15 AND DATEPART(WEEKDAY,FECHA) NOT IN (6,7)
  GROUP BY  A.FECHA, cd_triada, pcrc
order by cd_triada,a.fecha

