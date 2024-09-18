 
SELECT * from sys.sysusers
where 
 hasdbaccess = 1 and (
LEFT(name ,7) IN (
							'KCUS\C0','KCUS\C1','KCUS\C2','KCUS\C3','KCUS\C4','KCUS\C5','KCUS\C6','KCUS\C7','KCUS\C8','KCUS\C9',
							'KCUS\F0','KCUS\F1','KCUS\F2','KCUS\F3','KCUS\F4','KCUS\F5','KCUS\F6','KCUS\F7','KCUS\F8','KCUS\F9',
							'KCUS\M0','KCUS\M1','KCUS\M2','KCUS\M3','KCUS\M4','KCUS\M5','KCUS\M6','KCUS\M7','KCUS\M8','KCUS\M9'
					  )
		OR name IN		  ('KCUS\MXMCAP67','KCUS\MXMCAP83')
		OR UPPER(name) LIKE	'%PUBLIC%'
		OR UPPER(name) LIKE	'%DEV%'  )


		

DECLARE @COMANDO varchar(max)

set @COMANDO = 'use [?] SELECT distinct DB_NAME(),  NAME, createdate from sys.sysusers
where   hasdbaccess = 1 and ( LEFT(name ,7) IN (
							''KCUS\C0'',''KCUS\C1'',''KCUS\C2'',''KCUS\C3'',''KCUS\C4'',''KCUS\C5'',''KCUS\C6'',''KCUS\C7'',''KCUS\C8'',''KCUS\C9'', 
							''KCUS\F0'',''KCUS\F1'',''KCUS\F2'',''KCUS\F3'',''KCUS\F4'',''KCUS\F5'',''KCUS\F6'',''KCUS\F7'',''KCUS\CF8'',''KCUS\F9'', 
							''KCUS\M0'',''KCUS\M1'',''KCUS\M2'',''KCUS\M3'',''KCUS\M4'',''KCUS\M5'',''KCUS\M6'',''KCUS\M7'',''KCUS\M8'',''KCUS\M9'' 
					  )
		OR name IN		  (''KCUS\MXMCAP67'',''KCUS\MXMCAP83'') 
		OR UPPER(name) LIKE	''%DEV%''
		OR UPPER(name) LIKE	''%TEST%''
		OR UPPER(name) LIKE	''%READONLY%''
		OR UPPER(name) LIKE	''%QA1.%''
		OR UPPER(name) LIKE	''%QA_PUBLI%'')'


exec sp_msForEachDb @comando
 