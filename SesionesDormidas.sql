							SELECT rtrim(ltrim(status)) , COUNT(1)
			FROM sys.sysprocesses
			WHERE spid NOT IN (@@spid) -- Exclude current session
			AND spid > 50 -- Exclude system spid
			-- AND rtrim(ltrim(status))  in ('sleeping' /*,'suspended' */)     
			 --AND  last_batch  < GETDATE() - 10   
			 GROUP BY rtrim(ltrim(status)) 
			
-------------------------------------------

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


-------------------------------------------

					SELECT rtrim(ltrim(status)) , COUNT(1)
			FROM sys.sysprocesses
			WHERE spid NOT IN (@@spid) -- Exclude current session
			AND spid > 50 -- Exclude system spid
			-- AND rtrim(ltrim(status))  in ('sleeping' /*,'suspended' */)     
			 --AND  last_batch  < GETDATE() - 10   
			 GROUP BY rtrim(ltrim(status)) 