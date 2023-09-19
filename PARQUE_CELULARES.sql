


select * into #temp from openquery(d,'
select case when p.swdatemodified is null then p.swdatecreated else p.swdatemodified end fecha, C.TASA_CLIE_CODIGO
from swbapps.sw_person  P, SWBAPPS.SW_CUSTOMER C where swofficephone like ''15%'' and P.SWCUSTOMERID = C.SWCUSTOMERID')

select tx_tipo_cliente, sum(1), (select sum(1) from dw..party p2 inner join dt_tipo_cliente tc2 on p2.cd_tipo_cliente = tc2.cd_tipo_cliente where tx_tipo_cliente = tc.tx_tipo_cliente )
from #temp t 
	inner join dw..party p on t.tasa_clie_codigo = p.cd_party
	inner join dt_tipo_cliente tc on p.cd_tipo_cliente = tc.cd_tipo_cliente
group by tx_tipo_cliente
order by tx_tipo_cliente
