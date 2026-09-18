/* 
  Store Procedure :Load Bronze layer
Scrip Purpose: 
    Loads data into bronze schema from external csv file
  Truncate bronze table before loading
   Use BULK INSERT Command to load data


Uses ex:
EXEC bronze.load.bronze
*/

DROP PROCEDURE IF EXISTS bronze.bronze_load_v2;
DROP PROCEDURE IF EXISTS bronze.bronze_load;
GO
CREATE PROCEDURE bronze.bronze_load AS  
BEGIN   
   DECLARE @start_time DATETIME, @end_time DATETIME , @batch_start_time DATETIME , @batch_end_time DATETIME;
	BEGIN TRY
	    SET @batch_start_time = GETDATE();
		PRINT '_______________________________________';
		PRINT 'Loading BRonze layer';
		PRINT '________________________________________';


		PRINT '======================================';
		PRINT 'Loading CRM Section';
		PRINT '======================================';

		SET @start_time=GETDATE();
		PRINT '>>Truncating Table : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>Inserting Data into :bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR =',',
			TABLOCK
			);
		SET @end_time=GETDATE();
        PRINT 'Loading time:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '>>------------------------------------>>'
	    
		SET @start_time=GETDATE();
		PRINT '>>Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>Inserting Data into :bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		   FIRSTROW = 2,
		   FIELDTERMINATOR=',',
		   TABLOCK
		   );
		SET @end_time=GETDATE();
		PRINT 'Loading time for crm_prod_info:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '>>------------------------------------>>'
    
	    
		set @start_time=GETDATE();
		PRINT '>>Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>Inserting Data into :bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		   FIRSTROW = 2,
		   FIELDTERMINATOR=',',
		   TABLOCK
		   );
		SET @end_time=GETDATE();
		PRINT 'Loading time for crm_sales_details:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '>>------------------------------------>>'

    
		PRINT '======================================';
		PRINT('Loading CRM Section');
		PRINT('======================================')

	    SET @start_time=GETDATE();
		PRINT '>>Truncating Table : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>Inserting Data into :bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
		SET @end_time =GETDATE();
		PRINT 'Loading time for cust_az12 table:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '>>------------------------------------>>'
        
		set @Start_Time = GETDATE();
		PRINT '>>Truncating Table : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>Inserting Data into :bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
		SET @end_time =GETDATE();
		PRINT 'Loading time for erp_loc_a101 table:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '>>------------------------------------>>'

        
		SET @start_time=GETDATE();
		PRINT '>>Truncating Table : bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>Inserting Data into :bronze.erp_px_cat_g1v2'
		BULK INSERT  bronze.erp_px_cat_g1v2
		FROM 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
		   FIRSTROW = 2,
		   FIELDTERMINATOR=',',
		   TABLOCK
		   );
		SET @end_time =GETDATE();
		PRINT 'Loading time for erp_px_cat_giv2 table:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '>>------------------------------------>>'
	    SET @batch_end_time = GETDATE();
		PRINT 'Loading time of Bronze layer'+CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+' seconds';

	  END TRY
	  BEGIN CATCH
		     PRINT '====================================================';
			 PRINT 'Error occured during Bronze layer';
			 PRINT 'Error Message'+ERROR_MESSAGE();
			 PRINT 'ERROR NUMBER'+ CAST(ERROR_NUMBER() AS NVARCHAR);
			 PRINT 'ERROR MEssage'+ CAST(ERROR_STATE() AS NVARCHAR);
			 PRINT '====================================================';

	   END CATCH

END;
