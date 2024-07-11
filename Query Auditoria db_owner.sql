DECLARE @Contador INT
DEclare @Rows int
DECLARE @NameDb varchar(50)

Set @Contador = 1

DECLARE @tbldatabase TABLE
(
Name varchar(50) NOT NULL,
dbID CHAR(11) NOT NULL
)

INSERT INTO @tbldatabase
SELECT name, dbid FROM sysdatabases

SET @Rows=(SELECT count(*) FROM @tbldatabase)
WHILE @Contador<=@Rows
BEGIN
SET @NameDb = (SELECT Name FROM @tbldatabase WHERE dbid = @Contador and Name not in ('master','model','inv0mxdb'))
Select @NameDb BaseDatos
begin try
exec('USE ' + @Namedb + ' exec sp_helpuser db_owner')
end try
begin catch
select 'sin permisos a base de datos'
end catch
SET @Contador = @Contador + 1
END
