SELECT  
     trace.TextData
    ,trace.DatabaseName
    ,trace.ObjectName
    ,te.name AS EventName
    ,tsv.subclass_name
    ,trace.EventClass
    ,trace.EventSubClass
    ,trace.StartTime
    ,trace.EndTime
    ,trace.NTDomainName
    ,trace.NTUserName
    ,trace.LoginName
    ,trace.HostName
    ,trace.ApplicationName
    ,trace.Spid
    --,*
FROM (SELECT REVERSE(STUFF(REVERSE(path), 1, CHARINDEX(N'\', REVERSE(path)), '')) + N'\Log.trc' AS path
    FROM sys.traces WHERE is_default = 1) AS default_trace_path
CROSS APPLY fn_trace_gettable(default_trace_path.path, DEFAULT) AS trace
JOIN sys.trace_events AS te ON 
    trace.EventClass=te.trace_event_id
LEFT JOIN sys.trace_subclass_values AS tsv ON
    tsv.trace_event_id = EveNtClass
    AND tsv.subclass_value = trace.EventSubClass
WHERE
    te.name = 'Object:Created'
   -- AND trace.DatabaseName = N'NonClusteredIndex-20230519-090624'
    AND trace.ObjectName = N'NonClusteredIndex-20230519-090624'
  --  AND tsv.subclass_name = 'Commit'
ORDER BY trace.StartTime;