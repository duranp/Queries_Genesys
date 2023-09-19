delete from pendiente where dbo.dmy(dia) = dbo.dmy(getdate())
insert into pendiente
select dbo.dmy(getdate()) dia, sup, nombres gestor, swactiontaken, sum(1) q, 
sum(case when datediff(day,swdatecreated,getdate()) > 15  then 1 else 0 end) atraso_cliente, 
sum(case when datediff(hour,swdatereceived,getdate()) > 48  then 1 else 0 end) atraso_inbox
from PENDIENTES p inner join roster_bo r on p.swreceiver = r.inbox
group  by sup, nombres, swactiontaken 

select * from roster_bo

select top 10 *  from pendientes

select * from PENDIENTES p inner join roster_bo r on p.swreceiver = r.inbox
where nombres is null

update roster_bo set nombres = inbox where cota is null and inbox is not null


declare @desde smalldatetime, @hasta smalldatetime, @estado1 as varchar(1000), @estado2 as varchar(1000), @estado3 as varchar(1000),  @estado4 as varchar(1000), @estado5 as varchar(1000)
set @desde = getdate()-1
set @hasta = getdate() 
set @estado1 = 'no leido'
set @estado2 = 'leido'
set @estado3 = null
set @estado4 = null
set @estado5 = null

select sup, gestor, sum(q)q, sum(atraso_cliente)atraso_cliente, sum(atraso_inbox)atraso_inbox
from pendiente where dia between @desde and @hasta and 
(swactiontaken = @estado1 or swactiontaken = @estado2 or swactiontaken = @estado3 or swactiontaken = @estado4 or swactiontaken = @estado5)
group by sup, gestor with rollup
