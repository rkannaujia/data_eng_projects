-- INNER JOIN
-- Returns only the matching records from both Table A and Table B
/** get all customers along with their orders, but only for customers who have placed an order
**/
use MyDatabase

SELECT 
*
FROM MyDatabase.dbo.customers AS c
INNER JOIN MyDatabase.dbo.orders AS o
on c.id = o.customer_id

--only first_name,country,score order_date and sales

SELECT
c.id, c.first_name, o.order_id, o.order_date, o.sales
FROM MyDatabase.dbo.customers AS c
INNER JOIN MyDatabase.dbo.orders AS o
ON c.id = o.customer_id