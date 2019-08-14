SELECT con.relname AS child_table,
    att2.attname AS child_column,
    cl.relname AS parent_table,
    att.attname AS parent_column
   FROM ( 
       SELECT 
         unnest(con1.conkey) AS parent,
         unnest(con1.confkey) AS child,
         con1.confrelid,
         con1.conrelid,
         cl_1.relname
       FROM 
         pg_class cl_1,
         pg_namespace ns,
         pg_constraint con1
       WHERE 
         con1.contype = 'f'::"char" 
         AND cl_1.relnamespace = ns.oid 
         AND con1.conrelid = cl_1.oid
  ) con,
    pg_attribute att,
    pg_class cl,
    pg_attribute att2
  WHERE 
    att.attrelid = con.confrelid 
    AND att.attnum = con.child 
    AND cl.oid = con.confrelid
    AND att2.attrelid = con.conrelid 
    AND att2.attnum = con.parent