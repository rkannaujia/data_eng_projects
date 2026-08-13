/* Create a report showing total sales for each of the following categories:
High(sales over 50) , Medium (sales 21-50) and Low (sales, 20 or less)
sort the categories from highest to lowest
*/

SELECT 
Category, SUM(Sales) AS "Total_sales"
FROM( SELECT
o.OrderID,
o.Quantity,
o.Sales,
CASE
WHEN o.Sales > 50 THEN 'High'
WHEN o.Sales >20 THEN 'Medium'
ELSE 'Low'
END AS 'Category'
FROM SalesDB.Sales.Orders o
) AS t
group by Category
order by Total_sales DESC

-- quick format of case
SELECT
c.CustomerID,
CONCAT(c.FirstName,COALESCE(c.LastName,'')),
CASE c.Country
WHEN 'Germany' THEN 'GE'
WHEN 'USA' THEN 'US'
ELSE 'N/A'
END country_abbrevation
 FROM SalesDB.Sales.Customers c

 ---Handling NULLS
 /* Find the average score of customers and treats nulls as 0
 Additionally provide details such customerID and LastName
 */

 SELECT 
 c.CustomerID,
 CASE 
 WHEN c.LastName IS NULL THEN 'UNKNOW'
 ELSE c.LastName
 END LastName,
 --AVG(COALESCE(c.Score,0)) OVER() AS score_avg
 CASE 
 WHEN c.Score IS NULL THEN 0
 ELSE c.Score
 END cleaned_score,
 AVG(CASE 
 WHEN c.Score IS NULL THEN 0
 ELSE c.Score
 END) OVER () cleaned_score_avg
 FROM SalesDB.Sales.Customers c

 --count how many times each customer has made an order with sales greater than 30
  SELECT 
  o.CustomerID,
  SUM(CASE 
  WHEN o.Sales > 30 THEN 1
  ELSE 0
  END) AS orders_Count_sales30,
  count(*) TotalOrders
  FROM SalesDB.Sales.Orders o
  group by o.CustomerID

