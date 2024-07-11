/*
https://www.sqlshack.com/how-to-identify-slow-running-queries-in-sql-server/
*/

/*Conecciones Activas*/ 
	SELECT 
		'Conexiones',DB_NAME(dbid) as DBName, loginame as LoginName,status,
		COUNT(dbid) as NumberOfConnections
	FROM     sys.sysprocesses
	where 1=1 and status in ('suspended','runnable')                   
	and dbid > 0 
		GROUP BY dbid, loginame,status
		order by 4 desc

 /*
 Sesiones Bloqueadas o que demandan mucho de la base de datos
 */
		SELECT s.session_id,
		 r.blocking_session_id 'Blk by',
			r.status,
			r.cpu_time , 
			r.wait_type,
			wait_resource,
			r.wait_time / (1000 * 60) 'Wait M',
			r.cpu_time,
			r.logical_reads,
			r.reads,
			r.writes,
			r.total_elapsed_time / (1000 * 60) 'Elaps M',
			DB_NAME(r.database_id) as DbName,
			Substring(st.TEXT,(r.statement_start_offset / 2) + 1,
			((CASE r.statement_end_offset
		WHEN -1
		THEN Datalength(st.TEXT)
		ELSE r.statement_end_offset
		END - r.statement_start_offset) / 2) + 1) AS statement_text,
			Coalesce(Quotename(Db_name(st.dbid)) + N'.' + Quotename(Object_schema_name(st.objectid, st.dbid)) + N'.' +
			Quotename(Object_name(st.objectid, st.dbid)), '') AS command_text,
			r.command,
			s.login_name,
			s.host_name,
			s.program_name,
			s.last_request_end_time,
			s.login_time,
			r.open_transaction_count
		FROM sys.dm_exec_sessions AS s
			JOIN sys.dm_exec_requests AS r
		ON r.session_id = s.session_id 
			CROSS APPLY sys.Dm_exec_sql_text(r.sql_handle) AS st
		 WHERE r.session_id != @@SPID
		ORDER BY r.cpu_time desc

GO

--Sesiones Activas en Base de datos
		sp_whoisactive


--Matar Sesion
--kill 167

/*
-- ver contenido de spid
		declare @SPID as int 
		set @SPID= 12

			 SELECT *  FROM sys.dm_exec_sessions es
				INNER JOIN sys.dm_exec_connections ec
			  ON es.session_id = ec.session_id
		  CROSS APPLY sys.dm_exec_sql_text(ec.most_recent_sql_handle) where es.session_id=@SPID  

*/

  
/*
sp_who

sp_who2

*/


/*
-- Ultimas consultas ejecutadas

		SELECT TOP 20000 execquery.last_execution_time AS [Date Time], execsql.text AS [Script],total_rows, total_worker_time--,*
		FROM sys.dm_exec_query_stats AS execquery
		CROSS APPLY sys.dm_exec_sql_text(execquery.sql_handle) AS execsql
		--WHERE execquery.last_execution_time < '2022-06-04 10:10:20.347'
		--where total_worker_time > 10000
		ORDER BY execquery.last_execution_time desc  

*/

/*
--Sesiones Dormidas


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

*/

/*

--Limpieza de estadisticas

------------------------
EXEC sp_updatestats;  

--------------
		begin try
		--execute [Estadisticas]
		DECLARE @TSQL nvarchar(2000)

		-- Filtering system databases and user databases from execution
		SET @TSQL = '
		IF (DB_ID(''?'') > 4
		   AND ''?'' NOT IN(''master'',''SSISDB'')
		   )
		BEGIN 
		   USE [?]; exec sp_updatestats
		END
		'
		-- Executing TSQL for each database
		EXEC sp_MSforeachdb @TSQL


		end try
		begin catch
		end catch
*/

/*

--Deflagmentacion de Indices

		 SELECT S.name as 'Schema',
		T.name as 'Table',
		I.name as 'Index',
		DDIPS.avg_fragmentation_in_percent,
		DDIPS.page_count,
		'ALTER INDEX ' + I.name + ' ON ' + T.name  + ' REBUILD  WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON) '
		FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS DDIPS
		INNER JOIN sys.tables T on T.object_id = DDIPS.object_id
		INNER JOIN sys.schemas S on T.schema_id = S.schema_id
		INNER JOIN sys.indexes I ON I.object_id = DDIPS.object_id
		AND DDIPS.index_id = I.index_id
		WHERE DDIPS.database_id = DB_ID()
		and I.name is not null
		AND DDIPS.avg_fragmentation_in_percent > 30
		AND S.name = 'dbo'
		order by 1 desc
		--and T.name ='' 
*/

 
  