select e1.*,e2.tx_estado_pgc, e2.cd_usuario, e1.tx_estado_pgc,sum(1) from pgc_estados e1 with (nolock)
inner join pgc_estados e2 with (nolock) on e1.cd_orden = e2.cd_orden +1 and e1.cd_pedido = e2.cd_pedido and e1.cd_sub_pedido = e2.cd_sub_pedido
where e1.tx_estado_pgc = 'pactar cita' and e2.cd_usuario not in ('PGC_SYS','GPYM','COTA') and e2.tx_estado_pgc <> 'AGENDA'
