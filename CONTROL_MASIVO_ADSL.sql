select distinct e.ANI, p.nu_longitud_linea, pr.avg_long,
case when va.cd_central is null then 'NO'
 else
 case  when ve.velocidad = '10mb' and (vs.[10mb] is null or vs.[zona competencia] not in ('z0','z1')) then '5MB'
 when vd.cd_central is not null and ISNULL(P.NU_LONGITUD_LINEA,pr.avg_LONG) between 1 and 900 then '10mb (VDSL)'
    when ISNULL(P.NU_LONGITUD_LINEA,pr.avg_LONG) is null then 's/d'
    else ve.velocidad
 end
end speedy 
from tempdb..escuelas e 
inner join v_parque_tb_sp p on e.ANI = p.ani
left join v_cupos_vdsl vd on vd.cd_central = p.cd_central
left join v_prefa pr on p.cd_central = pr.cd_central and p.cd_manzana = pr.cd_manzana     
left join v_velocidades ve on ISNULL(P.NU_LONGITUD_LINEA,pr.avg_LONG) between ve.minima and ve.maxima
left join v_sinplex_adsl va on p.cd_central = VA.cd_central and va.p_disp_com >= 9   
left join v_disp_speedy vs on p.cd_central = vs.[cod central]   
left join v_max_dslam ds on p.ani = ds.ani  