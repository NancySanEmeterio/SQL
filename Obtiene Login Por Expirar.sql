SELECT name AS LoginName, 
   DATEADD(DAY, CAST(LOGINPROPERTY(name, 'DaysUntilExpiration') AS int), GETDATE()) AS ExpirationDate,
   create_date,
   DATEDIFF(dd, DATEADD(DAY, CAST(LOGINPROPERTY(name, 'DaysUntilExpiration') AS int), GETDATE()) , getdate())
   FROM sys.server_principals
   WHERE isnull( DATEADD(DAY, CAST(LOGINPROPERTY(name, 'DaysUntilExpiration') AS int), GETDATE()),'') <>''
   and DATEDIFF(dd, DATEADD(DAY, CAST(LOGINPROPERTY(name, 'DaysUntilExpiration') AS int), GETDATE()) , getdate()) < 0