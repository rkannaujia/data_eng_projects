--use MyDatabase
select * from customers
--find the total score of each country
select country,sum(score) AS Total_score from customers group by country;
--find the total number of customer of each country
select country,count(id) as Total_customer from customers group by country