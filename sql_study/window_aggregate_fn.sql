
--count
SELECT
ProductID,
COUNT(o.Sales) OVER(PARTITION BY o.ProductID) AS product_wise_count
FROM SalesDB.Sales.Orders o

--check wheather the orders contains any duplicates rows
SELECT * FROM(
SELECT 
oa.OrderID,
count(*) OVER(PARTITION BY oa.OrderID) as check_order
FROM SalesDB.Sales.OrdersArchive oa
) AS t WHERE check_order>1

--SUM 
/* FIND the total sales accross all orders. And Total sales for each product
Additdionally provide details such as orderid and orderDate
*/
SELECT
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	o.Sales,
	SUM(o.Sales) OVER() AS Total_sales,
	SUM(o.Sales) OVER(PARTITION BY o.ProductID) AS Total_sales_product_wise
FROM SalesDB.Sales.Orders o

--Find the percentage contribution of each product's sales to the total sales
SELECT
	o.OrderID,
	o.ProductID,
	o.Sales,
	SUM(o.Sales) OVER() AS Total_sales,
	ROUND(CAST(o.Sales AS float) / (SUM(o.Sales) OVER()) * 100 ,2) AS PercentageOfTotal
FROM SalesDB.Sales.Orders o

--Find the average sales accross all orders. AND the average sales for each product.
--Additdionally provide details such as orderid and orderDate
SELECT 
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	o.Sales,
	AVG(o.Sales) OVER() AS avg_sales,
	AVG(COALESCE(o.Sales,0)) OVER(PARTITION BY o.ProductID) AS product_wise_avg_sales
FROM SalesDB.Sales.Orders o

--find the avg scores of customers Additionally provide details such customerID and LastName

SELECT
c.CustomerID, COALESCE(c.LastName,c.FirstName),
c.Score,
AVG(c.Score) OVER()AS avg_score_with_null,
AVG(COALESCE(c.Score,0)) OVER()AS avg_score
FROM SalesDB.Sales.Customers c

--Find all orders where sales are higher than the avg sales accross all orders
SELECT * FROM(
SELECT 
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	o.Sales,
	AVG(COALESCE(o.Sales,0)) OVER() AS avg_sales
FROM SalesDB.Sales.Orders o
) AS t 
Where Sales > avg_sales


--Min/MAX
--show the employee who have the highest salary

SELECT * from (
SELECT
*,
MAX(e.Salary) OVER() AS highest_salary
FROM SalesDB.Sales.Employees e
) AS t WHERE Salary = highest_salary


--calculate moving avg of sales for each product over time
SELECT 
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	o.Sales,
	AVG(COALESCE(o.Sales,0)) OVER() AS avg_sales,
	AVG(COALESCE(o.Sales,0)) OVER(PARTITION BY o.ProductID ORDER BY o.OrderDate) AS moving_avg
FROM SalesDB.Sales.Orders o