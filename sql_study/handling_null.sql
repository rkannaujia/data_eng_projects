/*
using SalesDB, retrive a list of all orders along 
with the related customer product and employee details
*/

SELECT 
*
FROM 
SalesDB.Sales.Orders o
INNER JOIN SalesDB.Sales.Customers c ON o.CustomerID = c.CustomerID
INNER JOIN SalesDB.Sales.Products p ON o.ProductID = p.ProductID
INNER JOIN SalesDB.Sales.Employees e ON o.SalesPersonID =e.EmployeeID

/*Dsiplay the full name of customers in a single field by merging their first & 
last name and add 10 bonus points to each customers score
*/

SELECT 
CONCAT(c.FirstName,' ',COALESCE(c.LastName,'')) AS fullname,
c.Score,
COALESCE(c.Score,0)+10 AS new_score
FROM 
SalesDB.Sales.Customers c


--find the sales price for each order by deviding sales by quantity
SELECT 
o.OrderID,
o.OrderDate,
o.Sales,
o.Quantity,
(o.Sales/NULLIF(o.Quantity,0)) AS sales_divideby_quantity
FROM 
SalesDB.Sales.Orders o

--identify the customers who have no scores
SELECT * FROM SalesDB.Sales.Customers c where c.Score IS NULL

--list all details of customers who have not placed any orders
SELECT 
c.*,
o.OrderID
FROM
SalesDB.Sales.Customers c
LEFT JOIN SalesDB.Sales.Orders o ON o.CustomerID = c.CustomerID
WHERE o.CustomerID IS  NULL

