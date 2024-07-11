/*
<log_number> Is a log number 0, 1, 2, 3..  of error log files. Where 0 returns the current log. 1 returns     logs from file ERRORLOG.1.
<log_type> Is a type of error file that yo want to read, 1 to read SQL Server error logs and 2 to read        SQL  Server Agent error logs.
<search_term1> Is a search keyword for text column.
<search_term2> Is a additional search keyword for text column. If specified both<search_term1> and    <search_term2>, then it only returns lines containing both terms.
<start_date> Start reading logs from this date.
<end_date>  Reads logs till this date.

EXEC xp_ReadErrorLog
EXEC xp_ReadErrorLog 2, 1
EXEC xp_ReadErrorLog 2, 1, N'tempdb', N'database'
EXEC xp_ReadErrorLog 2, 1, N'instance', NULL, '2020-10-14 09:44:09.830', '2020-10-15 11:48:41.660'
*/

--System Health
EXEC xp_readerrorlog 0,1; 
 
-- SESIONES ACTIVAS  
 SELECT *
 from sys.dm_exec_requests ER with(readuncommitted)
right join sys.dm_exec_sessions ES with(readuncommitted)
on ES.session_id = ER.session_id 
left join sys.dm_exec_connections EC  with(readuncommitted)
on EC.session_id = ES.session_id


	SELECT @@ServerName AS SERVER
 ,NAME
 ,login_time
 ,last_batch
 ,getdate() AS DATE
 ,STATUS
 ,hostname
 ,program_name
 ,nt_username
 ,loginame
FROM sys.databases d
LEFT JOIN sysprocesses sp ON d.database_id = sp.dbid
WHERE database_id NOT BETWEEN 0   AND 4
 AND loginame IS NOT NULL 
 order by hostname



-- REGISTRO DE LOG
SELECT distinct dbname,loginname  , createdate, updatedate ,*
 FROM syslogins 
 --WHERE loginname LIKE '%580%'
 order by 3 desc

 --logins
    SELECT * from sys.sql_logins
    --users
    SELECT * from sys.sysusers


	EXEC sp_helplogins

	EXEC sp_who2;

