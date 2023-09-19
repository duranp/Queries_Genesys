 
select month(cctfechacontacto)mes , vag, sum(1)q, sum(case when swpersonid is not null then 1 else 0 end) con_mail, sum(case when dbo.dmy(cctfechacontacto) = dbo.dmy(swdatecreated) then 1 else 0 end) creado from hoy h left join contacto c on h.cctpersonid = c.swpersonid
inner join genesys..roster_cm r on h.swcreatedby = r.name
group by month(cctfechacontacto),vag
order by month(cctfechacontacto),vag
  