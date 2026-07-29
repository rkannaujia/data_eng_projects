--ROW_NUMBER=>It assign rank to each row and does not hamdles ties
--Rank the orders based  on their sales from highest to lowest
SELECT
	o.OrderID,o.OrderDate,o.OrderStatus,
	o.Sales,
	ROW_NUMBER() OVER(ORDER BY o.Sales DESC) AS rank_sales_high_to_low
FROM SalesDB.Sales.Orders o

--RANK()===> It assign rank to each row. IT handles ties(shared ranking). It leaves gap in ranking
--Rank the orders based  on their sales from highest to lowest
SELECT
	o.OrderID,o.OrderDate,o.OrderStatus,
	o.Sales,
	ROW_NUMBER() OVER(ORDER BY o.Sales DESC) AS rank_sales_high_to_low_using_ROW_MUMBER,
	RANK() OVER(ORDER BY o.Sales DESC) AS rank_sales_high_to_low_using_RANK
FROM SalesDB.Sales.Orders o

--DENSE_RANK()===> It assign rank to each row. IT handles ties(shared ranking). It doesn't leaves gap in ranking
--Rank the orders based  on their sales from highest to lowest
SELECT
	o.OrderID,o.OrderDate,o.OrderStatus,
	o.Sales,
	ROW_NUMBER() OVER(ORDER BY o.Sales DESC) AS rank_sales_high_to_low_using_ROW_MUMBER,
	RANK() OVER(ORDER BY o.Sales DESC) AS rank_sales_high_to_low_using_RANK,
	DENSE_RANK() OVER(ORDER BY o.Sales DESC) AS rank_sales_high_to_low_using_DENSE_RANK
FROM SalesDB.Sales.Orders o

--IMP question
--Find the top highest sales for each product
SELECT * from (
SELECT 
o.OrderID,
o.ProductID,
o.OrderDate,
o.Sales,
ROW_NUMBER() OVER(PARTITION BY o.ProductID ORDER BY o.Sales DESC) AS product_wise_rank
FROM SalesDB.Sales.Orders o
) AS t WHERE product_wise_rank = 1

--Find the lowest two customers based on their total sales
SELECT * FROM (
SELECT 
o.CustomerID,
SUM(o.Sales) AS Total_sales,
ROW_NUMBER() OVER(ORDER BY SUM(o.Sales)) AS rank_cust
FROM SalesDB.Sales.Orders o
Group by o.CustomerID
) AS t where CustomerID <=2

--Identify duplicates rows in the table 'Order Archive' and return the clean result without any duplicates
SELECT * from (
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) as order_rank
FROM SalesDB.Sales.OrdersArchive
) as t where order_rank = 1


--cume_dist() Cumulative Distribution calculates the distribution of data point within a window
--cume_dist=position_no./no. of rows
SELECT 
o.OrderID,
o.OrderDate,
o.Sales,
cume_dist() OVER(ORDER BY o.Sales) AS Cumulative_dist_percent
FROM SalesDB.Sales.Orders o

--PERCENT_RANK= position_no -1/ no_of_rows -1
SELECT 
o.OrderID,
o.OrderDate,
o.Sales,
round(PERCENT_RANK() OVER(ORDER BY o.Sales),2) AS percentile
FROM SalesDB.Sales.Orders o

-- find the product that fall within the highest 40% of the price
SELECT *, CONCAT(dist_rank*100,'%') AS dist_rank_percent
FROM (SELECT
*,
CUME_DIST() OVER(order by price DESC) as dist_rank
FROM SalesDB.Sales.Products) AS t WHERE dist_rank <=0.4

--same with PERCENT_RANK
SELECT *, CONCAT(dist_rank*100,'%') AS dist_rank_percent
FROM (SELECT
*,
PERCENT_RANK() OVER(order by price DESC) as dist_rank
FROM SalesDB.Sales.Products) AS t WHERE dist_rank <=0.4

--NTILE => devides the rows into a specified number of approximately equal groups(Bucket)
SELECT
OrderID,
Sales,
NTILE(1) OVER(ORDER BY Sales DESC) one_bucket,
NTILE(2) OVER(ORDER BY Sales DESC) one_bucket,
NTILE(3) OVER(ORDER BY Sales DESC) one_bucket
FROM SalesDB.Sales.Orders

--segment all orders into three categories high, medium and low
SELECT
*,
CASE bucket
	WHEN 1 THEN 'High'
	WHEN 2 THEN 'MEDIUM'
	WHEN 3 THEN 'LOW'
END sales_segmentation
FROM(
SELECT
OrderID,
Sales,
NTILE(3) OVER(ORDER BY Sales DESC) bucket
FROM SalesDB.Sales.Orders
) AS t


-- In order to export the data of the order table devide the data into 4 group
SELECT
NTILE(4) OVER(ORDER BY Sales DESC) bucket,
*
FROM SalesDB.Sales.Orders