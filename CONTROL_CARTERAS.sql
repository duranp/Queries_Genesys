--BAJO ESTRUCTURA
IF EXISTS(SELECT * FROM SYS.BOJECTS WHERE NAME = 'ESTRUCTURA') DROP TABLE ESTRUCTURA
select * into estructura from openquery(d, 'select c.tasa_clie_codigo, p1.swlogin SWLOGIN1, p2.swlogin SWLOGIN2, p3.swlogin SWLOGIN3
from
SWBAPPS.CCT_ESTRUCTURA_ATENCION e1, SWBAPPS.CCT_ESTRUCTURA_ATENCION e2, SWBAPPS.CCT_ESTRUCTURA_ATENCION e3,
swbapps.sw_customer c,
swbapps.sw_person p1, swbapps.sw_person p2, swbapps.sw_person p3
where
e1.cct_clienteid = e2.cct_clienteid (+)
and e1.cct_clienteid = e3.cct_clienteid (+)
and e1.cct_clienteid = c.swcustomerid
and e1.cct_prioridad = 1 and e2.cct_prioridad  (+) = 2 and e3.cct_prioridad  (+) = 3
and e1.cct_rolid = 1 and e2.cct_rolid (+) = 1 and e3.cct_rolid  (+)= 1
and e1.cct_personaid = p1.swpersonid
and e2.cct_personaid = p2.swpersonid (+)
and e3.cct_personaid = p3.swpersonid (+)')


--CLIENTES EN ESTRUCTURA QUE NO ESTAN EN CARTERA
select e.*, r.firstname, r.lastname, sup, vag, pcrc from estructura E INNER JOIN ROSTER_CM R ON r.NAME = e.SWLOGIN1
WHERE TASA_CLIE_CODIGO NOT IN (SELECT CD_PARTY FROM CARTERA)
AND SWLOGIN1 IN (SELECT NAME FROM CARTERA)

--CONTROL ESTRUCTURA POR CLIENTE EN VANP
SELECT * FROM OPENQUERY(D,'
select E.* from SWBAPPS.CCT_ESTRUCTURA_ATENCION e , swbapps.sw_customer c
where e.cct_clienteid = c.swcustomerid and tasa_clie_codigo = 15103743')

--DIFERENCIAS ASISTENTE 1 TEORICO VS ESTRUCTURA
select C.*, r.firstname+ r.lastname, sup, vag, pcrc  
from cartera c 
inner join estructura e on e.swlogin1 <> c.name and c.cd_party = e.tasa_clie_codigo
INNER JOIN ROSTER_CM R ON r.NAME = e.SWLOGIN1

--CONTROL POR CLIENTE EN AMBAS TABLAS
select * from estructura e INNER JOIN ROSTER_CM R ON r.NAME = e.SWLOGIN1  where tasa_clie_codigo = 139429
select * from cartera where cd_party = 139429

--CONSULTAR USUARIO EN VANP
select swlastname, swfirstname, swlogin from openquery(d,'select * from swbapps.sw_person where swlogin = ''DNS175''')

--INVERTIR USUARIOS
declare @a varchar(10), @b varchar(10)
set @a = 'UNE439'
set @B = 'UNE119'
update cartera 
set 
name = case name when @a then @b when @b then @a ELSE NAME end

--CONTROL DUPLICADOS
select * from cartera where cd_party in (
select cd_party
from 
(SELECT distinct name, cd_party FROM cartera ) x
group by cd_party having sum(1) >1)
order by cd_party

--BORRO LOS QUE NO CORREPONDEN CON MAS DE UN ASISTENTE.
delete c
from cartera c 
inner join estructura e on e.swlogin1 <> c.name and c.cd_party = e.tasa_clie_codigo
INNER JOIN ROSTER_CM R ON r.NAME = e.SWLOGIN1
where cd_party in (
select cd_party
from 
(SELECT distinct name, cd_party FROM cartera ) x
group by cd_party having sum(1) >1)

select * from vtv..clientes c inner join dw..party p on c.tasa_tcli_codigo <> p.cd_tipo_cliente and p.cd_party = c.tasa_clie_codigo

select * from openquery(dw,'select * from tasa.party where cd_party -20000000000 = 13336')

select * from dw..party where cd_party = 13336

select * from vtv..clientes where tasa_clie_codigo not in (select cd_party from dw..party)




select sum(1), MONTH(fecha), year(fecha) from interaction_his
where fecha >= '01/01/2012'
group by MONTH(fecha), year(fecha) 