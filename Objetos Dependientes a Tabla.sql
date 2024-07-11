USE AdventureWorks2022;
GO
SELECT * FROM sys.sql_expression_dependencies
WHERE referencing_id = OBJECT_ID(N'Production.vProductAndDescription');