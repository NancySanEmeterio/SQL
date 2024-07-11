BEGIN TRAN;
update  eyf1mxdb..EF_DocumentosFiscalesDetalle set PP_CveEstructurada  = 2 WHERE 1 = 0
WAITFOR DELAY '1:00:00';
--COMMIT TRAN;

--rollback tran

--select top 3 * from EF_DocumentosFiscalesDetalle

 