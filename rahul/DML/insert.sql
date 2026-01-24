use MyDatabase
select * from customers;
insert into customers(id,first_name,country,score) 
values 
(6,'Rahul','India',950),
(7,'John','USA',NULL)

-- copy the data in another table
select * into customers_bkp from customers 

select * from customers_bkp