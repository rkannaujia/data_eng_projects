-- streaming table 

create streaming table bronze_raw_orders
comment " this is order raw data"
as select * from cloud_files("/Volumes/dlt/default/dlt_files/orders/", "json", 
  map(
    'cloudFiles.inferColumnTypes','true',
    'cloudFiles.includeExistingFiles','true',   -- load existing files first
    'cloudFiles.schemaEvolutionMode','addNewColumns'
  )
);



--- materialized view 



CREATE MATERIALIZED VIEW silver_orders
COMMENT "Curated orders (Completed only) with quality checks"
AS
SELECT
  order_id,
  customer_id,
  country,
  CAST(order_ts AS TIMESTAMP) AS order_ts,
  CAST(amount  AS DOUBLE)     AS amount,
  status
FROM bronze_raw_orders
WHERE status = 'Completed';


-- view 

CREATE VIEW in_orders
COMMENT "India-only orders from Silver"
AS
SELECT *
FROM silver_orders
WHERE country = 'IN';


