use MyDatabase
select * from customers;
-- change the score customers 6 to 0
update customers set score = 0 
where id = 6;

-- update all customers with a NULL score by steeing their score 0
update customers set score = 0
where score is NULL