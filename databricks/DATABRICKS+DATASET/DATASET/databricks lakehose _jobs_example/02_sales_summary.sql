-- 02_sales_summary.sql
CREATE OR REPLACE TABLE gold.sales_summary AS
SELECT
    region,
    DATE_TRUNC('month', order_date) AS sales_month,
    SUM(amount) AS total_sales,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM silver.sales_orders
GROUP BY region, DATE_TRUNC('month', order_date);
