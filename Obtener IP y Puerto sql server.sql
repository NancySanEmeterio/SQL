DECLARE @ip_address       varchar(15)
DECLARE @tcp_port         int 
DECLARE @connectionstring nvarchar(max) 
DECLARE @parm_definition  nvarchar(max)
DECLARE @command          nvarchar(max)

SET @connectionstring = N'Server=tcp:' + @@SERVERNAME + ';Trusted_Connection=yes;'
SET @parm_definition  = N'@ip_address_OUT varchar(15) OUTPUT
                        , @tcp_port_OUT   int         OUTPUT';

SET @command          = N'SELECT  @ip_address_OUT = a.local_net_address,
                                  @tcp_port_OUT   = a.local_tcp_port
                          FROM OPENROWSET(''SQLNCLI''
                                 , ''' + @connectionstring + '''
                                 , ''SELECT local_net_address
                                          , local_tcp_port
                                     FROM sys.dm_exec_connections
                                     WHERE session_id = @@spid
                                   '') as a'

EXEC SP_executeSQL @command
                 , @parm_definition
                 , @ip_address_OUT = @ip_address OUTPUT
                 , @tcp_port_OUT   = @tcp_port OUTPUT;


SELECT @ip_address, @tcp_port