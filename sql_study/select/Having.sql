--use MyDatabase
-- HAVING=>filter the data after the aggregation( can be used only with group by)
--Where vs Having. 
--Where=> It is used to filter with before aggregation(filter with actual data)
--Having=>filter the data after the aggregation( can be used only with group by)
select * from customers
--find the average score for each country considering only customers with a score not equal to 0 and return only those countries with an avg score >430
select country,AVG(score) from customers where score != 0 group by country HAVING AVG(score) >430