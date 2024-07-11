 --Consulta de bases y espacio en Megas
 SELECT name AS FileName,
    size*1.0/128 AS FileSizeInMB,
    CASE max_size
        WHEN 0 THEN 'Autogrowth is off.'
        WHEN -1 THEN 'Autogrowth is on.'
        ELSE 'Log file grows to a maximum size of 2 TB.'
    END,
    growth AS 'GrowthValue',
    'GrowthIncrement' =
        CASE
            WHEN growth = 0 THEN 'Size is fixed.'
            WHEN growth > 0 AND is_percent_growth = 0
                THEN 'Growth value is in 8-KB pages.'
            ELSE 'Growth value is a percentage.'
        END
FROM tempdb.sys.database_files;
GO



/* LIMPIEZA*/
 
USE [tempdb]
GO
DBCC SHRINKFILE (N'templog' , 0)
GO
DBCC SHRINKFILE (N'tempdev' , 0)
GO
DBCC SHRINKFILE (N'temp2' , 0)
GO
DBCC SHRINKFILE (N'temp3' , 0)
GO
DBCC SHRINKFILE (N'temp4' , 0)
GO
DBCC SHRINKFILE (N'temp5' , 0)
GO
DBCC SHRINKFILE (N'temp6' , 0)
GO
DBCC SHRINKFILE (N'temp7' , 0)
GO
DBCC SHRINKFILE (N'temp8' , 0)
GO
 
--DBCC FREEPROCCACHE
--DBCC DROPCLEANBUFFERS
--EXEC sp_clean_db_free_space @dbname = N'int1mxdb';  

SELECT
(total_physical_memory_kb/1024) AS Total_OS_Memory_MB,
(available_physical_memory_kb/1024)  AS Available_OS_Memory_MB
FROM sys.dm_os_sys_memory;

SELECT  
(physical_memory_in_use_kb/1024) AS Memory_used_by_Sqlserver_MB,  
(locked_page_allocations_kb/1024) AS Locked_pages_used_by_Sqlserver_MB,  
(total_virtual_address_space_kb/1024) AS Total_VAS_in_MB,
process_physical_memory_low,  
process_virtual_memory_low  
FROM sys.dm_os_process_memory;  