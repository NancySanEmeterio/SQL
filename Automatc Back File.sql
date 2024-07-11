use master

declare @name  varchar(80)

set @name = 'J:\MSSQL_BACKUP\AxDB_PrevRestore_' + convert(varchar(8),getdate(),112) + '_' + FORMAT(getdate(),'hh-mm') + '.bak'

BACKUP DATABASE  [AxDB] TO
DISK = @name --N'J:\MSSQL_BACKUP\' + @name + ''
WITH COMPRESSION, STATS = 10
GO