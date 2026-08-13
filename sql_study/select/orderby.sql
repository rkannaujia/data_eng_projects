--Retrieve all customers & sort the results by the highest score first
select * from customers order by score DESC

--Retrieve all customers & sort the results by the lowest score first
select * from customers order by score ASC

--NESTED order by
-- Retrive all customers and sort the result by the country and then by the highest score
select * from customers order by country asc, score desc