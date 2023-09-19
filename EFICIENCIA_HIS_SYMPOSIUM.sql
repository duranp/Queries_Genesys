
select timestamp, left(grupo,15) as grupo,sum(callsanswered) + sum(callsabandoned) as ofr      
,sum(callsanswered) as atend,sum(callsabandoned) as aband      
,100*(case sum(callsanswered) + sum(callsabandoned) when '0' then '0' else      
(convert(decimal(10,2),1-(sum(callsanswered)/cast((sum(callsanswered) + sum(callsabandoned))       
as decimal (10,2)))))end) as [%Aband],100*(case sum(callsanswered) + sum(callsabandoned)       
when '0' then '0' else convert(decimal(10,2), ((sum(callsanswered)-sum(callsansweredaftthreshold))/cast((sum(callsanswered)      
 + sum(callsabandoned)) as decimal(10,2))) ) end)as [%SL]      
from symposium..dapplicationstat as i       
inner join symposium..campaña_apli as c on c.aplicationid=i.applicationid      
where grupo in('Comercial')      and timestamp >= '02/05/2011'
group by timestamp,grupo
