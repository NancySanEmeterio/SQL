--QUERY 1
--System Health
--EXEC xp_readerrorlog 0,1; 

--QUERY 2
--Ejecuciones Create, Alter, Drop
SELECT DISTINCT  
	    t.StartTime , TE.name AS [EventName] ,
        T.DatabaseName ,  
        t.ApplicationName ,
        t.LoginName ,
        t.SPID   
FROM    sys.fn_trace_gettable(CONVERT(VARCHAR(150), ( SELECT TOP 1
                                                              f.[value]
                                                      FROM    sys.fn_trace_getinfo(NULL) f
                                                      WHERE   f.property = 2
                                                    )), DEFAULT) T
        JOIN sys.trace_events TE ON T.EventClass = TE.trace_event_id
WHERE   te.name not in  ('Sort Warnings' )
--        OR te.name = 'Data File Auto Shrink'

and  t.LoginName  like '%580%'
ORDER BY t.StartTime desc;


--'Audit Schema Object GDR Event','Audit Server Alter Trace Event','Audit DBCC Event',
--		'Missing Column Statistics','Missing Join Predicate','Hash Warning','Sort Warnings'