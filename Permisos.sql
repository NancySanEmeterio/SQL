
-- Para visualizar consultas y SP'S
--[cxc0mxdb] BASE DE DATOS 
--[KCUS\C55578] usuario

--TABLA
GRANT SELECT ON OBJECT::[dbo].[InventPurch1Table]  TO  [KCUS\MXMCAP110];
GRANT INSERT ON OBJECT::[dbo].[InventPurch1Table]  TO  [KCUS\MXMCAP110];

--DATABASE
GRANT VIEW DEFINITION on DATABASE:: [eyf0mxdb]    TO  [KCUS\M40622]

--PROCEDURE
GRANT EXEC ON [dbo].[spPY_rptPyPComprometidoIngresosPBI] TO [KCUS\PBI_WS_LAO_Consultas_Historicas_AX_VIEWER_N]


GRANT EXEC TO  [KCUS\M40622]


GRANT EXECUTE   TO [KCUS\M40622]

 
--Quitar Permisos
--REVOKE   EXEC TO  [KCUS\M40622]

--[KCUS\M31635][KCUS\MXMCAP83]
DECLARE @COMANDO varchar(max)

set @COMANDO = 'GRANT EXECUTE   TO [KCUS\M31635]'

exec sp_msForEachDb @comando


 