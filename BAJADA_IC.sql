drop table borrar_ic

SELECT distinct p.ani, pe.cd_central, pe.MANZANA cd_manzana,-- 'YO' NORTE,                       
case when                       
cast(                      
case when pe.porc_sat_caja > 0 and pe.porc_sat_caja > pe.porc_sat_arm then pe.porc_sat_caja                       
  when pe.porc_sat_arm > 0 and pe.porc_sat_arm > pe.porc_sat_caja then pe.porc_sat_arm                      
  when  pe.porc_sat_arm = 0 then pe.porc_sat_caja                       
  when  pe.porc_sat_caja = 0 then pe.porc_sat_arm                      
end as real) >=90 then 'no' else 'si' end pe,                       
case when pi.cv > 50 then 'si' else 'no' end pi,                      
case when vv.[cod central] is not null then 'si' else 'no' end voip,                      
case when vf.cd_central is not null then 'si' else 'no' end fwt,                      
ISNULL(P.NU_LONGITUD_LINEA,pr.avg_LONG) long,                       
case when va.cd_central is null then 'NO'                    
 else                     
 case  when ve.velocidad = '10mb' and (vs.[10mb] is null or vs.[zona competencia] not in ('z0','z1')) then '5MB'                      
 when vd.cd_central is not null and ISNULL(P.NU_LONGITUD_LINEA,pr.avg_LONG) between 1 and 900 then '10mb (VDSL)'    
    when ISNULL(P.NU_LONGITUD_LINEA,pr.avg_LONG) is null then 's/d'                    
    else ve.velocidad                       
 end                  
end speedy,   
case when ds.v1 = 0 then cast(ds.v2 as varchar(10))+ ' caja' else cast(ds.v1 as varchar(10))+ ' linea' end dslam,                 
case when zp.mz_pg is null then 'NO' ELSE zp.mz_pg END MZ_PG     
into borrar_ic
FROM v_parque_tb_sp p         
left join v_pe  Pe on  P.cd_CENTRAL = PE.CD_CENTRAL AND PE.MANZANA = P.CD_MANZANA  
left join v_pi pi on pe.cd_central = pi.cntcd             
left join v_prefa pr on pe.cd_central = pr.cd_central and pe.manzana = pr.cd_manzana                                       
left join v_disp_voip vv on pe.cd_central = vv.[cod central]                      
left join v_disp_speedy vs on pe.cd_central = vs.[cod central]                      
left join v_disp_fwt vf on pe.cd_central = vf.cd_central                      
left join v_sinplex_adsl va on pe.cd_central = VA.cd_central and va.p_disp_com >= 9                    
left join v_zonas z on pe.cd_central = z.[cod central]                    
left join v_zona_peligrosa zp on pe.cd_central = zp.cd_central and pe.manzana = zp.cd_manzana             
left join v_cupos_vdsl vd on vd.cd_central = pe.cd_central    
left join v_velocidades ve on ISNULL(P.NU_LONGITUD_LINEA,pr.avg_LONG) between ve.minima and ve.maxima 
left join v_max_dslam ds on p.ani = ds.ani


select sum(1) from v_parque_tb_sp
4221551
select * from vqs

s sp_get_vqs


update [tabla]
set
pseudoskill_fin_semana = virtual_queue,
pseudoskill_pri = virtual_queue,
pseudoskill_apy = virtual_queue||'_apy'
where      virtual_queue  like 'Incomunicados%'
        or virtual_queue  like 'Comercial%'
        or virtual_queue  like 'Reiterado%'





ALTER PROCEDURE sp_get_vqs    
as    
select distinct    
CASE     
 WHEN PSEUDOSKILL LIKE '%_OUN' THEN SUBSTRING(PSEUDOSKILL,1,LEN(PSEUDOSKILL)-4)    
 WHEN PSEUDOSKILL = 'Averias_DATOS-PRESTADORES_top' THEN SUBSTRING(PSEUDOSKILL,1,LEN(PSEUDOSKILL)-4)    
 WHEN PSEUDOSKILL = 'Averias_REITERADO_SPEEDY_Masivo' THEN 'Averias_REITERADO_SPEEDY'    
 WHEN PSEUDOSKILL LIKE '%_SP' THEN SUBSTRING(PSEUDOSKILL,1,LEN(PSEUDOSKILL)-3)    
 WHEN PSEUDOSKILL LIKE '%_DF' THEN SUBSTRING(PSEUDOSKILL,1,LEN(PSEUDOSKILL)-3)    
ELSE PSEUDOSKILL    
END TX_VQ    
 from pseudoskill where atencion in ('COM','TEC')  and bl_active = 1  
order by CASE     
 WHEN PSEUDOSKILL LIKE '%_OUN' THEN SUBSTRING(PSEUDOSKILL,1,LEN(PSEUDOSKILL)-4)    
 WHEN PSEUDOSKILL = 'Averias_DATOS-PRESTADORES_top' THEN SUBSTRING(PSEUDOSKILL,1,LEN(PSEUDOSKILL)-4)    
 WHEN PSEUDOSKILL = 'Averias_REITERADO_SPEEDY_Masivo' THEN 'Averias_REITERADO_SPEEDY'    
 WHEN PSEUDOSKILL LIKE '%_SP' THEN SUBSTRING(PSEUDOSKILL,1,LEN(PSEUDOSKILL)-3)    
 WHEN PSEUDOSKILL LIKE '%_DF' THEN SUBSTRING(PSEUDOSKILL,1,LEN(PSEUDOSKILL)-3)    
ELSE PSEUDOSKILL    
END

select * from skill_his

select distinct skill  from skill_day s left join pseudoskill p on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill 
where atencion is  null and skill not like 'vag%' and date_time >= '20110620000000'
AND SKILL LIKE '%TRansferencias_Top'
Transferencias_Top
Tansferencias_Top

select * from pseudoskill where pseudoskill like '%TANS%'

update pseudoskill set pseudoskill ='Transferencias_Top' where pseudoskill = 'Tansferencias_Top'

insert into pseudoskill
SELECT     'Transferencias_Top', SEGMENTO, atencion, SL, carterizado, bl_active
FROM         PSEUDOSKILL
WHERE     (pseudoskill LIKE '%alto_riesgo') and bl_active = 1

SELECT * FROM SKILL

select * from ps