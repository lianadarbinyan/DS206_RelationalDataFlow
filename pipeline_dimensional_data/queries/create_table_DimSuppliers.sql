-- pipeline_dimensional_data/queries/create_table_DimSuppliers_SCD4.sql
USE ORDERS_DIMENSIONAL_DB;

DROP TABLE IF EXISTS DimSuppliers;

-- Create the main (current) dimension table
CREATE TABLE dbo.DimSuppliers (
    SupplierID_PK_SK INT PRIMARY KEY IDENTITY(1, 1),
    SupplierID_NK INT,
    CompanyName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(40) NULL,
    ContactTitle VARCHAR(30) NULL,
    Address VARCHAR(60) NULL,
    City VARCHAR(20) NULL,
    Region VARCHAR(15) NULL,
    PostalCode VARCHAR(10) NULL,
    Country VARCHAR(15) NULL,
    Phone VARCHAR(24) NULL,
    Fax VARCHAR(24) NULL,
    HomePage VARCHAR(500) NULL,
    ValidFrom DATETIME NULL
);

select * from dbo.DimSuppliers

