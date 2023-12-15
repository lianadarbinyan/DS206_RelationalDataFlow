USE Orders_RELATIONAL_DB;

DROP TABLE IF EXISTS Products;


CREATE TABLE Products ( 

 ProductID INT PRIMARY KEY NOT NULL,
 ProductName VARCHAR(200), 
 SupplierID INT REFERENCES dbo.Suppliers (SupplierID) NOT NULL,
 CategoryID INT REFERENCES dbo.Categories (CategoryID) NOT NULL,
 QuantityPerUnit VARCHAR(250), 
 UnitPrice  DECIMAL(8, 2), 
 UnitsInStock INT, 
 UnitsOnOrder INT, 
 ReorderLevel INT, 
 Discontinued VARCHAR (30)

);

