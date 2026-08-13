SELECT 
cid,
REPLACE(cid,'-','') AS cid,
CASE
	WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
	WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	ELSE TRIM(cntry)
END AS cntry
from DataWarehouse.bronze.erp_loc_a101

--check the joining key is proper or not
SELECT cst_key from DataWarehouse.silver.crm_cust_info

SELECT 
cid,
REPLACE(cid,'-','') AS cid,
cntry
from DataWarehouse.bronze.erp_loc_a101 WHERE REPLACE(cid,'-','') NOT IN (SELECT cst_key from DataWarehouse.silver.crm_cust_info)

  --Data standerization and consistency
  SELECT distinct cntry,
  CASE
	WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
	WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	ELSE TRIM(cntry)
END AS cntry
from DataWarehouse.bronze.erp_loc_a101

-- data insertion in silver
INSERT INTO DataWarehouse.silver.erp_loc_a101 (cid,cntry)
SELECT 
REPLACE(cid,'-','') AS cid,
CASE
	WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
	WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	ELSE TRIM(cntry)
END AS cntry
from DataWarehouse.bronze.erp_loc_a101

SELECT * FROM  DataWarehouse.silver.erp_loc_a101