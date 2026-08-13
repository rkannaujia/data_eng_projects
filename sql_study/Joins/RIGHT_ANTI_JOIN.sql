/*
RIGHT ANTI JOIN
return rows from the RIGHT table that has no match in LEFT table
=> return all unmatching rows from RIGHT TABLE 
*/
--get all orders without matching customers

SELECT 
* 
FROM 
MyDatabase.dbo.customers AS c
RIGHT JOIN MyDatabase.dbo.orders as o
ON c.id=o.customer_id
WHERE c.id IS NULL

--get all orders without matching customers (USING LEFT JOIN)
SELECT 
* 
FROM 
MyDatabase.dbo.orders as o
LEFT JOIN MyDatabase.dbo.customers AS c
ON c.id=o.customer_id
where c.id IS NULL