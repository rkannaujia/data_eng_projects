/*
FULL ANTI JOIN
Returns only rows that don't match in either tables
=> return all unmatching rows from LEFT and RIGHT  TABLE 
*/

--Find customers without orders and orders without customers

SELECT 
*
FROM
MyDatabase.dbo.customers AS c
FULL JOIN MyDatabase.dbo.orders AS o
ON c.id = o.customer_id
WHERE
c.id IS NULL
OR
o.customer_id IS NULL

--challange
--get all customers along with their orders,but only for customers who have placed an order(do it without using INNER JOIN)
SELECT 
*
FROM
MyDatabase.dbo.customers AS c
FULL JOIN MyDatabase.dbo.orders AS o
ON c.id = o.customer_id
WHERE
c.id IS NOT NULL
AND
o.customer_id IS NOT NULL

