/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time=GETDATE();
		PRINT '-----------------------------';
		PRINT 'Loading Bronze Layer';
		PRINT '-----------------------------';

		PRINT '-------Loading CRM Tables------'

		SET @start_time=GETDATE();
		PRINT'>>Truncating table:bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info

		print 'Inserting Data:bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'E:\DataWarehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION:'+CAST(DATEDIFF(SECOND,@start_time,@end_time)as nvarchar)+'seconds';
		print'>>------------------';

		SET @start_time=GETDATE();
		PRINT'>>Truncating table:bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info
		print 'Inserting Data:bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'E:\DataWarehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION:'+CAST(DATEDIFF(SECOND,@start_time,@end_time)as nvarchar)+'seconds';
		print'>>------------------';

		SET @start_time=GETDATE();
		PRINT'>>Truncating table:bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details
		print 'Inserting Data:bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'E:\DataWarehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION:'+CAST(DATEDIFF(SECOND,@start_time,@end_time)as nvarchar)+'seconds';
		print'>>------------------';


		PRINT '-------Loading ERP Tables------'

		SET @start_time=GETDATE();
		PRINT'>>Truncating table:bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12
		print 'Inserting Data:bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'E:\DataWarehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION:'+CAST(DATEDIFF(SECOND,@start_time,@end_time)as nvarchar)+'seconds';
		print'>>------------------';

		SET @start_time=GETDATE();
		PRINT'>>Truncating table:bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101
		print 'Inserting Data:bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'E:\DataWarehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION:'+CAST(DATEDIFF(SECOND,@start_time,@end_time)as nvarchar)+'seconds';
		print'>>------------------';

		
		SET @start_time=GETDATE();
		PRINT'>>Truncating table:bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		print 'Inserting Data:bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'E:\DataWarehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION:'+CAST(DATEDIFF(SECOND,@start_time,@end_time)as nvarchar)+'seconds';
		
		SET @batch_end_time=GETDATE()
		print'--------------------'
		print'Loading Bronzr Layer is Completed'
		print'Total Load Duration:'+cast(datediff(second,@batch_start_time,@batch_end_time)as nvarchar)+'seconds';
		print'--------------------'
		END TRY

		BEGIN CATCH
		print'======================='
		print'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT'Error Message'+ERROR_MESSAGE();
		PRINT'Error Message'+CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT'Error Message'+CAST(ERROR_STATE() AS NVARCHAR);
		print'======================='
		END CATCH
END
