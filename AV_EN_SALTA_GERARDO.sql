SELECT * FROM ROSTER_CM WHERE LASTNAME IN ('FUSCO','LAMBIASSE','VANEGAS','GAGLIARDO','ALBANESE','RETEGUI') ORDER BY FIRSTNAME
SELECT * INTO #P FROM [INDICADORES].POSVENTA.DBO.PARQUE_BASICA
DROP TABLE #PQ_CART
SELECT * INTO #PQ_CART FROM CARTERA C INNER JOIN #P P ON C.CD_PARTY = P.CD_PARTY_TITULAR -20000000000

drop table #interaction
select * into #interaction from openquery(ge, 'select ir.tipo_interaction, i.gvp_categ_cliente,ir.interaction_id, ir.fecha_inicio, ir.tipo_recurso, ir.nombre_recurso, i.gvp_postdiscado, ir.pseudoskill, ir.resultado_tecnico, ir.resultado_tecnico_ampliado
from contact_unpre.interac_resource_201107 ir
        inner join contact_unpre.interaction_201107 i
                on ir.interaction_id = i.interaction_id
where ir.fecha_inicio >= ''20110718000000''')

SELECT interaction_id, resultado_tecnico, dbo.f(fecha_inicio), I.GVP_POSTDISCADO,i.pseudoskill, atencion, P.CD_PARTY, sup, dbo.usr(I.nombre_recurso) login, T.CD_TRIADA, P.NAME,P.CD_TRIADA, GVP_CATEG_CLIENTE, TX_TIPO_CLIENTE, DBo.CONCATENATE(RD.AGENT)
FROM #interaction i 
	INNER JOIN #PQ_CART P ON I.GVP_POSTDISCADO = P.ANI
	LEFT JOIN (SELECT DISTINCT  CD_TRIADA, NAME FROM CARTERA) T ON dbo.usr(I.nombre_recurso) = T.NAME
	LEFT JOIN DT_TIPO_CLIENTE TC ON I.GVP_CATEG_CLIENTE = TC.CD_TIPO_CLIENTE
	inner join pseudoskill s on REPLACE(dbo.splitindex(i.pseudoskill,'|',0),'_apy','') = s.pseudoskill and atencion = 'com'
	inner join roster_cm r on dbo.usr(I.nombre_recurso) = r.name
	left join #ready rd on p.cd_triada = rd.cd_triada AND dbo.f(I.FECHA_INICIO) BETWEEN Rd.FI AND Rd.FF
where dbo.f(fecha_inicio) >= '18/07/2011'
and tipo_interaction = 'inbound' AND TIPO_RECURSO = 'AGENT'
GROUP BY interaction_id, resultado_tecnico, dbo.f(fecha_inicio), I.GVP_POSTDISCADO,i.pseudoskill, atencion, P.CD_PARTY, sup, dbo.usr(I.nombre_recurso), T.CD_TRIADA, P.NAME,P.CD_TRIADA, GVP_CATEG_CLIENTE, TX_TIPO_CLIENTE

drop table #ready
select dbo.usr(agent)agent, dbo.f(start_time) fi, dbo.f(end_time)ff, CD_TRIADA into #ready 
from agent_state aa inner join (select distinct cd_triada, name from cartera) c on dbo.usr(agent) = c.name
where state = 'ready' and dbo.f(start_time) >= '18/07/2011'

select * from #ready where isdate(ff)= 0







--gerar 
select fecha, fecha_f, gvp_postdiscado, gvp_categ_cliente, i.pseudoskill, ultimo_recurso,sup, vag, gvp_trf_cdn, tiempo_total
from interaction_his i
	inner join roster_cm r on r.name collate database_default= login
	inner join pseudoskill p on REPLACE(dbo.splitindex(i.pseudoskill,'|',0),'_apy','') = p.pseudoskill     
		and 'com' = atencion and segmento = 'alto valor' and vag = 'VAG_cc_Atento_Salta'
where month(fecha) = 7 and year(fecha) = 2011   
