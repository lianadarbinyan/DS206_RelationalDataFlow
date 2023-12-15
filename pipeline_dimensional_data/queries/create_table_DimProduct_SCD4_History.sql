USE ORDERS_DIMENSIONAL_DB;

DROP TABLE IF EXISTS DimProduct_SCD4_History;

CREATE TABLE dbo.DimProduct_SCD4_History (
    ProductID_NK INT,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(50),
    UnitPrice DECIMAL(8, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued VARCHAR(30) ,
    StartDate DATETIME NULL,
    EndDate DATETIME NULL,
    FOREIGN KEY (CategoryID) REFERENCES dbo.DimCategories_SCD1(CategoryID_PK_SK),
    FOREIGN KEY (SupplierID) REFERENCES dbo.DimSuppliers(SupplierID_PK_SK)
);
select * from FactOrders