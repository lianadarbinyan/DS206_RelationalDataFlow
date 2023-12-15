USE ORDERS_DIMENSIONAL_DB;

DROP TABLE IF EXISTS dbo.DimProduct;

CREATE TABLE dbo.DimProduct (
    ProductID_PK_SK INT PRIMARY KEY IDENTITY(1, 1),
    ProductID_NK INT,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(50),
    UnitPrice DECIMAL(8, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued VARCHAR(30),
    StartDate DATETIME NULL
);
ALTER TABLE DimProduct
ADD CONSTRAINT FK_Products_CategoryID
FOREIGN KEY (CategoryID) REFERENCES DimCategories_SCD1(CategoryID_PK_SK) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE DimProduct
ADD CONSTRAINT FK_Products_SupplierID
FOREIGN KEY (SupplierID) REFERENCES DimSuppliers(SupplierID_PK_SK) ON DELETE CASCADE ON UPDATE CASCADE;







-- Insert a new row for ProductID 1 in the source table
-- Update values in the source table for ProductID 1
'''
UPDATE ORDERS_RELATIONAL_DB.dbo.Products
SET
    ProductName = 'Updated Product',
    SupplierID = 2,
    CategoryID = 2,
    QuantityPerUnit = '20 units per box',
    UnitPrice = 29.99,
    UnitsInStock = 150,
    UnitsOnOrder = 30,
    ReorderLevel = 15,
    Discontinued = 'Yes'
WHERE ProductID = 3;
select * from DimProduct

-- Update values in the source table for EmployeeID 1
UPDATE ORDERS_RELATIONAL_DB.dbo.Employees
SET
    LastName = 'UpdatedLe',
    FirstName = 'UpdtName',
    Title = 'Updatle',
    TitleOfCourtesy = 'DS',
    BirthDate = '1990-01-01', -- Update with the desired date
    HireDate = '2023-01-01', -- Update with the desired date
    Address = '123 Updated Street',
    City = 'Updated City',
    Region = 'Updated Region',
    PostalCode = '54321',
    Country = 'Updated Country',
    HomePhone = '987-654-3210',
    Extension = 1234, -- Update with the desired extension
    Notes = 'Updated Notes',
    ReportsTo = 2, -- Update with the desired ReportsTo value
    PhotoPath = 'updated_photo.jpg'
WHERE EmployeeID = 1;

select * from DimEmployees_SCD4_History
'''







