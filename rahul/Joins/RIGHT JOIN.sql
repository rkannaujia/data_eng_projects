--RIGHT JOIN
--IT return all the rows from RIGHT table  and only the mtching rows from LEFT table 
/**Get all customers along with their orders, including orders without macthing customers **/

SELECT 
* 
FROM MyDatabase.dbo.customers AS c
RIGHT JOIN MyDatabase.dbo.orders AS o
ON c.id = o.customer_id

-- only first_name,country,score,order_id & sales
SELECT 
c.first_name, c.country,c.score,o.order_id,o.sales
FROM MyDatabase.dbo.customers AS c
RIGHT JOIN MyDatabase.dbo.orders AS o
ON c.id = o.customer_id