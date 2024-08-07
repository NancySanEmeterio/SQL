SELECT xdr.value('@timestamp', 'datetime') AS [Date],
    xdr.query('.') AS [Event_Data]
FROM (SELECT CAST([target_data] AS XML) AS Target_Data
            FROM sys.dm_xe_session_targets AS xt
            INNER JOIN sys.dm_xe_sessions AS xs ON xs.address = xt.event_session_address
            WHERE xs.name = N'system_health'
              AND xt.target_name = N'ring_buffer'
    ) AS XML_Data
 CROSS APPLY Target_Data.nodes('RingBufferTarget/event[@name="xml_deadlock_report"]') AS XEventData(xdr)
ORDER BY [Date] DESC;

----------------------------------------------------------------------------------------------
dECLARE @xml XML

SELECT @xml = target_data
FROM   sys.dm_xe_session_targets
JOIN sys.dm_xe_sessions
ON event_session_address = address
WHERE  name = 'system_health' AND target_name = 'ring_buffer'

SELECT CAST(XEventData.XEvent.value('(data/value)[1]', 'varchar(max)') AS XML)
FROM   (SELECT @xml AS TargetData) AS Data
CROSS APPLY TargetData.nodes ('RingBufferTarget/event[@name="xml_deadlock_report"]') AS XEventData (XEvent)
