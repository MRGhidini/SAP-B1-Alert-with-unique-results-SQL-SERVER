DECLARE @Code AS VARCHAR(25)
DECLARE @datahora AS DATETIME
DECLARE registros_news CURSOR FOR
select
	t0.cardcode,
	t0.createdate
from ocrd t0
inner join ousr T1 ON T1.USERID = T0.UserSign
where t0.CardCode not in(select Code from [dbo].[@PN_RESULT]) 
order by t0.createdate

--show result--
select
	case when t0.CardType = 'S' then 'Vendor'
		when t0.CardType = 'C' then 'Customer'
		when t0.CardType = 'L' then 'Customer Potential' end as 'PN Type',
	t0.cardcode,
	t0.cardname,
	t0.createdate,
	T1.User_Code as 'created by Code',
	T1.U_NAME as 'created by Name'
from ocrd t0
inner join ousr T1 ON T1.USERID = T0.UserSign
where t0.CardCode not in(select Code from [dbo].[@PN_RESULT]) 
order by t0.createdate
--end--

OPEN registros_news
		FETCH NEXT FROM registros_news INTO @Code, @datahora
WHILE(@@FETCH_STATUS = 0)                                                                                        
	BEGIN 
				Insert Into [dbo].[@PN_RESULT] (Code,U_datahora) values (@Code,@datahora)
			
		 FETCH NEXT FROM registros_news INTO @Code, @datahora
	END
CLOSE registros_news
DEALLOCATE registros_news