

use DataWarehouse;
GO

CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE,
);


TRUNCATE TABLE bronze.crm_cust_info;
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH(
FIRSTROW =2,
FIELDTERMINATOR =',',
TABLOCK
)
--check data and count match columns and count with csv
SELECT * FROM DataWarehouse.bronze.crm_cust_info;
SELECT count(*) FROM DataWarehouse.bronze.crm_cust_info


CREATE TABLE bronze.crm_prd_info(
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
)


TRUNCATE TABLE bronze.crm_prd_info;
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH(
FIRSTROW =2,
FIELDTERMINATOR =',',
TABLOCK
)
--check data and count match columns and count with csv
SELECT * FROM DataWarehouse.bronze.crm_prd_info;
SELECT count(*) FROM DataWarehouse.bronze.crm_prd_info

CREATE TABLE bronze.crm_sales_details(
sales_ord_num NVARCHAR(50),
sales_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT
,sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
)

TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH(
FIRSTROW =2,
FIELDTERMINATOR =',',
TABLOCK
)
--check data and count match columns and count with csv
SELECT * FROM DataWarehouse.bronze.crm_sales_details;
SELECT count(*) FROM DataWarehouse.bronze.crm_sales_details

CREATE TABLE bronze.erp_loc_a101(
cid NVARCHAR(50),
CNTRY NVARCHAR(50)
)

TRUNCATE TABLE bronze.erp_loc_a101;
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH(
FIRSTROW =2,
FIELDTERMINATOR =',',
TABLOCK
)
--check data and count match columns and count with csv
SELECT * FROM DataWarehouse.bronze.erp_loc_a101;
SELECT count(*) FROM DataWarehouse.bronze.erp_loc_a101

CREATE TABLE bronze.erp_cust_az12(
cid NVARCHAR(50),
bdate DATE,
gen NVARCHAR(50)
)
TRUNCATE TABLE bronze.erp_cust_az12;
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH(
FIRSTROW =2,
FIELDTERMINATOR =',',
TABLOCK
)
--check data and count match columns and count with csv
SELECT * FROM DataWarehouse.bronze.erp_cust_az12;
SELECT count(*) FROM DataWarehouse.bronze.erp_cust_az12

CREATE TABLE bronze.erp_px_cat_g1v2(
id NVARCHAR(50),
cat NVARCHAR(50),
subcat NVARCHAR(50),
maintenance NVARCHAR(50)
)

TRUNCATE TABLE bronze.erp_px_cat_g1v2;
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH(
FIRSTROW =2,
FIELDTERMINATOR =',',
TABLOCK
)
--check data and count match columns and count with csv
SELECT * FROM DataWarehouse.bronze.erp_px_cat_g1v2;
SELECT count(*) FROM DataWarehouse.bronze.erp_px_cat_g1v2