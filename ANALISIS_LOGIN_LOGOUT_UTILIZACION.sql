drop table #roster
SELECT * INTO #roster FROM OPENQUERY(GE2,'
SELECT To_date(start_time,''yyyymmddhh24miss'')DESDE,
To_date(END_time,''yyyymmddhh24miss'')HASTA,  
ID_AGENTE, SKILL
FROM CONTACT.SKILL_AGENT_STAMP
where skILL IN (''PCRC_TECNICO_TOP'',''PCRC_COMERCIAL_TOP'',''PCRC_COMERCIAL_ALTOS'')
and id_agente not in (SELECT id_agente FROM CONTACT.SKILL_AGENT_STAMP where lower(skILL) like ''%atento%'')
')

SELECT T.*, N.NETO FROM   (
    SELECT     MONTH(FECHA)FECHA,SKILL, SUM(1)Q, 
    REPLACE(SUM(CASE WHEN SKILL LIKE '%COMER%' THEN 7.0 ELSE 6.5 END),'.',',') TEORICO
    FROM        copc.dbo.getFechasCOPC('01/08/2012',getdate(),1,5,0) c 
    INNER JOIN  #ROSTER R ON C.FECHA BETWEEN DESDE AND HASTA
    GROUP BY MONTH(FECHA), skill
    ) T
INNER JOIN 
                (
    select MONTH(dia)FECHA, skill, 
    replace(SUM(datediff(minute,login,logout)/60.0),'.',',')NETO
    from agent_lilo a 
        inner join #roster r on dbo.usr(a.agent) = r.id_agente and a.dia between r.desde and r.hasta
        inner join copc.dbo.getFechasCOPC('01/08/2012',getdate(),1,5,0) c on a.dia = c.fecha
    GROUP BY MONTH(dia), skill
    )N
ON T.FECHA = N.FECHA AND T.SKILL = N.SKILL
ORDER BY T.FECHA, T.SKILL






select MONTH(dia), PCRC, 
replace(SUM(datediff(minute,login,logout)/60.0),'.',',')NETO
--, SUM(CASE WHEN PCRC LIKE '%COMERC%' THEN 7 ELSE 6.5 END) TEORICO
--replace(datediff(minute,login,logout)/60.0,'.',','), pcrc 
from agent_lilo a 
    inner join roster_cm r on dbo.usr(a.agent) = r.name 
    --inner join #roster r on dbo.usr(a.agent) = r.id_agente and a.dia between r.desde and r.hasta
    inner join copc.dbo.getFechasCOPC('01/08/2012',getdate(),1,5,0) c on a.dia = c.fecha
where pcrc in ('VAG_PCRC_TECNICO_TOP','VAG_PCRC_COMERCIAL_TOP','VAG_PCRC_COMERCIAL_ALTOS') and fc_baja is null
and (vag like 'vag_cc_mercedes%' OR VAG LIKE 'VAG_CC_LEZICA%')
GROUP BY MONTH(dia), PCRC
ORDER BY MONTH(dia), PCRC



