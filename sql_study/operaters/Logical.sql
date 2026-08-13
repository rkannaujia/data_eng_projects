--where operators
/**
1.Comparison operators =, <> =!, >,>=,<,<=
2.logical operators  AND,OR,NOT
3.Range operator BETWEEN
4. Membership operator IN, NOT IN
5.Search operator LIKE
**/
use MyDatabase
--2.logical operators  AND,OR,NOT
/**
AND All condition must be TRUE
OR At least one condition must be true
NOT (Reverse) Excludes Matching value
**/

--Retrive all customers who are from USA and have a score greater than 500
select * from customers where country = 'USA' AND score > 500; 

--Retrive all customers who are either from USA OR have a score greater than 500
select * from customers where country = 'USA' OR score > 500; 

--Retrive all customers with a score NOT less than 500
select * from customers where NOT score < 500; 
