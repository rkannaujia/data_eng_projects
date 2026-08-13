SELECT 
id,
cat,
subcat,
maintenance
FROM  DataWarehouse.bronze.erp_px_cat_g1v2

--Check unwanted space
SELECT *
FROM  DataWarehouse.bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat !=TRIM(subcat) OR maintenance !=TRIM(maintenance)

--Data standerization and consistency
SELECT DISTINCT cat FROM  DataWarehouse.bronze.erp_px_cat_g1v2;
SELECT DISTINCT subcat FROM  DataWarehouse.bronze.erp_px_cat_g1v2;
SELECT DISTINCT maintenance FROM  DataWarehouse.bronze.erp_px_cat_g1v2;

-- insert the data
INSERT INTO DataWarehouse.silver.erp_px_cat_g1v2 (id,cat,subcat,maintenance)
SELECT 
id,
cat,
subcat,
maintenance
FROM  DataWarehouse.bronze.erp_px_cat_g1v2


SELECT * from DataWarehouse.silver.erp_px_cat_g1v2