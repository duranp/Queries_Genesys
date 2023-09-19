
select b.pcrc, b.fecha, isnull(b.ofr,0) ofr, floor(h.tmo) tmo
from bruta b 
	inner join 
			pcrc p 
				on b.pcrc = p.pcrc and 
				dbo.date_tofloat(b.fecha) 
				between 
					CASE when DATEPART(WEEkDAY,b.FECHA) = 6 then s_desde when DATEPART(WEEkDAY,b.FECHA) = 7 then d_desde else desde end			
				and 
					CASE when DATEPART(WEEkDAY,b.FECHA) = 6 then s_hasta when DATEPART(WEEkDAY,b.FECHA) = 7 then d_hasta else hasta end 
	left join 
			(select dbo.rh(fecha) fecha, pcrc, case when sum(answered) = 0 then 0 else sum(tiempo_operativo)/sum(answered) end tmo 
			from bruta group by dbo.rh(fecha), pcrc)h
				on b.pcrc = h.pcrc and h.fecha = dbo.rh(b.fecha)
where 
b.fecha >= dbo.dmy(getdate()-16) 
and dbo.dmy(b.fecha) <> '20/06/2012'
and b.pcrc not like '%atto%' 
and b.pcrc not like '%mcd%'

select * from  bcp_reabiertos

select dbo.pd(dateadd(month,-1,getdate()))
s pd

s dmy