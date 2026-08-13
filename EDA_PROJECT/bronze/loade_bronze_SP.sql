USE [DataWarehouse]
GO

/****** Object:  StoredProcedure [bronze].[loade_bronze]    Script Date: 31-07-2026 01:45:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE     PROCEDURE [bronze].[loade_bronze] AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
			SET @batch_start_time =GETDATE();
			PRINT '======================================================';
			PRINT 'Loading Bronze Layer';
			PRINT '======================================================';
			PRINT '------------------------------------------------------';
			PRINT 'Loading CRM Tables';
			PRINT '------------------------------------------------------';
			SET @start_time =GETDATE();
			PRINT '>> Turncating table: bronze.crm_cust_info';
			TRUNCATE TABLE bronze.crm_cust_info;
			PRINT '>> Inserting data into: bronze.crm_cust_info';
			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			WITH(
			FIRSTROW =2,
			FIELDTERMINATOR =',',
			TABLOCK
			)
			SET @end_time = GETDATE();
			PRINT '>>LOAD DURATION : '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' second';

			SET @start_time =GETDATE();
			PRINT '>> Turncating table: bronze.crm_prd_info';
			TRUNCATE TABLE bronze.crm_prd_info;
			PRINT '>> Inserting data into: bronze.crm_prd_info';
			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			WITH(
			FIRSTROW =2,
			FIELDTERMINATOR =',',
			TABLOCK
			)
			SET @end_time = GETDATE();
			PRINT '>>LOAD DURATION : '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' second';

			SET @start_time =GETDATE();
			PRINT '>> Turncating table: bronze.crm_sales_details';
			TRUNCATE TABLE bronze.crm_sales_details;
			PRINT '>> Inserting data into: bronze.crm_sales_details';
			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			WITH(
			FIRSTROW =2,
			FIELDTERMINATOR =',',
			TABLOCK
			)
			SET @end_time = GETDATE();
			PRINT '>>LOAD DURATION : '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' second';

			PRINT '------------------------------------------------------';
			PRINT 'Loading ERP Tables';
			PRINT '------------------------------------------------------';

			SET @start_time =GETDATE();
			PRINT '>> Turncating table: bronze.erp_loc_a101';
			TRUNCATE TABLE bronze.erp_loc_a101;
			PRINT '>> Turncating table: bronze.erp_loc_a101';
			BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			WITH(
			FIRSTROW =2,
			FIELDTERMINATOR =',',
			TABLOCK
			)
			SET @end_time = GETDATE();
			PRINT '>>LOAD DURATION : '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' second';

			SET @start_time =GETDATE();
			PRINT '>> Turncating table: bronze.erp_cust_az12';
			TRUNCATE TABLE bronze.erp_cust_az12;
			PRINT '>> Inserting data into: bronze.erp_cust_az12';
			BULK INSERT bronze.erp_cust_az12
			FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			WITH(
			FIRSTROW =2,
			FIELDTERMINATOR =',',
			TABLOCK
			)
			SET @end_time = GETDATE();
			PRINT '>>LOAD DURATION : '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' second';

			SET @start_time =GETDATE();
			PRINT '>> Turncating table: bronze.erp_px_cat_g1v2';
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;
			PRINT '>> Inserting data into: bronze.erp_px_cat_g1v2';
			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'C:\Users\Numantra\OneDrive - NuMantra Technologies\Desktop\Usql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			WITH(
			FIRSTROW =2,
			FIELDTERMINATOR =',',
			TABLOCK
			)
			SET @end_time = GETDATE();
			PRINT '>>LOAD DURATION : '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' second';
			PRINT '-----------------------------------------------'
			SET @batch_end_time =GETDATE();
			PRINT '-----------------------------------------------'
			PRINT '>>Total LOAD DURATION : '+ CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' second';
		END TRY
		BEGIN CATCH
			PRINT '========================================================================';
			print 'Error eccored during loading bronze layer';
			print 'Error message'+ERROR_MESSAGE();
			print 'Error message'+CAST(ERROR_NUMBER() AS NVARCHAR);
			print 'Error message'+CAST(ERROR_STATE() AS NVARCHAR);
			PRINT '========================================================================';
		END CATCH
END;
GO


