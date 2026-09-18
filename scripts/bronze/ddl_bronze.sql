/* Create Bronze Table

This script creates table in bronze schema and dropping existing table if already exits.
Running this script we are redefing the sturcutre of bronze layer.
*/
IF OBJECT_ID ('bronze.crm_sales_details' ,'U') IS NOT NULL
     DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50) ,
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);

ALTER TABLE bronze.crm_sales_details
ALTER column sls_order_dt VARCHAR(50);


ALTER TABLE bronze.crm_sales_details
ALTER column sls_due_dt VARCHAR(50);

IF OBJECT_ID ('bronze.erp_cust_az12' ,'U') IS NOT NULL
     DROP TABLE bronze.erp_cust_az12;
CREATE TABLE  bronze.erp_cust_az12(
	 cid NVARCHAR(50),
	 BDATE DATE,
	 GEN NVARCHAR(50)
);


IF OBJECT_ID ('bronze.erp_loc_a101' ,'U') IS NOT NULL
     DROP TABLE  bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
cid NVARCHAR(50),
cntry NVARCHAR(50)
);



IF OBJECT_ID ('bronze.erp_px_cat_g1v2' ,'U') IS NOT NULL
     DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);
