--RIGHT JOIN
--Returns all the rows from RIGHT table and matching rows from LEFT join
/**Get all customers along with their orders, including orders without macthing customers **/

use MyDatabase
SELECT 
* 
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id

-- only first_name,country,score,order_id & sales
SELECT 
c.first_name, c.country,c.score,o.order_id,o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id