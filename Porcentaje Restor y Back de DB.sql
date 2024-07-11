SELECT session_id,
       command Comando,
       CONVERT(NUMERIC(10, 2), percent_complete) AS 'Porcentaje hecho',
       CONVERT(NUMERIC(10,2), total_elapsed_time / 1000.0 / 60.0) AS 'Tiempo transcurrido',
       CONVERT(VARCHAR(20), DATEADD(ms, estimated_completion_time, GETDATE()),20) AS 'Fecha estimada de finalización',
       CONVERT(NUMERIC(10, 2), estimated_completion_time/1000.0/60.0) AS 'Minutos restantes',
       CONVERT(NUMERIC(10,2), estimated_completion_time/1000.0/60.0/60.0) AS 'Horas pendientes'
	   ,*
FROM sys.dm_exec_requests
WHERE command IN ( 'RESTORE VERIFYON',
                   'RESTORE DATABASE',
                   'BACKUP DATABASE',
                   'RESTORE LOG',
                   'BACKUP LOG',
                   'RESTORE HEADERON',
                   'DbccFilesCompact')