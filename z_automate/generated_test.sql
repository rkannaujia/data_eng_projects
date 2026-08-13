
-- ============================================================
-- AUTO GENERATED DATA WAREHOUSE SQL
-- ============================================================

USE master;
GO

USE test;
GO

-- Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO


-- ==================================================

-- Source File: C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv

-- Table: bronze.cust_info

-- Rows Loaded: 18494

-- SQL Server Rows: 18494

-- ==================================================


CREATE TABLE [bronze].[cust_info]
(
    [cst_id] NVARCHAR(50),
    [cst_key] NVARCHAR(50),
    [cst_firstname] NVARCHAR(50),
    [cst_lastname] NVARCHAR(50),
    [cst_marital_status] NVARCHAR(50),
    [cst_gndr] NVARCHAR(50),
    [cst_create_date] NVARCHAR(50)
);


-- Data loaded using Python
-- Original CSV:
-- C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv

-- Validation
SELECT COUNT(*) AS row_count
FROM bronze.cust_info;

SELECT TOP 100 *
FROM bronze.cust_info;


-- ==================================================

-- Source File: C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv

-- Table: bronze.prd_info

-- Rows Loaded: 397

-- SQL Server Rows: 397

-- ==================================================


CREATE TABLE [bronze].[prd_info]
(
    [prd_id] INT,
    [prd_key] NVARCHAR(50),
    [prd_nm] NVARCHAR(50),
    [prd_cost] NVARCHAR(50),
    [prd_line] NVARCHAR(50),
    [prd_start_dt] DATE,
    [prd_end_dt] NVARCHAR(50)
);


-- Data loaded using Python
-- Original CSV:
-- C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv

-- Validation
SELECT COUNT(*) AS row_count
FROM bronze.prd_info;

SELECT TOP 100 *
FROM bronze.prd_info;


-- ==================================================

-- Source File: C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv

-- Table: bronze.sales_details

-- Rows Loaded: 60398

-- SQL Server Rows: 60398

-- ==================================================


CREATE TABLE [bronze].[sales_details]
(
    [sls_ord_num] NVARCHAR(50),
    [sls_prd_key] NVARCHAR(50),
    [sls_cust_id] INT,
    [sls_order_dt] INT,
    [sls_ship_dt] INT,
    [sls_due_dt] INT,
    [sls_sales] NVARCHAR(50),
    [sls_quantity] INT,
    [sls_price] NVARCHAR(50)
);


-- Data loaded using Python
-- Original CSV:
-- C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv

-- Validation
SELECT COUNT(*) AS row_count
FROM bronze.sales_details;

SELECT TOP 100 *
FROM bronze.sales_details;


-- ==================================================

-- Source File: C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv

-- Table: bronze.CUST_AZ12

-- Rows Loaded: 18484

-- SQL Server Rows: 18484

-- ==================================================


CREATE TABLE [bronze].[CUST_AZ12]
(
    [CID] NVARCHAR(50),
    [BDATE] NVARCHAR(50),
    [GEN] NVARCHAR(50)
);


-- Data loaded using Python
-- Original CSV:
-- C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv

-- Validation
SELECT COUNT(*) AS row_count
FROM bronze.CUST_AZ12;

SELECT TOP 100 *
FROM bronze.CUST_AZ12;


-- ==================================================

-- Source File: C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv

-- Table: bronze.LOC_A101

-- Rows Loaded: 18484

-- SQL Server Rows: 18484

-- ==================================================


CREATE TABLE [bronze].[LOC_A101]
(
    [CID] NVARCHAR(50),
    [CNTRY] NVARCHAR(50)
);


-- Data loaded using Python
-- Original CSV:
-- C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv

-- Validation
SELECT COUNT(*) AS row_count
FROM bronze.LOC_A101;

SELECT TOP 100 *
FROM bronze.LOC_A101;
