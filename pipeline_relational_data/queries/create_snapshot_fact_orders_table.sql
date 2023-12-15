
-- pipeline_relational_data/queries/create_snapshot_fact_orders_table.sql

-- Table creation query for snapshot fact table for Orders
CREATE TABLE SnapshotFactOrders (
    TimeKey DATE,
    CustomerID INT,
    EmployeeID INT,
    ShipperID INT,
    OrderCount INT,
    TotalFreight DECIMAL(10, 2),
    PRIMARY KEY (TimeKey, CustomerID, EmployeeID, ShipperID),
    FOREIGN KEY (TimeKey) REFERENCES TimeDimension(DateKey),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID)
);
