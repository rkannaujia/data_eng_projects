SELECT
OrderID,
CreationTime,
--DATENAME example =>it returns the STRING datatype in result
DATENAME(MONTH,CreationTime) as month_datename,
DATENAME(WEEKDAY,CreationTime) as weekday_datename,
--DATEPART example =>it returns the INT datatype in result
DATEPART(yyyy,CreationTime) year_dp,
DATEPART(mm,CreationTime) month_dp,
DATEPART(HH,CreationTime) hour_dp,
DATEPART(QUARTER,CreationTime) quarter_dp,
DATEPART(WEEK,CreationTime) week_dp,

YEAR(CreationTime) year,
MONTH(CreationTime) Month,
DAY(CreationTime) day
FROM SalesDB.Sales.Orders

-- how many orders were placed each year

SELECT 
YEAR(OrderDate) AS year_wise_order,
count(*)
FROM SalesDB.Sales.Orders o
group by YEAR(OrderDate)

-- how many orders were placed each month
SELECT 
DATENAME(MONTH,OrderDate) AS month_wise_order,
count(*)
FROM SalesDB.Sales.Orders o
WHERE YEAR(OrderDate) = '2025'
group by DATENAME(MONTH,OrderDate) 

-- how many orders were placed in month of february
SELECT 
DATENAME(MONTH,OrderDate) AS month_wise_order,
count(*)
FROM SalesDB.Sales.Orders o
WHERE DATENAME(MONTH,OrderDate) = 'February'
group by DATENAME(MONTH,OrderDate)

SELECT *
--DATETRUNC(YEAR,OrderDate) AS order_date_trunc,
--count(*)
FROM SalesDB.Sales.Orders o
group by DATETRUNC(YEAR,OrderDate)

/*
Day, Month, Year, DATEPART =>INT datatype
DATENAME => STRING
DATETRUNC => DATETIME
EOMONTH =>DATE
*/