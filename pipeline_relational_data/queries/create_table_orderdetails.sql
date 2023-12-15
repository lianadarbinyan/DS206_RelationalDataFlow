USE ORDERS_RELATIONAL_DB;

DROP TABLE IF EXISTS OrderDetails;

-- Table creation query for sheet OrderDetails
CREATE TABLE OrderDetails (

 OrderID VARCHAR (10)  NOT NULL, 
 ProductID INT  NOT NULL, 
 UnitPrice INT, 
 Quantity INT, 
 Discount DECIMAL(10, 10)
 
 PRIMARY KEY(OrderID, ProductID),

);

--DELETE FROM dbo.OrderDetails
select * from dbo.OrderDetails
ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_OrderID
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_ProductID
FOREIGN KEY (ProductID) REFERENCES dbo.Products(ProductID);


