

select a.*,ir.* from
(
        select agent, cast(answered as int) answered
        from contact_unpre.AGENT_DAY
        WHERE DATE_TIME = '20110523000000' and answered <> 0
)a
left join
(
        SELECT nombre_recurso, sum(1)q FROM CONTACT_unpre.INTERAC_resource_201105 WHERE FECHA_INICIO
        BETWEEN '20110523000000' AND '20110524000000'
        AND TIPO_RECURSO = 'Agent' AND TIPO_INTERACTION = 'Inbound'
        and resultado_tecnico_ampliado not in ('ABANDONEDWHILEQUEUED','ABANDONEDWHILERINGING','ROUTEONNOANSWER')
        group by nombre_recurso
)ir
on a.agent = ir.nombre_recurso
where a.answered <> ir.q

