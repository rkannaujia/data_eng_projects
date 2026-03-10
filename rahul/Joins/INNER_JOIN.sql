-- INNER JOIN
-- Returns only the matching records from both Table A and Table B
/** get all customers along with their orders, but only for customers who have placed an order
**/
use MyDatabase

SELECT 
*
FROM customers AS c
INNER JOIN orders AS o
on c.id = o.customer_id

--only first_name,country,score order_date and sales

SELECT c.first_name,c.country,c.score,o.order_date,o.sales
FROM customers AS c
INNER JOIN orders AS o
on c.id = o.customer_id