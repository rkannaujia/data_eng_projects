/*
CRM Table=>crm_sales_details (transactional record about sales and order) pk=> prd_key, cst_id
*/
use DataWarehouse
CREATE view gold.fact_sales_v AS
SELECT
csd.sales_ord_num AS order_number,
dpv.product_key,
dcv.customer_key,
csd.sls_order_dt AS order_date,
csd.sls_ship_dt AS shpping_date,
csd.sls_due_dt AS due_date,
csd.sls_sales AS sales_amount,
csd.sls_quantity AS quantity,
csd.sls_price AS price
FROM DataWarehouse.silver.crm_sales_details csd
LEFT JOIN DataWarehouse.gold.dim_products_v dpv ON csd.sales_prd_key = dpv.product_number
LEFT JOIN DataWarehouse.gold.dim_customers_v dcv ON csd.sls_cust_id = dcv.customer_id


SELECT * FROM DataWarehouse.gold.fact_sales_v