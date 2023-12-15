USE Orders_RELATIONAL_DB;

DROP TABLE IF EXISTS Suppliers;
-- Table creation query for sheet Suppliers
CREATE TABLE Suppliers (
 SupplierID INT NOT NULL,
 CompanyName VARCHAR (200),
 ContactName VARCHAR (100),
 ContactTitle VARCHAR (100),
 Address VARCHAR (200),
 City VARCHAR (20),
 Region VARCHAR (20),
 PostalCode VARCHAR (20),
 Country VARCHAR (20),
 Phone VARCHAR (70),
 Fax VARCHAR (30),
 HomePage VARCHAR (300)
);

ALTER TABLE Suppliers
ADD CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID);