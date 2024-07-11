
	SELECT rs.destination_database_name, 
	rs.restore_date, 
	bs.backup_start_date, 
	bs.backup_finish_date, 
	bs.database_name as source_database_name, 
	bmf.physical_device_name as backup_file_used_for_restore
	FROM msdb..restorehistory rs
		INNER JOIN msdb..backupset bs
		ON rs.backup_set_id = bs.backup_set_id
		INNER JOIN msdb..backupmediafamily bmf 
		ON bs.media_set_id = bmf.media_set_id 
	 -- where rtrim(ltrim(rs.destination_database_name)) in ('axa14mxdb','axa15mxdb','axa16mxdb')
		ORDER BY 2 DESC


			SELECT rs.destination_database_name, 
	max(rs.restore_date)
 
	FROM msdb..restorehistory rs
		INNER JOIN msdb..backupset bs
		ON rs.backup_set_id = bs.backup_set_id
		INNER JOIN msdb..backupmediafamily bmf 
		ON bs.media_set_id = bmf.media_set_id 
group by  rs.destination_database_name
order by 1 asc

		 