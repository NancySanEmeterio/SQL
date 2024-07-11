 

select *
from
  sysobjects so
join
  sysusers su on so.uid = su.uid
  where so.[name] like 'NonClusteredIndex-20230519-090624'

 
 
SELECT OBJECT_NAME(i.object_id) AS TableName, i.object_id, i.name, i.type_desc,o.create_date, o.modify_date,o.type,i.is_disabled
FROM   sys.indexes i
        INNER JOIN sys.objects o ON i.object_id = o.object_id
WHERE o.type NOT IN ('S', 'IT')
  AND o.is_ms_shipped = 0 
  AND i.name IS NOT NULL
ORDER BY modify_date DESC