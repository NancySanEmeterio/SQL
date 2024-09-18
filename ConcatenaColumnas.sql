
SELECT left(descAccionVc,   5) , 
  fecha = STUFF(
    (
      SELECT ',' + CAST(claveAccionSi AS VARCHAR(50))
      FROM [AA_Acciones] X
	  where   left(X.descAccionVc,   5) =  left(Y.descAccionVc,   5)
      FOR XML PATH('')
    ),
    1,
    1,
    ''
  )  
   FROM [AA_Acciones] Y
  group by left(descAccionVc,   5) 