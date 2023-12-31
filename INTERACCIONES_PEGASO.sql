
--pegaso
CREATE VIEW VW_TRAKING
AS
select      YEAR(E.TIMESTAMP), MONTH(E.TIMESTAMP), SUM(1), sum(1), count(distinct s.cd_pedido)--e.*, p.cd_ani
from  vw_pgc_estados s with (nolock) --salida
            inner join vw_pgc_estados e with (nolock) --entrada
                  on e.cd_pedido = s.cd_pedido
                  and e.cd_sub_pedido = s.cd_sub_pedido
                  and e.cd_tramite = s.cd_tramite
                  and e.cd_orden = s.cd_orden - 1
                  and e.tx_estado_pgc = 'PACTAR CITA'
            inner join pgc_pedidos p
                  on p.cd_pedido = s.cd_pedido
                  and p.cd_sub_pedido = s.cd_sub_pedido
                  and p.cd_tramite = s.cd_tramite
where s.cd_usuario not in ('PGC_SYS','GPYM','COTA')
            and s.tx_estado_pgc <> 'AGENDA'
            and s.timestamp >='01/10/2012'
GROUP BY YEAR(E.TIMESTAMP), MONTH(E.TIMESTAMP)
ORDER BY YEAR(E.TIMESTAMP), MONTH(E.TIMESTAMP)