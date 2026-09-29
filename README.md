# Project Overview

**Building SQL Data ware house**
This repository implements a multi‑layer data warehouse on SQL Server following the Bronze → Silver → Gold (medallion) architecture. Raw data from ERP and CRM systems is ingested, cleansed, transformed, and finally exposed through analytical Gold layer views for reporting.
The warehouse consists of three layers:
<img width="856" height="428" alt="data_architecture" src="https://github.com/user-attachments/assets/7f0edd60-b520-42fe-b3b8-940b6acc7da8" />


Bronze – raw ingestion tables that mirror source file schemas.
Silver – cleaned, deduplicated, and standardized tables.
Gold – star‑schema model with dimension and fact views for analytics.

DATA FLOW INTEGRATION

<img width="741" height="482" alt="data_flow" src="https://github.com/user-attachments/assets/2496f4f9-5b52-434e-8bc1-c832e6bd94e7" />

DATA INTEGRATION:

<img width="761" height="592" alt="data_integration (1)" src="https://github.com/user-attachments/assets/a61388dd-28da-4462-8338-b9c3b34ac0a2" />

1) Extraction – CSV files are exported from ERP (e.g., SAP, Oracle) and CRM (e.g., Salesforce) and placed in a landing zone.
2) Bronze Load – BULK INSERT/OPENROWSET loads the files into bronze_ tables, preserving the original structure.
3) Silver Transformation – Stored procedures in scripts/silver/procedure_load_silver.sql clean the data:
4) Trim strings and remove unwanted spaces.
5) Convert date strings to proper DATE types.
6) Resolve nulls and apply business rules (gender, country mapping, etc.).
7) Deduplicate rows using ROW_NUMBER().
8) Populate clean tables (silver.crm_cust_info, silver.crm_prd_info, etc.).
9) Data‑Quality Verification – pre_data_quality_verification.sql and post_quality_check.sql run sanity checks before and after loading, detecting duplicates, invalid dates, and consistency issues.
10) Gold Layer Creation – scripts/gold/ddl_gold.sql creates views that model a star schema:
   a) gold.dim_customers – customer dimension.
   b) gold.dim_products – product dimension.
   c) gold.fact_sales – sales fact view joining silver tables.
Orchestration – SQL Server Agent jobs (or Azure Data Factory pipelines) execute the steps in order, with retry logic and email alerts.
Data Model (Star Schema)
Star Schema

<img width="1171" height="470" alt="data_model" src="https://github.com/user-attachments/assets/c5996be2-22aa-4f95-9de9-57fa85f5d4ef" />

Dimension tables (dim_customers, dim_products) provide descriptive attributes.
1) Fact table (fact_sales) stores transactional sales data linked via surrogate keys.
2) This star schema enables typical analytical queries such as sales by country, product line, or time.

Data Treatment Highlights
1) String Normalization – TRIM, UPPER, and custom CASE statements standardize values.
2) Date Normalization – Invalid dates (0 or malformed strings) are converted to NULL.
3) Gender & Country Mapping – Human‑readable values ('Female', 'United States', etc.) are derived from raw codes.
4) Deduplication – Latest record per primary key retained using ROW_NUMBER().
5) Integrity Checks – Foreign‑key‑style validations ensure sales details reference existing products and customers.

6) This project was developed as a learning project based on the SQL Data Warehouse tutorial by Data With Baraa.

Some diagrams and images in this repository are from the original tutorial/project and are included for educational reference. The original work and images belong to Data With Baraa.

Original project/tutorial: Data With Baraa – SQL Data Warehouse Project

I have made my own modifications and additions while using the project to learn SQL, data warehousing, ETL/ELT, dimensional modeling, and data analysis.
