use DataWarehouse
/*
customer
CRM Table=>crm_prd_info (current and history product Information) pk=> prd_key
ERP TABLE=> 
1.erp_px_cat_g1v2 (product categories)=> pk id
*/

SELECT TOP 10 * FROM DataWarehouse.silver.crm_prd_info
CREATE VIEW gold.dim_products_v AS
SELECT
	ROW_NUMBER() OVER(ORDER BY cpi.prd_start_dt, cpi.prd_key) AS product_key,
	cpi.prd_id AS product_id,
	cpi.prd_key AS product_number,
	cpi.prd_nm AS product_name,
	cpi.cat_id AS category_id,
	epc.cat AS category,
	epc.subcat AS subcategory,
	epc.maintenance,
	cpi.prd_cost AS cost,
	cpi.prd_line AS product_line,
	cpi.prd_start_dt AS start_date
FROM DataWarehouse.silver.crm_prd_info cpi
LEFT JOIN DataWarehouse.silver.erp_px_cat_g1v2 epc
ON cpi.cat_id = epc.id
WHERE cpi.prd_end_dt IS NULL --filtered out all historical data=>prd_end_dt is null means product is open now

SELECT * FROM DataWarehouse.gold.dim_products_v


--SELECT prd_key is unique or not
SELECT prd_key,count(*) FROM (
SELECT
	cpi.prd_id,
	cpi.cat_id,
	cpi.prd_key,
	cpi.prd_nm,
	cpi.prd_cost,
	cpi.prd_line,
	cpi.prd_start_dt,
	epc.cat,
	epc.subcat,
	epc.maintenance
FROM DataWarehouse.silver.crm_prd_info cpi
LEFT JOIN DataWarehouse.silver.erp_px_cat_g1v2 epc
ON cpi.cat_id = epc.id
WHERE cpi.prd_end_dt IS NULL ) as t 
group by prd_key having count(*) > 1