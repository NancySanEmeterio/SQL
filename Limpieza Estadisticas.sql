--iemCustomBrokerInformation
ALTER INDEX [IX_SellOut_DiaDt] ON SellOut_20052024 REBUILD 
ALTER INDEX [IX_SellOut_IDCadenaVcIDTiendaVc] ON SellOut_20052024 REBUILD 
ALTER INDEX [PK_SellOut] ON SellOut_20052024 REBUILD 

EXEC sp_updatestats;  
 

-- OBTENER ULTIMA ACTUALIZACION DE ESTADISTICAS
 use  axa2mxdb
exec sp_autostats 'dbo.SellOut_20052024'

UPDATE STATISTICS  [dbo].[iemInventIeDocExpenses] WITH FULLSCAN; 
  
ALTER INDEX [I_30405K221015VENDORCODEIDX] ON iemCustomBrokerInformation REBUILD 

select distinct 'ALTER INDEX [' + i.[name] + '] ON SellOut_20052024 REBUILD '
FROM sys.indexes AS i
INNER JOIN sys.data_spaces AS ds ON i.data_space_id = ds.data_space_id
WHERE is_hypothetical = 0 AND i.index_id <> 0
AND i.object_id = OBJECT_ID('SellOut_20052024');


ALTER INDEX [I_30143DOCIDVOUCHARTYPEIDX] ON iemInventIeDocExpenses REBUILD 
ALTER INDEX [I_30143RECID] ON iemInventIeDocExpenses REBUILD 
ALTER INDEX [IX_01KCM05may20_IEMINVENTIEDOCEXPENSES_JOURNALNUM_01] ON iemInventIeDocExpenses REBUILD 
ALTER INDEX [IX_01KCM05may20_IEMINVENTIEDOCEXPENSES_VOUCHERTYPE_01] ON iemInventIeDocExpenses REBUILD 


select count(1) from iemInventIeDocExpenses(nolock)

 