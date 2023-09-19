
select CCTDESCSUBMOTIVO, fecha, sum(1) from casos c 
	LEFT JOIN SUBMOTIVO S ON C.CCTSUBMOTIVOID = S.CCTSUBMOTIVOID  
	left join #fechas f on f.fecha > c.swdatecreated and f.fecha < isnull(c.swdateresolved, getdate())
where C.CCTSUBMOTIVOID in(5990,6054,5989)
group by CCTDESCSUBMOTIVO, fecha
ORDER BY CCTDESCSUBMOTIVO, fecha

select fecha, sum(1) from casos c 
	left join #fechas f on f.fecha > c.swdatecreated and f.fecha < isnull(c.swdateresolved, getdate())
where C.CCTSUBMOTIVOID in(5990,6054,5989)
group by fecha
ORDER BY fecha

select year(swdateresolved), month(swdateresolved), sum(1) from casos where CCTSUBMOTIVOID in(5990,6054,5989)
group by year(swdateresolved), month(swdateresolved)
order by year(swdateresolved), month(swdateresolved)

select year(swdatecreated), month(swdatecreated), sum(1) from casos where CCTSUBMOTIVOID in(5990,6054,5989)
group by year(swdatecreated), month(swdatecreated)
order by year(swdatecreated), month(swdatecreated)


select *  from casos c left join #fechas f on f.fecha > c.swdatecreated and f.fecha < isnull(c.swdateresolved, getdate())
where  CCTSUBMOTIVOID in(5990,6054,5989) and fecha = '30/04/2011'

select * from submotivo where CCTSUBMOTIVOID in(5990,6054,5989)

insert into #fechas values(getdate()-1)

select distinct submotivo from vw_casos
where motivo = 'bajas' and submotivo like 'retenido%'

create table #fechas(fecha smalldatetime)

insert into #fechas values('01/01/2010')


INSERT INTO PENDIENTES
select SWDATECREATED SWDATERECEIVED, 'BAJAS' SWRECEIVER, NULL SWACTIONTAKEN, NULL SWDATEACTIONTAKEN, SWCASEID, SWDATECREATED, SWCUSTOMERID from CASOS
  WHERE CCTSUBMOTIVOID in(5990,6054,5989) and swstatus = 'abierto'   




SELECT MAX(DATE), segmento FROM TRAE_ERLANG group  by segmento
order by MAX(DATE)