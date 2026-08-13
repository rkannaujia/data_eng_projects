/*
LEFT ANTI JOIN
returns rows from the LEFT table  that has no match in RIGHT table
 return all unmatching rows from LEFT TABLE 
*/
--get all customers who haven't place any orders

SELECT
* 
FROM
MyDatabase.dbo.customers AS c
LEFT JOIN MyDatabase.dbo.orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL
