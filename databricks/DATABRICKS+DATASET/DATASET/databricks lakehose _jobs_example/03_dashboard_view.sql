-- 03_dashboard_view.sql
CREATE OR REPLACE VIEW gold.dashboard_sales AS
SELECT
    region,
    sales_month,
    total_sales,
    unique_customers,
    RANK() OVER (PARTITION BY sales_month ORDER BY total_sales DESC) AS region_rank
FROM gold.sales_summary;
