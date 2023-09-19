select * into #ave from indicadores.cate.dbo.averias
drop table #r
select A.*, case when exists(select cd_averia from #ave where ani = a.ani and a.fh_cierre between dateadd(day,-7,fh_ingreso) and fh_ingreso and cd_averia <> a.cd_averia) then 1 else 0 end r
into #r
from #ave a inner join dt_Tipo_cliente t on a.cd_tipo_cliente = t.cd_tipo_cliente
where year(fh_cierre) = 2011




select month(fh_cierre), ani, sum(r)
from #R 
group by month(fh_cierre), ani
order by month(fh_cierre), ani

delete from #r where fh_cierre is null

select * from agent_his

select top 10 * from trae_erlang


s SP_GET_LLAMADAS_PROY

  
ALTER PROCEDURE SP_GET_LLAMADAS_PROY (@DATE SMALLDATETIME, @SEGMENTO VARCHAR(40))        
AS        
select intervalo, ofr, at, ab, rec_proy, cast(((ofr/rec_proy)-1)*100 as numeric(6,2)) gap, cast(ab/ofr*100 as numeric(6,2))  TA from        
(        
select dbo.f(date_time)Intervalo, sum(entered)ofr, sum(answered)at, sum(abandoned)ab        
from skill_his s                         
inner join pseudoskill p on REPLACE(dbo.splitindex(skill,'|',0),'_apy','') = p.pseudoskill              
where atencion = @SEGMENTO and segmento <> CASE WHEN @SEGMENTO = 'COM' THEN 'top' ELSE '' END        
and dbo.dmy(dbo.f(date_time)) = dbo.dmy(@DATE)        
group by dbo.f(date_time)        
)x         
 left join WFM_LLAMADAS e on intervalo = e.date and e.segmento = CASE WHEN @SEGMENTO = 'COM' THEN 'NEG_Total_No_Carterizado_+_AV' ELSE '' END        
WHERE OFR > 0        
order by intervalo 

SELECT * FROM VAGS


SELECT *  FROM WFM_LLAMADAS WHERE DATE >= DBO.PD(DATE)
