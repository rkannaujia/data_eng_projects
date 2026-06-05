import dlt 
from pyspark.sql.functions import *
from pyspark.sql.types import *

@dlt.table(
    name='bronze_orders'
)
def bronze_orders():
    return (
        spark.readStream.format("cloudFiles")
            .option("cloudFiles.format","json")
            .option("cloudFiles.inferColumnTypes", "true")
            .option("cloudFiles.schemaEvolutionMode", "addNewColumns")
            .option("cloudFiles.includeExistingFiles", "true")  # load existing files first
            .load("/Volumes/dlt/default/dlt_files/")
    )
    

@dlt.table(
    name="silver_orders_1",
    comment="Curated orders (Completed only), typed & filtered"
)
@dlt.expect_or_drop("non_negative_amount", "CAST(amount AS DOUBLE) >= 0")
def silver_orders():
    return (
        dlt.read_stream("bronze_orders")
        .withColumn("order_ts", col("order_ts").cast(TimestampType()))
        .withColumn("amount",   col("amount").cast(DoubleType()))
        .filter(col("status") == lit("Completed"))
        .select(
            col("order_id"),
            col("customer_id"),
            col("country"),
            col("order_ts"),
            col("amount"),
            col("status")
        )
        .dropDuplicates(["order_id"])  # simple dedupe by business key
    )


@dlt.view(
    name="in_orders",
    comment="India-only orders (logical view, not materialized)"
)
def in_orders():
    return dlt.read("silver_orders_1").filter(col("country") == lit("IN"))



