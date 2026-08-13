--LEAD()=> Access a value from the next row within a window
--LAG()=>Access a value from a previous row within a window

--Analyze the month-over-month performance by finding the percentage change
--in sales b/w the current and previous month

SELECT
	OrderID,
	OrderDate,
	MONTH(OrderDate) AS oder_month,
	Sales

FROM SalesDB.Sales.Orders