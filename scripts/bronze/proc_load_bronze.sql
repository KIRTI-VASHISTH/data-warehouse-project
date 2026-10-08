--exec bronze.load_bronze
create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
begin try
set @batch_start_time = getdate();
	print'============================';
	print'loading bronze layer';
	print'============================';

	
	print'============================';
	print'loading crm tables';
	print'============================';

	set @start_time = GETDATE();
	print'>> truncating table: bronze.crm_cust_info';

	truncate table bronze.crm_cust_info;

	print'>> inserting in table- bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\docx\data warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		
		--select count (*)from bronze.crm_cust_info
	set @end_time = GETDATE();
	print'>> load duration'+ cast (datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
	print'-----------';
	 
		set @start_time = GETDATE();
		print'>> truncating table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;

		bulk insert bronze.crm_prd_info
		from 'C:\docx\data warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
	print'>> load duration'+ cast (datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
	print'-----------';

	set @start_time = getdate();
		print'>> truncating table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;

		bulk insert bronze.crm_sales_details 
		from 'C:\docx\data warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		--select count(*) from bronze.crm_sales_details
		set @end_time = GETDATE();
	print'>> load duration'+ cast (datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
	print'-----------';


	print'============================';
	print'loading erp tables';
	print'============================';

	set @start_time = GETDATE();
		print'>>>> truncating table: bronze.erp_cust_az12';

		truncate table bronze.erp_cust_az12;

		bulk insert bronze.erp_cust_az12
		from 'C:\docx\data warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with(
			firstrow = 2,
			tablock,
			fieldterminator = ','
		);
	set @end_time = GETDATE();
	print'>> load duration'+ cast (datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
	print'-----------';
		--select count(*) from bronze.erp_cust_az12

		set @start_time = getdate();
		truncate table bronze.erp_loc_a101;

		bulk insert bronze.erp_loc_a101
		from 'C:\docx\data warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		--select * from bronze.erp_loc_a101
	set @end_time = GETDATE();
	print'>> load duration'+ cast (datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
	print'-----------';


	set @start_time = getdate();
		truncate table bronze.erp_px_cat_g1v2;

		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\docx\data warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		); 
	set @end_time = GETDATE();
	print'>> load duration'+ cast (datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
	print'-----------';

		set @batch_end_time = getdate();
		print'==========='
		print'loading bronze layer complete'
		print'	-total load duration'+ cast (datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
		print'========='
		end try 
		begin catch 
		 print '========================================='
		 print 'error  occured during loading  bronze layer'
		 print 'error msg ' + error_message();
		 print 'error msg' + cast (error_number() as nvarchar);
		 print 'error msg' + cast (error_state() as nvarchar);
		 print '=========================================='
		end catch 
end
