-- pipeline_dimensional_data/queries/create_table_DimEmployees_SCD4.sql
USE ORDERS_DIMENSIONAL_DB;

DROP TABLE IF EXISTS dbo.DimEmployees;

CREATE TABLE dbo.DimEmployees (
    EmployeeID_PK_SK INT PRIMARY KEY IDENTITY(1, 1),
    EmployeeID_NK INT,
    LastName VARCHAR(20) NOT NULL,
    FirstName VARCHAR(10) NOT NULL,
    Title VARCHAR(30) NULL,
    TitleOfCourtesy VARCHAR(25) NULL,
    BirthDate DATETIME NULL,
    HireDate DATETIME NULL,
    Address VARCHAR(60) NULL,
    City VARCHAR(15) NULL,
    Region VARCHAR(15) NULL,
    PostalCode VARCHAR(10) NULL,
    Country VARCHAR(15) NULL,
    HomePhone VARCHAR(24) NULL,
    Extension VARCHAR(4) NULL,
    Notes VARCHAR(500) NULL,
    ReportsTo INT NULL,
    PhotoPath VARCHAR(255) NULL,
    StartDate DATETIME NULL,
    FOREIGN KEY (ReportsTo) REFERENCES dbo.DimEmployees(EmployeeID_PK_SK)
);
SELECT * FROM DimEmployees