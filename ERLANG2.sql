select dbo.Erlang(0.8,20,200,600)


ALTER FUNCTION ErlangB (@servers float , @intensity float) 
returns float as 
begin   
	declare @c as float, @last as float, @res as float, @TMP AS VARCHAR(1000)   
	select @last = 1, @c = 1, @tmp = ''   
	if @servers < 0 or @intensity < 0 return 0  
	while @c <=floor(@servers)  
		begin   
			set @res = (@intensity*@last) / (@c +(@intensity*@last))                 
			SET @TMP = @TMP + '||' +cast(@RES as varchar(100)) + ',' + cast(@intensity as varchar(100))+ ','+cast(@last as varchar(100))+ ','+cast(@c as varchar(100))   
			set @last = @res   
			set @c=@c+1                  
	end           
	return dbo.MinMax(@res, 0, 1) 
end


ALTER FUNCTION ErlangC (@servers float , @intensity float)
returns float as
begin
	declare @c float, @b float
	if @servers < 0 or @intensity < 0 return 0
	set @b = dbo.ErlangB(@servers,@intensity)
	set @c = @b / (((@intensity/@servers)*@b) + (1-(@intensity/@servers)))
	return dbo.MinMax(@c, 0, 1)
end

ALTER FUNCTION MinMax (@val float,@min float,@max float)        
RETURNS float AS        
BEGIN        
	return	case 
				when @val < @min then @min 
				when @val > @max  then @max 
				else @val 
			end
END

ALTER function Erlang(@SLA float, @ServiceTime tinyint, @CallsPerHour smallint, @AHT int)
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
			if @slqueued < 0		set @slqueued = 0 
			if @slqueued > 1		set @slqueued = 1
			if @slqueued >= @sla		set @c = @max
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