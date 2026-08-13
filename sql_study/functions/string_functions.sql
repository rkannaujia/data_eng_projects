
-- string function
-- concat for string concatenation
-- UPPER for UPPER case and LOWER for lower case
SELECT
UPPER(CONCAT(c.first_name,'-',c.country)) AS "name_country"
FROM
MyDatabase.dbo.customers AS c

--TRIM for removing white spaces 
--find which record has white 
SELECT 
c.first_name
FROM MyDatabase.dbo.customers c
WHERE c.first_name != TRIM(c.first_name)

--or we can find like this
SELECT 
LEN(c.first_name) AS "Name_Length",
LEN(TRIM(c.first_name)) AS "TRIM_Name_Length",
LEN(c.first_name)- LEN(TRIM(c.first_name)) AS flag
FROM MyDatabase.dbo.customers c

-- replace function
SELECT
'750-612-841' AS "phone_number",
REPLACE('750-612-841','-','') AS "clean_phone_number",
'report.txt' AS old_file_name,
REPLACE('report.txt','.txt','.csv') AS new_file_name

--Retrive FIRST 2 AND LAST 2 character of the customer first name
SELECT
c.first_name,
LEFT(TRIM(c.first_name),2) AS first_two_char,
RIGHT(c.first_name,2) AS last_two_char
FROM MyDatabase.dbo.customers c

--substring
--retrive a list of customers by removing first character of the firstname
SELECT
SUBSTRING(TRIM(c.first_name),2,LEN(c.first_name))
FROM MyDatabase.dbo.customers c