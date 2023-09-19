select *,case when contestadas > 0 then tt/contestadas
select fecha, replace(cast((sum(logintime)-(sum(notreadytime)-sum(nrrnone))) / 900 as varchar(20)),'.',',') L, sum(1)q, sum(answered) contestadas, sum(entered) entered, 
sum(talktime+nrrnone) tt,
sum(outbound) salientes
from agent_his a 
	left join roster_1l r 
		on a.login collate Modern_Spanish_CI_AS = r.usuario 
where dbo.dmy(fecha) >= dbo.dmy(getdate()-1)
group by fecha

select 0/1
drop table cota_vip

select *
from agent_his a 
	left join roster_1l r on a.login collate Modern_Spanish_CI_AS = r.usuario 
where dbo.dmy(fecha) = dbo.dmy(getdate())

select * from agent_his a 
	left join roster_1l r 
		on a.login collate Modern_Spanish_CI_AS = r.usuario 
where dbo.dmy(fecha) = dbo.dmy(getdate()) and login = 'gce332'

sp_rename 'borrar_c2','borrar_rec_c2'

select * from agent_his where fecha > dbo.dmy(getdate())

select * from borrar_c2
