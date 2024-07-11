--1 Busqueda de Procedures con una palabra 
SELECT  o.name, 
        o.type_desc,
        m.definition
FROM sys.objects o
JOIN sys.sql_modules m ON o.object_id = m.object_id
WHERE m.definition LIKE '%USTCAS551\DAXPROD%';



-- 2 Objetos que dependen de una tabla
EXEC sp_depends @objname = '[dbo].[AE_AutorizacionEntrega]'


		---Buscar objetos por tablas
		SELECT SCHEMA_NAME(o.SCHEMA_ID), o.Name, o.[type]
		FROM sys.sql_modules m
		INNER JOIN sys.objects o
			ON o.object_id = m.object_id
		WHERE m.definition like '%AE_AutorizacionEntrega%'
		GO 

		SELECT * 
		FROM INFORMATION_SCHEMA.ROUTINES 
		WHERE ROUTINE_DEFINITION like '%AE_AutorizacionEntrega%'

		SELECT  o.name, 
				o.type_desc,
				m.definition
		FROM sys.objects o
		JOIN sys.sql_modules m ON o.object_id = m.object_id
		WHERE m.definition LIKE '%AE_AutorizacionEntrega%';



-- 3 Buscar Objeto en todas las bases de datos
 DECLARE @COMANDO varchar(max) 
set @COMANDO = 'use [?] SELECT DB_NAME(), *  FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_DEFINITION like ''%spEVE_ActualizarEstatusArticulosKCM%'''
exec sp_msForEachDb @comando