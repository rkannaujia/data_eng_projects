# Databricks notebook source
# %sql
# create database data_dev.autoloader

# COMMAND ----------

# %sql
# create volume data_dev.autoloader.bronze

# COMMAND ----------

# MAGIC %md
# MAGIC **AUTOLOADER**

# COMMAND ----------

df = spark.readStream.format("cloudFiles")\
    .option("cloudFiles.format","json")\
        .option("cloudFiles.schemaLocation","/Volumes/data_dev/autoloader/bronze/destination/checkpoint/")\
            .option("cloudFiles.schemaEvolutionMode","rescue")\
                .load("/Volumes/data_dev/autoloader/bronze/raw/")
                

# COMMAND ----------

df.writeStream.format("delta")\
    .outputMode("append")\
        .option("checkpointLocation","/Volumes/data_dev/autoloader/bronze/destination/checkpoint/")\
            .trigger(once=True)\
                .start("/Volumes/data_dev/autoloader/bronze/destination/data/")
            

# COMMAND ----------

df1=spark.read.format("delta").load("/Volumes/data_dev/autoloader/bronze/destination/data/")
display(df1)

# COMMAND ----------

