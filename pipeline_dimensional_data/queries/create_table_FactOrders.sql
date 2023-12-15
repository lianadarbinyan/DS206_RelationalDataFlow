-- Create Table: Orders
Drop table if exists FactOrders
CREATE TABLE FactOrders (
    Order_Product_SK_PK INT IDENTITY(1, 1) PRIMARY KEY,
    OrderID_NK VARCHAR(10),
    ProductID_NK INT,
    ProductID_SK INT,
    UnitPrice INT ,
    Quantity INT NOT NULL,
    Discount DECIMAL(10,10 ) DEFAULT 0.0,
    CustomerID VARCHAR(10),
    CustomerID_SK INT,
    EmployeeID INT,
    EmployeeID_SK INT,
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE,
    ShipVia INT,
    ShipVia_SK INT,
    Freight DECIMAL(8, 2),
    ShipName VARCHAR(100),
    ShipAddress VARCHAR(100),
    ShipCity VARCHAR(20),
    ShipRegion VARCHAR(30),
    ShipPostalCode VARCHAR(20),
    ShipCountry VARCHAR(30),
    TerritoryID INT, 
    TerritoryID_SK INT
);


ALTER TABLE FactOrders
ADD CONSTRAINT FK_OrderDetails_ProductID
FOREIGN KEY (ProductID_SK) REFERENCES DimProduct(ProductID_PK_SK) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FactOrders
ADD CONSTRAINT FK_Orders_CustomerID
FOREIGN KEY (CustomerID_SK) REFERENCES DimCustomers_SCD2(CustomerID_PK_SK) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FactOrders
ADD CONSTRAINT FK_Orders_EmployeeID
FOREIGN KEY (EmployeeID_SK) REFERENCES DimEmployees(EmployeeID_PK_SK) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FactOrders
ADD CONSTRAINT FK_Orders_ShipVia
FOREIGN KEY (ShipVia_SK) REFERENCES DimShippers_SCD1(ShipperID_PK_SK) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FactOrders
ADD CONSTRAINT FK_Orders_TerritoryID
FOREIGN KEY (TerritoryID_SK) REFERENCES DimTerritories_SCD3(TerritoryID_PK_SK) ON DELETE CASCADE ON UPDATE CASCADE;