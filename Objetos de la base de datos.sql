
--Select distinct o.name from sys.syscomments c join sys.objects o
--on c.id =o.object_id
--where text like '%Pd_PedDetalle%' 

 


 DECLARE @COMANDO varchar(max)

set @COMANDO = 'use [?] SELECT distinct DB_NAME(),   o.name from sys.syscomments c join sys.objects o
on c.id =o.object_id
where text like ''%Pd_PedDetalle%'''  

exec sp_msForEachDb @comando
