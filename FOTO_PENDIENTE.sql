
delete from pendiente where dbo.dmy(dia) = dbo.dmy(getdate())
insert into pendiente
select dbo.dmy(getdate()) dia, sup, nombres gestor, swactiontaken, sum(1) q, 
sum(case when datediff(day,swdatecreated,getdate()) > 15  then 1 else 0 end) atraso_cliente, 
sum(case when datediff(hour,swdatereceived,getdate()) > 48  then 1 else 0 end) atraso_inbox
from PENDIENTES p inner join roster_bo r on p.swreceiver = r.inbox
group  by sup, nombres, swactiontaken 

create table obj_pendiente (sup varchar(100), obj tinyint)

select * from roster_bo

select * from pendiente where nombres = 'Giangreco Carla Vanina'
delete from pendiente
insert into pendiente
select dbo.dmy(getdate()) dia, r.sup,nombres,swactiontaken, 
sum(case when dateadd(day,o.obj,swdatecreated) < getdate() then 1 else 0 end) q_atraso_c,
sum(case when dateadd(day,o.obj,swdatereceived) < getdate() then 1 else 0 end) q_atraso_i,
sum(1) q_total,
sum(case when dateadd(day,o.obj,swdatecreated) < getdate() then datediff(hour,dateadd(day,o.obj,swdatecreated) ,getdate())*1.0 end) dias_atraso_c,
sum(case when dateadd(day,o.obj,swdatereceived) < getdate() then datediff(hour,dateadd(day,o.obj,swdatereceived) ,getdate())*1.0 end) dias_atraso_i
from pendientes p inner join roster_bo r on p.swreceiver = r.inbox inner join obj_pendiente o on r.sup = o.sup
--where year(swdatecreated)>= 2011-- and nombres = 'Giangreco Carla Vanina'
group by r.sup, nombres,swactiontaken


select * from pendientes

select datediff(day, swdatecreated, getdate()),* 
from pendientes p inner join roster_bo r on p.swreceiver = r.inbox where nombres = 'Dematei Lucrecia Guillermina'
and  year(swdatecreated)>= 2011

select sum(dias_atraso)*1.0/sum(q_total) from pendiente where nombres = 'Dematei Lucrecia Guillermina'

select *from pendiente where nombres = 'Dematei Lucrecia Guillermina'

select * from pendientes

drop table pendiente
truncate table obj_pendiente
insert into obj_pendiente values('Gestion_Comercial_Especializada',2)
insert into obj_pendiente values('1L_VAG_Aseguramiento_Calidad - Horacio Victor Hugo Tapia',15)
select * from obj_pendiente
select * into pendiente_bkp from pendiente 
select replace(convert(varchar(25), swdatecreated, 104),'.','/') + ' '+ replace(convert(varchar(25), swdatecreated, 114),':000',''),* from pendientes p inner join roster_bo r on p.swreceiver = r.inbox 
where sup = 'Gestion_de_Aseguramiento_de_Calidad'

delete from pendiente where dbo.dmy(dia) = dbo.dmy(getdate())
insert into pendiente
select dbo.dmy(getdate()) dia, sup, nombres gestor, swactiontaken, sum(1) q, 
sum(case when datediff(day,swdatecreated,getdate()) > 15  then 1 else 0 end) atraso_cliente, 
sum(case when datediff(hour,swdatereceived,getdate()) > 48  then 1 else 0 end) atraso_inbox
from PENDIENTES p inner join roster_bo r on p.swreceiver = r.inbox
group  by sup, nombres, swactiontaken 

select * 
 from pendientes p inner join roster_bo r on p.swreceiver = r.inbox inner join obj_pendiente o on r.sup = o.sup
where nombres = 'Valle Veronica Anabel'

select * from pendiente where nombres = 'Valle Veronica Anabel'