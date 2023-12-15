USE ORDERS_DIMENSIONAL_DB;

DROP TABLE IF EXISTS dbo.DimCustomers_SCD2;

CREATE TABLE dbo.DimCustomers_SCD2 (
    CustomerID_PK_SK INT PRIMARY KEY IDENTITY(1, 1),
    CustomerID_NK CHAR(5),
    CompanyName VARCHAR(40) NOT NULL,
    ContactName VARCHAR(30) NULL,
    ContactTitle VARCHAR(30) NULL,
    Address VARCHAR(60) NULL,
    City VARCHAR(15) NULL,
    Region VARCHAR(15) NULL,
    PostalCode VARCHAR(10) NULL,
    Country VARCHAR(15) NULL,
    Phone VARCHAR(24) NULL,
    Fax VARCHAR(24) NULL,
    ValidFrom INT NULL,
    ValidTo INT NULL,
    IsCurrent BIT NULL
);
