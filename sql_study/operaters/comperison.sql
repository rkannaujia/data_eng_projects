--where operators
/**
1.Comparison operators =, <> =!, >,>=,<,<=
2.logical operators  AND,OR,NOT
3.Range operator BETWEEN
4. Membership operator IN, NOT IN
5.Search operator LIKE
**/
use MyDatabase
-- 1.Comparison operators =, <> =!, >,>=,<,<=
/**
= checks if two values are equal
<>, =! checks if two values are not equal
> check if a value is greater than another value
>= check if a value is greater than or equal to another value
< check if a value is less than another value
>= check if a value is less than or equal to another value
**/
--Retrive all customers from Germany
select * from customers where country = 'Germany'; 
--Retrive all customers who are not from Germany
select * from customers where country <> 'Germany';
--Retrive all customers with a score greater than 500
select * from customers where score > 500;
--Retrive all customers with a score of 500 or more
select * from customers where score >= 500;
--Retrive all customers with a score less than 500
select * from customers where score < 500;
--Retrive all customers with a score of 500 or less
select * from customers where score <= 500;
