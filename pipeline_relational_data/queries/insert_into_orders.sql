
-- pipeline_relational_data/queries/insert_into_orders.sql

-- Insert data into table: orders
INSERT INTO {db}.{schema}.Orders
   (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry, TerritoryID)
VALUES
    (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
