s f

select dbo.minmax(130,30,120)

CREATE FUNCTION MinMax (@val float,@min int,@max int)        
RETURNS int AS        
BEGIN        
	return	case 
				when @val < @min then @min 
				when @val > @max  then @max 
				else @val 
			end
END     

alter FUNCTION ErlangB (@servers float , @intensity float)
returns float as
begin
		declare @c as float, @last as float, @res as float
		select @last = 1, @c = 1
		if @servers < 0 or @intensity < 0 return 0
	while @c <=floor(@servers)
	begin
		set @res = (@intensity*@last) / (@c +(@intensity+@last))
		set @last = @res
		set @c=@c+1
	end
	return dbo.MinMax(@res, 0, 1)
end

create function ErlangC (@servers float , @intensity float)
returns float as
begin
	declare @c float, @b float
	if @servers < 0 or @intensity < 0 return 0
	set @b = dbo.ErlangB(@servers,@intensity)
	set @c = @b / (((@intensity/@servers)*@b) + (1-(@intensity/@servers)))
	return dbo.MinMax(@c, 0, 1)
end

select dbo.erlangc(0.3,250.2)
select round(10.8,4,2)
select dbo.Erlang(0.8,20,200,600)

alter function Erlang(@SLA float, @ServiceTime tinyint, @CallsPerHour smallint, @AHT int)
returns float as 
begin
	declare @trafficrate float, @erlangs float, @utilisation float, @noagents float, @max float, @server float,
	@SLQueued float,@lastslq float, @erlangc float, @c int, @NoAgentsSng float, @OneAgent float, @fract float
	if @sla >1 set @sla = 1.0
	set @trafficrate =	@callsperhour / (3600/@aht)
	set @erlangs =		floor((@callsperhour * (@aht)) / 3600 + 0.5)
	set @noagents =		case when @erlangs <1 then 1 else floor(@erlangs) end
	set @utilisation =  @trafficrate / @noagents
	while @utilisation >= 1
	begin
		set @noagents = @noagents +1
		set @utilisation = @trafficrate / @noagents
	end
	set @SLQueued = 0
	set @c  = 1
	set @max = @noagents * 100
	while @c <= @max
	begin
		set @lastslq = @slqueued
		set @utilisation = @trafficrate / @noagents
		if @utilisation < 1 
		begin
			set @server = @noagents
			set @erlangc = dbo.ErlangC(@server,@trafficrate)
			set @slqueued = 1 - @erlangc * exp((@trafficrate - @server) * @servicetime / @aht)
			if @slqueued < 0				set @slqueued = 0 
			if @slqueued > 1				set @slqueued = 1
			if @slqueued >= @sla			set @c = @max
			if @slqueued > (1 - 0.00001)	set @c = @max
		end
		if @c <> @max set @noagents = @noagents + 1
		set @c = @c +1
	end
	set @NoAgentsSng = @noagents
	if @slqueued > @sla
	begin
		set @OneAgent = @SLQueued - @LastSLQ  
        set @Fract = @SLA - @LastSLQ  
        set @NoAgentsSng = (@Fract / @OneAgent) + (@NoAgents - 1)
	end
	return @NoAgentsSng
end

Public Function Erl(SLA , ServiceTime , CallsPerHour , AHT ) 
Dim Server 
     If SLA > 1 Then SLA = 1
     BirthRate = CallsPerHour
     DeathRate = 3600 / AHT
     TrafficRate = BirthRate / DeathRate
     Erlangs = Fix((BirthRate * (AHT)) / 3600 + 0.5)
     If Erlangs < 1 Then NoAgents = 1 Else NoAgents = Int(Erlangs)
     Utilisation = TrafficRate / NoAgents
     While Utilisation >= 1
          NoAgents = NoAgents + 1
          Utilisation = TrafficRate / NoAgents
     Wend
     SLQueued = 0
     MaxIterate = NoAgents * 100
     For Count = 1 To MaxIterate
          LastSLQ = SLQueued
          Utilisation = TrafficRate / NoAgents
          If Utilisation < 1 Then
               Server = NoAgents
               C = ErlangC(Server, TrafficRate)
               SLQueued = 1 - C * Exp((TrafficRate - Server) * ServiceTime / AHT)
               If SLQueued < 0 Then SLQueued = 0
               If SLQueued > 1 Then SLQueued = 1
               If SLQueued >= SLA Then Count = MaxIterate
               If SLQueued > (1 - MaxAccuracy) Then Count = MaxIterate
          End If
          If Count <> MaxIterate Then NoAgents = NoAgents + 1
     next
     NoAgentsSng = NoAgents
     If SLQueued > SLA Then  
        OneAgent = SLQueued - LastSLQ  
        Fract = SLA - LastSLQ  
        NoAgentsSng = (Fract / OneAgent) + (NoAgents - 1)
     End If

    Erl = NoAgentsSng
End Function

select exp(10)

select * from vtv..contacto where swemailaddress = 'encargadacentralopcionsa@gmail.com'

insert into vitacora_cambios values (getdate(),'<a href="http://www.visualizador.speedy.com.ar">VISUALIZADOR</a>: Se Agrego la disponibilidad de MEC segun central COTA.')
select * from vitacora_cambios
update vitacora_cambios 
set texto = '<span onclick="document.location.href=''http://www.visualizador.speedy.com.ar''" style="cursor:pointer">VISUALIZADOR</span>:Se Agrego la disponibilidad de MEC segun central COTA.'
where texto = '<span onclick=" document.location.target=''_blank'';document.location.href=''http://www.visualizador.speedy.com.ar''" style="cursor:pointer">VISUALIZADOR</span>:Se Agrego la disponibilidad de MEC segun central COTA.'

select * from agent_day where dbo.f(date_Time) = dbo.dmy(getdate()-2)

select * from tempdb..cobros where sub_estado_bo in ('aplicado ok','generó dovlución','pago doble','pago revertido')
select * from dw..parque where ani = '1142264037'

select * from 
insert into 
[10.105.8.249].vantive.dbo.incasos (
select 

s sp_get_agentes
s sp_macro_quejas





ALTER PROCEDURE [dbo].[sp_get_agentes]       
      
      
@fechai as datetime,      
@fechaf as datetime,      
@SITE  AS nvarchar(150),  
@supervisor  AS nvarchar(150)      
       
AS      
      
      
          
 select  site,supervisor,asistente ,     
 cast(sum(logintime)/3600 as decimal(12,2))as logueo,sum(answered) as answered, sum(transferred) as transf, sum(shortcalls) as short, sum(outbound)  as salien,      
(CASE SUM(logintime) WHEN '0' THEN '0' ELSE CAST(SUM(answered)/CAST((SUM(logintime)/3600)AS DECIMAL (12,4)) AS DECIMAL(12,4)) END) AS  [aten   x hs],      
(Case (sum(answered)-sum(SHORTCALLS)) when '0' Then '0'      
Else       
cast((sum(talktime)+sum(nrr5))/(sum(answered)-sum(SHORTCALLS))as decimal(10,2))    
end)    
  as [TMO],   
(Case (sum(outbound)) when '0' Then '0'      
Else       
cast(sum(nrr4)/sum(outbound)as decimal(10,2))    
end)    
  as [TMO salien],   
(CASE (sum(answered)-sum(SHORTCALLS))  When '0' Then      
'0'      
ELSE cast(((SUM(TALKTIME)-SUM(HOLDtime))/(sum(answered)-sum(SHORTCALLS)))as decimal(12,2)) END)as [tt x  llam],      
(Case (SUM(TALKTIME)+SUM(nrr5)) when '0' Then '0'      
Else       
100*convert(decimal(12,2),(SUM(TALKTIME)-SUM(HOLDtime))/cast(((SUM(TALKTIME)+SUM(nrr5)))as decimal(12,2)))end) AS [%Talk],    
(CASE (sum(answered)-sum(SHORTCALLS))  WHEN '0' THEN '0' ELSE      
 cast(SUM (nrr5)/(sum(answered)-sum(SHORTCALLS))as decimal(10,2  
))END) AS [Nt x   llam],      
(Case (SUM(TALKTIME)+SUM(nrr5)) when '0' Then '0'      
Else       
100*convert(decimal(12,2),SUM(nrr5)/cast((sum(talktime)+sum(nrr5))as decimal(12,2)))   
end)AS [%nt],      
(CASE (sum(answered)-sum(SHORTCALLS))  WHEN '0' THEN '0' ELSE      
cast(SUM(HOLDtime)/(sum(answered)-sum(SHORTCALLS)) as decimal(12,2)) END) AS [Hold   x Llam],      
(Case (SUM(TALKTIME)+SUM(nrr5)) when '0' Then '0'      
Else       
100*convert(decimal(12,2),((sum(holdtime))/cast((sum(talktime)+sum(nrr5))as decimal(12,2))))end) as [%hold],    
(CASE SUM(TALKTIME)+SUM(nrr5)+sum(readytime) WHEN '0' THEN '0' ELSE      
CAST(100*((SUM (talktime)+ SUM(isnull(nrr4,0))+sum(isnull(nrr5,0)))/ CAST(SUM(ISNULL(nrr5,0))+sum(talktime)+ SUM(isnull(nrr4,0))+sum(readytime)AS DECIMAL(12,2) ))AS DECIMAL(12,2))END) AS [%occup],     
cast(SUM(readytime)/cast(3600 as decimal(12,2))as decimal(12,2)) AS Ocioso,      
(CASE (SUM(TALKTIME)+SUM(nrr5)) WHEN '0' THEN '0' ELSE      
CAST(100*(SUM (readytime)/ CAST(SUM(logintime)AS DECIMAL(12,2) ))AS DECIMAL(12,2))END) AS [%Ocio],       
(Case sum(talktime)+ sum(readytime) + SUM(isnull(nrr5,0)) + SUM(isnull(nrr1,0))+ SUM(isnull(nrr2,0))+ SUM(isnull(nrr3,0))+ SUM(isnull(nrr6,0))+ SUM(isnull(nrr7,0))+ SUM(isnull(nrr8,0)) when '0' Then '0'      
Else       
100* convert(decimal(12,2),(sum(talktime)+ SUM(isnull(nrr4,0))+ sum(isnull(nrr5,0))+ sum(readytime)) /cast(sum(talktime)+ sum(readytime) + SUM(isnull(nrr0,0)) + SUM(isnull(nrr1,0))+ SUM(isnull(nrr2,0))+ SUM(isnull(nrr3,0))+ SUM(isnull(nrr5,0))+ SUM(isnull
(nrr4,0)) + SUM(isnull(nrr6,0))+ SUM(isnull(nrr7,0))+ SUM(isnull(nrr8,0)) as decimal(12,2)))end)  as [%utiliz],          
(case sum(logintime) when 0 then '0' else cast(100*(cast(isnull(sum(nrr0),0)as decimal(12,2))/sum(logintime))as decimal(10,2)) end)as [%refrig] ,(case sum(logintime) when 0 then '0' else cast(100*(cast(isnull(sum(nrr1),0)as decimal(12,2))/sum(logintime))a
s decimal(10,2)) end)as [%toilette],(case sum(logintime) when 0 then '0' else CAST(cast(100*(cast(isnull(sum(nrr2),0)+isnull(sum(nrr3),0)+isnull(sum(nrr7),0)as decimal(12,2))/sum(logintime))as decimal(10,2))AS VARCHAR(50))+'/'+CAST(CAST((SUM(ISNULL(NRR2,0
))+SUM(ISNULL(NRR3,0))+SUM(ISNULL(NRR7,0)))/(1.0*3600)  as decimal(10,2))AS VARCHAR(50))  end) as [%coach/hs capa],(case sum(logintime) when 0 then '0' else cast(100*(cast(isnull(sum(nrr4),0)as decimal(12,2))/sum(logintime))as decimal(10,2)) end)as [%recl
],(case sum(logintime) when 0 then '0' else cast(100*(cast(isnull(sum(nrr5),0)as decimal(12,2))/sum(logintime))as decimal(10,2)) end)as [%otros],  
sum(isnull(([Llamadas contabilizadas]),0))as [Llamadas contabilizadas], sum(isnull([no rellamaron en 2],0)) as [no rellamaron en 2],      
isnull((case sum(([Llamadas contabilizadas])) when '0' then 100 else cast((sum([no rellamaron en 2])/cast(sum([Llamadas contabilizadas])as decimal(12,2)))*100 as decimal(12,2))end),100) as FCR2,      
sum(isnull(([no rellamaron en 7]),0)) as [no rellamaron en 7],      
isnull((case sum([Llamadas contabilizadas]) when '0' then 100 else cast((sum([no rellamaron en 7])/cast((sum([Llamadas contabilizadas]))as decimal(12,2)))*100 as decimal(12,2) )end),100)as FCR7,  
sum(isnull([cantidad casos],0)) as [Cantidad Casos], sum(isnull(ventas,0)) as Ventas,sum(isnull(gestion,0))as Gestion,sum(isnull(facturacion,0))as Facturacion,sum(isnull(cobros,0)) as Cobros,sum(isnull(averias,0)) as Averias,sum(isnull(bajas,0)) as Bajas,
 sum(isnull(quejas,0)) as Quejas, sum(isnull(otros,0)) As Otros,  
sum(isnull(q_mail_cargado,0)) as [Q Mail Cargados], cast((case sum(isnull(q_encuestas,0)) when '0' then '0' else sum(isnull(puntuacion,0))/cast(sum(isnull(q_encuestas,0)) as decimal(12,2)) end)as  
 decimal(12,2)) as punt,sum(ISNULL(q_enviados,0)) as [Q enviados],sum(ISNULL(q_encuestas,0)) as [Q encuestas], cast((case sum(isnull(q_enviados,0)) when '0' then '0' else sum(isnull(q_encuestas,0))/cast(sum(isnull(q_enviados,0)) as decimal(12,2)) end) as 
decimal(12,2)) as [%_enc],sum(isnull(q_quejas,0))[Q   quejas],    
 sum(isnull([al lado],0))as [Al Lado],SUM(ISNULL(grabaciones,0)) as Grabaciones,sum(isnull(devoluciones,0)) as [Devoluciones Mensuales], SUM(ISNULL(grabaciones,0))-(sum(isnull(PEC,0))/100) Q_EC,  
cast((case sum(isnull(GRABACIONES,0)) when '0' then '0' else sum(isnull(enc,0))/cast(sum(isnull(GRABACIONES,0)) as decimal(12,2)) end)as  
 decimal(12,2)) as ENC,  
cast((case sum(isnull(GRABACIONES,0)) when '0' then '0' else sum(isnull(PECNEG,0))/cast(sum(isnull(GRABACIONES,0)) as decimal(12,2)) end)as  
 decimal(12,2)) as PECNeg,  
cast((case sum(isnull(GRABACIONES,0)) when '0' then '0'else sum(isnull(PECUf,0))/cast(sum(isnull(GRABACIONES,0)) as decimal(12,2)) end)as  
 decimal(12,2)) as PECUf,  
cast((case sum(isnull(GRABACIONES,0)) when '0' then '0'  else sum(isnull(PEC,0))/cast(sum(isnull(GRABACIONES,0)) as decimal(12,2)) end)as  
 decimal(12,2)) as PEC,  
 sum(isnull([cant mail],0)) as [Q Mail],  
 cast((case sum(isnull([cant mail],0)) when '0' then '0' else sum(isnull([enc mail],0))/cast(sum(isnull([cant mail],0)) as decimal(12,2)) end)as  
 decimal(12,2)) as [ENC Mail],  
cast((case sum(isnull([cant mail],0)) when '0' then '0' else sum(isnull([PECNEG mail],0))/cast(sum(isnull([cant mail],0)) as decimal(12,2)) end)as  
 decimal(12,2)) as [PECNeg mail],  
cast((case sum(isnull([cant mail],0)) when '0' then '0'else sum(isnull([PECUf mail],0))/cast(sum(isnull([cant mail],0)) as decimal(12,2)) end)as  
 decimal(12,2)) as [PECUf mail],  
cast((case sum(isnull([cant mail],0)) when '0' then '0'  else sum(isnull([PEC mail],0))/cast(sum(isnull([cant mail],0)) as decimal(12,2)) end)as  
 decimal(12,2)) as [PEC mail],  
 isnull(sum(ISNULL(cumplidas,0)),0) as Cumplidas,isnull(sum(ISNULL(tb_cumplidas,0)),0) as [TB Cumplidas],isnull(sum(ISNULL(ADSL_cumplidas,0)),0) as [ADSL Cumplidas],isnull(sum(ISNULL(CAM24_cumplidaS,0)),0) as [CAM24 Cumplidas],isnull(sum(ISNULL(PDTI_cumpl
idaS,0)),0) as [PDTI Cumplidas],isnull(sum(ISNULL(VOIP_cumplidaS,0)),0) as [VOIP Cumplidas], isnull(sum(ISNULL(INT_TOT_cumplidaS,0)),0) as [INT TOT Cumplidas],isnull(sum(anuladas),0) as Anuladas, isnull(sum(ISNULL(TB_anuladas,0)),0) as [TB Anuladas],isnul
l(sum(ISNULL(ADSL_anuladas,0)),0) as [ADSL Anuladas],isnull(sum(ISNULL(CAM24_anuladas,0)),0) as [CAM24 Anuladas],isnull(sum(ISNULL(PDTI_anuladas,0)),0) as [PDTI Anuladas],isnull(sum(ISNULL(VOIP_anuladas,0)),0) as [VOIP Anuladas],isnull(sum(ISNULL(INT_TOT_
anuladas,0)),0) as [INT TOT Anuladas], case isnull(sum(cumplidas)+sum(anuladas),0) when 0 then 0 else cast(100*sum(cumplidas)/cast(sum(cumplidas)+sum(anuladas) as decimal(10,2)) as decimal(10,2)) end as Eficiencia,  
 case isnull(sum(answered),0) when 0 then 0 else cast(100*isnull(sum(cumplidas),0)/cast(sum(answered) as decimal(10,2)) as decimal(10,2)) end as Conversion  
from agent_freeze  
where fecha between @fechaI and  @fechaf  and site=isnull(@SITE,site) and supervisor=isnull(@supervisor,supervisor)  
--and fecha not between '05/02/2012' and '09/02/2012 07:00'  
group by site,supervisor,asistente    
order by site,replace(supervisor,'[','zzz'),asistente  