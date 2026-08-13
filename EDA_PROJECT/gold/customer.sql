
/* 
dimension=>who,where,what
fatc table=>how many, how much
customer
CRM Table=>crm_cust_info (customer Information) pk=> cst_id,cst_key
ERP TABLE=> 
1.erp_cust_az12 (extra customer informatin birtdate gender)=> pk cid
2.1.erp_loc_a101 (location of customers)=> pk cid
*/
use DataWarehouse
SELECT TOP 10 * FROM DataWarehouse.silver.erp_loc_a101

CREATE VIEW  gold.dim_customers_v AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key, --surrogate key(sytem genreted unique identifier)
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
	ela.cntry AS country,
    ci.cst_material_status AS marital_status,
	eca.bdate AS birthdate,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		ELSE COALESCE(eca.gen,'n/a')
	END AS gender,
	ci.cst_create_date AS create_date
FROM DataWarehouse.silver.crm_cust_info ci
LEFT JOIN DataWarehouse.silver.erp_cust_az12 eca ON ci.cst_key =eca.cid
LEFT JOIN DataWarehouse.silver.erp_loc_a101 ela ON ci.cst_key =ela.cid

SELECT * FROM DataWarehouse.gold.dim_customers_v