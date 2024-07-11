SELECT name as 'log file name', 
	size * 8 / 1024 as 'size (MB)',
	max_size * 8 / 1024 as 'growth (MB)',
	type_desc,* 
	FROM sys.database_files
 

         SELECT  
                DBNAME          =DB_NAME(),     
                [FILENAME]      =A.NAME, 
                /*FILE_LOCATION   =a.PHYSICAL_NAME,*/
                FILESIZE_MB     = CONVERT(DECIMAL(10,2),A.SIZE/128.0),
                USEDSPACE_MB    = CONVERT(DECIMAL(10,2),(A.SIZE/128.0 - ((A.SIZE - CAST(FILEPROPERTY(A.NAME,'SPACEUSED') AS INT))/128.0))),
                FREESPACE_MB    = CONVERT(DECIMAL(10,2),(A.SIZE/128.0 -  CAST(FILEPROPERTY(A.NAME,'SPACEUSED') AS INT)/128.0))
    from sys.database_files A
    left join sys.filegroups fg on a.data_space_id = fg.data_space_id
    order by A.type desc,A.name
    ;