USE ORDERS_DIMENSIONAL_DB;



DROP TABLE IF EXISTS dbo.DimSuppliers_SCD4_History;

-- Create the history table for tracking changes
CREATE TABLE dbo.DimSuppliers_SCD4_History (
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
    ValidFrom DATETIME NULL,
    ValidTo DATETIME NULL,
    
);
select * from DimSuppliers_SCD4_History