
--RESETEO MES ACTUAL Y ANTERIOR
UPDATE I 
SET FCR2 = NULL, FCR7 = NULL 
FROM INTERACTION_HIS I
	inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(I.pseudoskill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill AND P.PSEUDOSKILL <> 'Oficinas_Comerciales'        
WHERE 
FECHA >= DBO.PD(DATEADD(MONTH,-1,GETDATE())) 
GO
--TEMPORAL PARA TRABAJAR (PERFORMANCE) 
select i.*, p.atencion into #t 
from INTERACTION_HIS I
		inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(I.pseudoskill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill     
where fcr2 is null AND tipo_recurso = 'agent' and tipo_interaction = 'inbound' AND FECHA >= DBO.PD(DATEADD(MONTH,-1,GETDATE())) 
AND DATEPART(WEEKDAY, FECHA) <>6
GO
--FCR2
update c
set fcr2 = 0
from #t c
	inner join #t C2
		ON C2.GVP_POSTDISCADO = C.GVP_POSTDISCADO
		AND C2.INTERACTION_ID <> C.INTERACTION_ID
		AND c2.ATENCION = C.ATENCION
		AND C2.FECHA BETWEEN C.FECHA AND DATEADD(DAY,2,C.FECHA) 
GO
--FCR7
update c
set fcr7 = 0
from #t c
	inner join #t C2
		ON C2.GVP_POSTDISCADO = C.GVP_POSTDISCADO
		AND C2.INTERACTION_ID <> C.INTERACTION_ID
		AND c2.ATENCION = C.ATENCION
		AND C2.FECHA BETWEEN C.FECHA AND DATEADD(DAY,7,C.FECHA) 

GO
--NO FCR
update INTERACTION_HIS set fcr2 = 0 where INTERACTION_ID in (select INTERACTION_ID from #t where fcr2 = 0)
GO
update INTERACTION_HIS set fcr7 = 0 where INTERACTION_ID in (select INTERACTION_ID from #t where fcr7 = 0)
GO
--FCR PROPIAMENTE DICHO
update INTERACTION_HIS set fcr2 = 1  where fcr2 is null AND tipo_recurso = 'agent' and tipo_interaction = 'inbound'
AND PSEUDOSKILL <> 'Oficinas_Comerciales' and DATEPART(WEEKDAY, FECHA) <>6 
GO
update INTERACTION_HIS set fcr7 = 1  where fcr7 is null AND tipo_recurso = 'agent' and tipo_interaction = 'inbound'
AND PSEUDOSKILL <> 'Oficinas_Comerciales' and DATEPART(WEEKDAY, FECHA) <>6 
GO
DROP TABLE #T
GO
