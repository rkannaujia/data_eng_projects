--LEFT JOIN
--Retrive all rows from Left table and only matching rows from table Right

/** Get all customers along with their orders,
including those without orders **/
use MyDatabase
SELECT 
*
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id

-- only first_name,country,score,order_id & sales
SELECT 
c.first_name, c.country,c.score,o.order_id,o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id

/** TASK
Get all customers along with their orders, including orders without matching customers **/
select
* 
from orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id;
