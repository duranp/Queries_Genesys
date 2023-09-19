select r.*, i.fecha from interaction_his i left join roster_cm r on i.login= r.name
where vag = 'vag_cc_atento_cordoba'
and dbo.dmy(fecha) >= '01/09/2011'
and tipo_interaction = 'inbound'
and tipo_recurso = 'agent'
and pseudoskill is null

select * from roster_cm where fc_baja is null

select top 1000 * from interaction_his where

SELECT     dbo.f(START_TIME) fecha_inicio, AGENT, STATE, TOTAL_DURATION, dbo.f(END_TIME) fecha_fin
FROM         AGENT_STATE
WHERE     (dbo.F(START_TIME) BETWEEN '01/08/2011' AND '31/08/2011') AND (dbo.usr(AGENT) IN
                          (SELECT     name
                            FROM          roster_cm
                            WHERE      (vag LIKE '%atento%')))


select * from agent_day