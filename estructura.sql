select * into ESTRUCTURA2 from openquery(d,'select c.tasa_clie_codigo, p1.swlogin a1, p2.swlogin a2, p3.swlogin a3
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
select * from vtv..gestor
select coalesce(p.cd_party,c.cd_party,e.tasa_clie_codigo) cd_party, t.tx_tipo_cliente, c.cd_triada, c.name, e.a1,e.a2,e.a3, g.name gestor
	from dw..party p 
	inner join dt_tipo_cliente t on p.cd_tipo_cliente = t.cd_tipo_cliente
	full join cartera c on p.cd_party = c.cd_party
	full join vtv..gestor g on c.cd_triada = g.cd_triada
	full join estructura e on e.tasa_clie_codigo = p.cd_party
	
select * from estructura where tasa_clie_codigo not in (select cd_party from dw..party)
SELECT NULL-3
select sum(1) from dw..party where cd_party not in (select cd_party_titular from dw..parque)

select * from agent_state

