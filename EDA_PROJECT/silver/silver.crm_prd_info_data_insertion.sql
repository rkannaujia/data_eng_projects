DROP TABLE IF EXISTS DataWarehouse.silver.crm_prd_info;

CREATE TABLE DataWarehouse.silver.crm_prd_info(
    prd_id int,
    cat_id nvarchar(50),
    prd_key nvarchar(50),
    prd_nm nvarchar(50),
    prd_cost int,
    prd_line nvarchar(50),
    prd_start_dt date,
    prd_end_dt date,
    dwh_create_date datetime2 DEFAULT GETDATE()
);

INSERT INTO DataWarehouse.silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT  prd_id
	  ,REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id
	  ,SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key
      ,prd_nm
      ,COALESCE(prd_cost,0) AS prd_cost
      ,CASE 
			WHEN UPPER(TRIM(prd_line)) ='M' THEN 'Mountain'
			WHEN UPPER(TRIM(prd_line)) ='R' THEN 'Road'
			WHEN UPPER(TRIM(prd_line)) ='S' THEN 'Other sales'
			WHEN UPPER(TRIM(prd_line)) ='T' THEN 'Touring'
			ELSE 'n/a'
	 END AS prd_line
      ,CAST(prd_start_dt AS DATE) AS prd_start_dt
      ,CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt
  FROM DataWarehouse.bronze.crm_prd_info

  SELECT * FROM DataWarehouse.silver.crm_prd_info;