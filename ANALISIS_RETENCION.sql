select sum(answered) from contact.cdn_day where date_time = '20121029000000' and cdn in ('10008136','10008185')


SELECT nombre_recurso, To_date(substr(fecha_inicio,1,8),'yyyymmdd') dia,
sum(case when tipo_interaction = 'Inbound' then 1 else 0 end) Inbound, 
sum(case when tipo_interaction = 'Outbound' then 1 else 0 end) Outbound,
sum(case when tipo_interaction = 'Inbound' then tiempo_recurso else 0 end) Talktime_In, 
sum(case when tipo_interaction = 'Outbound' then tiempo_recurso else 0 end) Talktime_Out
FROM CONTACT.INTERAC_RESOURCE_201210 WHERE ultimo_rp in ('10008136','10008185')
        --and substr(fecha_inicio,1,8) = '20121029' 
        --and tipo_interaction = 'Inbound'
        and resultado_tecnico_ampliado not in ('AbandonedWhileQueued','AbandonedWhileRinging')
        and resultado_tecnico not in ('Redirected','Abandoned')
group by nombre_recurso, To_date(substr(fecha_inicio,1,8),'yyyymmdd')
select * from contact.agent_day where agent = 'Burgos, Marcela (DDC509)' and date_time = '20121002000000'
select sum(answered) from contact.agent_day where 
(contact.usr(agent) in ('RND017','DDC809','ATTCRET008','ATTCRET002','RND099','ATTCRET014','rnd231','RND091','ATTCRET003','ATTCRET006','ATTCRET007','RND129','SUAREZSACTE','RND127','perezmar','RND018','milledc','rnd232','rnd230','baldiac','RND130','DDC522','DDC737','DDC887','DDC834','ALGARBEBCTE','CARIONIDCTE','DUCELCTE','RND000','JAVIERNCTE','RND118CTE','DDC665','ATTCRET017','RND088','RND028','DDC242','ATTCRET013','ATTCRET019','RND153','RND145','RND144','RND151HA','DDE077','turc','sanchezpe','RND108','riosmarial','RND146','RND248','baiza','barretoa','samailr','carusor','FERREIRAIC','RND110','alvarezmariano','perezjuand','RND246','hernandezlucc','RND243','CATOLICAM','RND142','RND026HA','DDC875','DDC707','RND110HA','ferreyrada','dedonatolozanoj','RND109','riedela','ceronfe','RND009','ATTCRET010','gonzalezel','MAGGIOG','saftihca','TCHOLAKIANF','DDC999HA','RND201HA','gonzalezhecto','RND131','RND087','RND056','RND134','RND084','PUJANTEFCTE','rnd238','rnd229','rnd233','RND245','ATTCRET018','rnd235','rnd237','rnd236','DDC986HA','DDC986','DDE076','RND247','RND151CTE','ATTCRET001','DDC876','RND113','RND014HA','RND101HA','gomezbuelaj','DDC577HA','DDC849HA','DDC099HA','RND118HA','RND111HA','RND108HA','RND038HA','RND076HA','RND120','RND104','RND101','ATCHCAL02')
or contact.usr(agent) in ('DDC509','DDC069','DDC799','DDC731','DDC577','DDC849CTE','RND093HA','korostynskil','DDC759','RND014','DDC727','RND038','DDC664HA','rnd135','DDC735HA','DDC735','RND133','RND093','DDC099')
)
and substr(date_time,1,8) = '20121029'

select * from contact.interaction_201210 where  contact.usr(ultimo_recurso) = 'carusor' and substr(fecha_inicio,1,8) = '20121029'

select TRUNC(CAST(TALKTIME/60 AS VARCHAR(10)))||':'||SUBSTR('0'||CAST(MOD(TALKTIME,60) AS VARCHAR(10)),-2), A.* 
from contact.agent_201211 A
where substr(date_time,1,8) = '20121105' and contact.usr(agent) = 'ZCEM98'

SELECT To_date(fecha_inicio,'yyyymmddhh24miss'), To_date(fecha_FIN,'yyyymmddhh24miss'),
(To_date(fecha_FIN,'yyyymmddhh24miss')-To_date(fecha_inicio,'yyyymmddhh24miss'))*86400 SEC,  
CAST(TRUNC((To_date(fecha_FIN,'yyyymmddhh24miss')-To_date(fecha_inicio,'yyyymmddhh24miss'))*1440) AS VARCHAR(3))||':'||
SUBSTR('0'||CAST(MOD((To_date(fecha_FIN,'yyyymmddhh24miss')-To_date(fecha_inicio,'yyyymmddhh24miss'))*86400,60) AS VARCHAR(2)),-2),
I.* 
FROM CONTACT.INTERAC_RESOURCE_201211 I 
WHERE contact.usr(NOMBRE_recurso) = 'ZCEM98' and substr(fecha_inicio,1,8) = '20121105'

select 
--TRUNC(CAST(TOTAL_DURATON/60 AS VARCHAR(10)))||':'||SUBSTR('0'||CAST(MOD(TOTAL_DURATION,60) AS VARCHAR(10)),-2),
A.* from contact.agent_state_201211 A
where contact.usr(agent) = 'ZCEM98'











select 
To_date(fecha_inicio,'yyyymmddhh24miss')inicio, To_date(fecha_FIN,'yyyymmddhh24miss')fin,
(To_date(fecha_FIN,'yyyymmddhh24miss')-To_date(fecha_inicio,'yyyymmddhh24miss'))*86400 S,  
CAST(TRUNC((To_date(fecha_FIN,'yyyymmddhh24miss')-To_date(fecha_inicio,'yyyymmddhh24miss'))*1440) AS VARCHAR(3))||':'||
SUBSTR('0'||CAST(MOD((To_date(fecha_FIN,'yyyymmddhh24miss')-To_date(fecha_inicio,'yyyymmddhh24miss'))*86400,60) AS VARCHAR(2)),-2)mmss,
nombre_recurso, rol_recurso, pseudoskill, ultimo_rp,
i.* 
from CONTACT.INTERAC_RESOURCE_201210 i
where interaction_id = 150429926
order by interaction_resource_id


select ULTIMO_RP, I.* from CONTACT.INTERAC_RESOURCE_201210 i where tipo_interaction = 'Outbound' and resultado_tecnico = 'Abandoned'  AND
NOMBRE_RECURSO = 'SAFTIH BREA, CAMILA BRENDA (saftihca)' 

select * from contact.agent_day where agent like '%SAFTIH%'

SELECT * FROM CONTACT.SKILL_AGENT_STAMP WHERE customer = 'UNPRE' and skill = 'SUP_ROSSINI_LUACES_ANDRES'

select max(end_time), nombre_recurso from CONTACT.SKILL_AGENT_STAMP  group by nombre_recurso

