--Return all the rows from LEFT and RIGHT table

-- Get all costomers and orders even if there is a no match

SELECT
*
FROM
MyDatabase.dbo.customers AS c
FULL JOIN MyDatabase.dbo.orders AS o
ON c.id = o.customer_id
