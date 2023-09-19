

SELECT Q.*, A.Q ANIS FROM
(
select sum(1)Q, atencion, SEGMENTO 
from interaction_his i 
	inner join pseudoskill p on REPLACE(dbo.splitindex(i.pseudoskill,'|',0),'_apy','') = p.pseudoskill     
and tipo_interaction <> 'outbound' AND gvp_POSTDISCADO IS NOT NULL
and month(fecha) = 6   
group by atencion, SEGMENTO WITH ROLLUP   
)Q 
	LEFT JOIN 
(
select sum(1)Q,  atencion, SEGMENTO 
from (SELECT DISTINCT GVP_POSTDISCADO, PSEUDOSKILL 
	  FROM interaction_his WHERE tipo_interaction <> 'outbound' AND gvp_POSTDISCADO IS NOT NULL and month(fecha) = 6) i 
	inner join pseudoskill p on REPLACE(dbo.splitindex(i.pseudoskill,'|',0),'_apy','') = p.pseudoskill     
group by atencion, SEGMENTO WITH ROLLUP)A
	ON ISNULL(Q.SEGMENTO,'ALGO') = ISNULL(A.SEGMENTO,'ALGO') AND ISNULL(Q.ATENCION,'ALGO') = ISNULL(A.ATENCION,'ALGO') 