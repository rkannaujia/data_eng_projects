DROP TABLE IF EXISTS DataWarehouse.silver.crm_sales_details;

CREATE TABLE DataWarehouse.silver.crm_sales_details (
    sales_ord_num nvarchar(50),
    sales_prd_key nvarchar(50),
    sls_cust_id int,
    sls_order_dt date,
    sls_ship_dt date,
    sls_due_dt date,
    sls_sales int,
    sls_quantity int,
    sls_price int,
    dwh_create_date datetime2(7) DEFAULT GETDATE()
);

INSERT INTO DataWarehouse.silver.crm_sales_details (
    sales_ord_num,
    sales_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price,
    dwh_create_date
)
SELECT 
    sales_ord_num,
    sales_prd_key,
    sls_cust_id,

    -- Safe Date Conversions
    CASE 
        WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
        ELSE TRY_CAST(CAST(sls_order_dt AS varchar(8)) AS DATE)
    END AS sls_order_dt,

    CASE 
        WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
        ELSE TRY_CAST(CAST(sls_ship_dt AS varchar(8)) AS DATE)
    END AS sls_ship_dt,

    CASE 
        WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
        ELSE TRY_CAST(CAST(sls_due_dt AS varchar(8)) AS DATE)
    END AS sls_due_dt,

    -- Calculated Sales Amount
    CASE 
        WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) 
        THEN sls_quantity * ABS(sls_price)
        ELSE sls_sales
    END AS sls_sales,

    sls_quantity,

    -- Calculated Price
    CASE 
        WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales / NULLIF(sls_quantity, 0)
        ELSE sls_price
    END AS sls_price,

    GETDATE() AS dwh_create_date
FROM DataWarehouse.bronze.crm_sales_details;

SELECT * FROM DataWarehouse.silver.crm_sales_details;