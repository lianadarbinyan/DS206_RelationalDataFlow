USE ORDERS_DIMENSIONAL_DB;

-- Drop table if it exists
DROP TABLE IF EXISTS dbo.DimShippers_SCD1;

-- Create the SCD1 dimension table
CREATE TABLE dbo.DimShippers_SCD1 (
    ShipperID_PK_SK INT PRIMARY KEY IDENTITY(1, 1),
    ShipperID_NK INT,
    CompanyName VARCHAR(255) NOT NULL,
    Phone VARCHAR(24) NULL
);
