DECLARE @HEADER VARCHAR(1000)
        SET @HEADER = '<style type=''text/css''>'
        SET @HEADER = @HEADER +  'tr'
        SET @HEADER = @HEADER +  '{height:auto;}' 
        SET @HEADER = @HEADER +  'td,th {'
        SET @HEADER = @HEADER +  'color: black;'
        SET @HEADER = @HEADER +  'font-size: 6.0pt;'
        SET @HEADER = @HEADER +  'font-style: normal;'
        SET @HEADER = @HEADER +  'text-decoration: none;'
        SET @HEADER = @HEADER +  'font-family: Calibri, sans-serif;'
        SET @HEADER = @HEADER +  'text-align: right;'
        SET @HEADER = @HEADER +  'white-space: nowrap;'
        SET @HEADER = @HEADER +  'border-left-style: none;'
        SET @HEADER = @HEADER +  'border-left-width: medium;'
        SET @HEADER = @HEADER +  'border-right: 1.0pt solid #4F81BD;'
        SET @HEADER = @HEADER +  'border-top: 1.0pt solid #4F81BD;'
        SET @HEADER = @HEADER +  'border-bottom: 1.0pt solid #4F81BD;'
        SET @HEADER = @HEADER +  'padding-left: 1px;'
        SET @HEADER = @HEADER +  'padding-right: 1px;'
        SET @HEADER = @HEADER +  'padding-top: 1px;'
        SET @HEADER = @HEADER +  'width: 25pt;'
        SET @HEADER = @HEADER +  '}' 
        SET @HEADER = @HEADER +  'th {width: 45pt;background-color:#4F81BD;color: white;font-weight: 700;text-align: center;}' 
        SET @HEADER = @HEADER +  '</style>'
        SET @HEADER = @HEADER +  '<table border=''1px solid blue''>'
        SET @HEADER = @HEADER +  '<TR><Th>Segmento</Th><Th style=''width: 25pt''>Ofr</Th><Th style=''width: 25pt''>TA</th></TR>'


declare @segmento varchar(1000), @ofr varchar(1000), @ta varchar(1000), @body varchar(8000) 
declare @atencion varchar(20), @mod int
set @atencion = 'com'
SET @BODY = ''

declare cur CURSOR FOR
  select
  isnull(segmento,'TOTAL ' + @atencion)Segmento,  sum(abandoned)+sum(answered) ofr, round(sum(abandoned)/(sum(abandoned)+sum(answered))*100.0,2,2) TA
  from skill_his s
   inner join pseudoskill p on  REPLACE(REPLACE(dbo.splitindex(skill,'|',0),'_apy',''),'_TRIADA','') = p.pseudoskill
   and dbo.dmy(dbo.f(date_time)) = dbo.dmy(getdate()) and skill <> 'fh' and atencion = @atencion
  group by segmento with rollup              having sum(entered)>0
  order by sum(abandoned)+sum(answered) desc


OPEN CUR
FETCH NEXT FROM CUR INTO @SEGMENTO, @OFR, @TA
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @BODY = @BODY + '<tr><th style=''text-align: left;''>' + @SEGMENTO + '</th><td>' + @OFR + '</td><TD>' + @TA + '</TD></TR>'
	FETCH NEXT FROM CUR INTO @SEGMENTO, @OFR, @TA
END
SET @BODY = @HEADER + @BODY + '</table>'
CLOSE CUR
DEALLOCATE CUR
print @body

INSERT INTO [10.105.8.249].CATE.DBO.E_ENVIO_GENERICO (TX_MAIL, TX_TITULO, TX_BODY) VALUES ('SEBASTIAN.MANGISCH@TELEFONICA.COM','EFICIENCIA CHOTA',@BODY)


select * from cartera


sp_adh 

select * from openquery(dw,'select * from tasa.party where tx_apellido = ''Rezk''')