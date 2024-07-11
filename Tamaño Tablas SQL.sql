DECLARE @COMANDO varchar(max)

set @COMANDO = 'use [?] SELECT TOP 20 DB_NAME(),   t.NAME AS Tabla,s.Name AS Esquema,p.rows AS NumeroDeFilas, CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS EspacioUtilizado_MB ' +
'FROM sys.tables t INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id ' +
'INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id LEFT OUTER JOIN sys.schemas s ON t.schema_id = s.schema_id ' +
'GROUP BY t.Name, s.Name, p.Rows ORDER BY 5 desc  '

exec sp_msForEachDb @comando


/*TAMAÑO D TABLAS */
select * from sys.objects
order by modify_date desc