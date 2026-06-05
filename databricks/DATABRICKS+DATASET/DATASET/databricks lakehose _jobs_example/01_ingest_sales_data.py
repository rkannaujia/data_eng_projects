# Databricks Notebook: 01_ingest_sales_data (Bronze -> Silver)

from pyspark.sql.functions import col, to_date

# Read raw CSV file from path (Bronze layer)
df = (spark.read
      .option("header", "true")
      .csv("/mnt/data/raw_sales_orders.csv"))

# Clean & transform data
df_clean = (df.withColumn("order_date", to_date(col("order_date"), "yyyy-MM-dd"))
              .withColumn("amount", col("amount").cast("decimal(12,2)"))
              .dropna(subset=["order_id","amount"]))

# Write to Silver Delta Table
(df_clean.write.format("delta")
         .mode("overwrite")
         .saveAsTable("silver.sales_orders"))
