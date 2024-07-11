		DECLARE @sqlstring NVARCHAR(max)=''
			SELECT @sqlstring = @sqlstring + 'KILL ' + CAST(spid AS VARCHAR(40)) + ';'
			--SELECT distinct status
			FROM sys.sysprocesses
			WHERE spid NOT IN (@@spid) -- Exclude current session
			AND spid > 50 -- Exclude system spid
			 AND rtrim(ltrim(status))  in ('sleeping' /*,'suspended' */)     
			 --AND  last_batch  < GETDATE() - 10         
			 --and blocked >0  
			PRINT @sqlstring
			EXEC sp_executesql @sqlstring


  GO

 DECLARE @COMANDO varchar(max)
set @COMANDO = 
'use [?] 		   SELECT  D.name, 
		S.name  ,T.name ,DDIPS.avg_fragmentation_in_percent,
		'' ALTER INDEX  '' + I.name + '' ON '' + T.name  + 
		'' REBUILD  WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON) ''
		FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS DDIPS
		INNER JOIN sys.databases D ON D.database_id = DB_ID()
		INNER JOIN sys.tables T on T.object_id = DDIPS.object_id
		INNER JOIN sys.schemas S on T.schema_id = S.schema_id
		INNER JOIN sys.indexes I ON I.object_id = DDIPS.object_id
		AND DDIPS.index_id = I.index_id
		WHERE DDIPS.database_id = DB_ID()
		and I.name is not null
		AND DDIPS.avg_fragmentation_in_percent > 80
		AND S.name = ''dbo'''
		 
		 select @comando

exec sp_msForEachDb @comando

 