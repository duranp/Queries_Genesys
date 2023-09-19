
--RESETEO MES ACTUAL Y ANTERIOR
drop table #t
--TEMPORAL PARA TRABAJAR (PERFORMANCE) 
select i.*, p.atencion into #t 
from INTERACTION_HIS I
		inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(I.pseudoskill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill     
where  tipo_recurso = 'agent' and tipo_interaction = 'inbound' AND FECHA >= DBO.PD(DATEADD(MONTH,-1,GETDATE())) 
AND DATEPART(WEEKDAY, FECHA) <>6
GO
--FCR2


update #t 
set fcr2=null
update c
set fcr2 = 0
from #t c
	inner join #t C2
		ON C2.GVP_POSTDISCADO = C.GVP_POSTDISCADO
		AND C2.INTERACTION_ID <> C.INTERACTION_ID
		AND c2.ATENCION = C.ATENCION
		AND C2.FECHA BETWEEN C.FECHA_f AND DATEADD(minute,30,C.FECHA_f) 

GO
UPDATE #T
SET fCR2=1
WHERE FCR2 IS NULL


drop table tempdb..prueba
select * into tempdb..prueba
from #t
GO
