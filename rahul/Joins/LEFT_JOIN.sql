--LEFT JOIN
--Retrive all rows from Left table and only matching rows from table Right

/** Get all customers along with their orders,
including those without orders **/
SELECT
* 
from MyDatabase.dbo.customers AS c
LEFT JOIN MyDatabase.dbo.orders AS o
ON c.id= o.customer_id

-- only first_name,country,score,order_id & sales
SELECT 
c.first_name, c.country,c.score,o.order_id,o.sales
FROM MyDatabase.dbo.customers AS c
LEFT JOIN MyDatabase.dbo.orders AS o
ON c.id = o.customer_id

/*
Main table should be first if you want all row from main table and only matching row from another table
*/
select
* 
from MyDatabase.dbo.orders AS o 
LEFT JOIN MyDatabase.dbo.customers AS c
ON c.id = o.customer_id;
