SELECT DB_NAME(database_id) AS DataBaseName,
--CASE WHEN Type_Desc = 'ROWS' THEN 'Data File(s)'
--WHEN Type_Desc = 'LOG' THEN 'Log File(s)'
--ELSE Type_Desc END AS FileType,
CAST( ((SUM(Size)* 8) / 1024.0) AS DECIMAL(18,2) )AS TotalSizeInMB
FROM sys.master_files
GROUP BY GROUPING SETS
(
(DB_NAME(database_id), Type_Desc),
(DB_NAME(database_id))
)
ORDER BY 2 DESC
GO
------------
--LIMPIEZA LOGS
USE  cst0mxdb;
GO
 select * from sys.database_files
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE  cst0mxdb
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE (cst0mxdb_tlog, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE cst0mxdb
SET RECOVERY FULL;
GO
