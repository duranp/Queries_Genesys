


select pv.*, ad.q Programado
from adh_triada ad 
	inner join 
  (
    SELECT p.* FROM 
    (
      SELECT  CD_TRIADA, SUBSTRING(DATE_TIME,9,4) INTERVALO, cast((sum(logintime)-(sum(notreadytime)-sum(nrr4)-sum(nrr5))) / 900 as decimal(8,2))as L
      FROM AGENT_HIS A 
          INNER JOIN VW_TRIADAS T 
              ON A.[LOGIN] = T.NAME   WHERE dbo.dmy(FECHA) = dbo.dmy(GETDATE())
      GROUP BY CD_TRIADA,  SUBSTRING(DATE_TIME,9,4)
    ) X 
    PIVOT (
    SUM(L)
    FOR CD_TRIADA IN ([1],[10],[11],[12],[13],[14],[15],[16],[17],[2],[20],[21],[22],[23],[3],[4],[5],[6],[7],[8],[9])) AS P
	) pv  
on pv.intervalo = ad.intervalo




select * from tempdb..adh_triada where [1] is null