USE Orders_RELATIONAL_DB;

DROP TABLE IF EXISTS Orders;

-- Table creation query for sheet Orders
CREATE TABLE Orders (
 OrderID VARCHAR(10) PRIMARY KEY NOT NULL,
 CustomerID VARCHAR (10) REFERENCES Customers (CustomerID),
 EmployeeID INT REFERENCES Employees (EmployeeID),
 OrderDate DATE,
 RequiredDate DATE,
 ShippedDate DATE,
 ShipVia INT  REFERENCES Shippers (ShipperID),
 Freight DECIMAL (8, 2),
 ShipName VARCHAR (100),
 ShipAddress VARCHAR (100),
 ShipCity VARCHAR (20),
 ShipRegion VARCHAR (30),
 ShipPostalCode VARCHAR (10),
 ShipCountry VARCHAR (30),
 TerritoryID INT  REFERENCES Territories (TerritoryID)
);


