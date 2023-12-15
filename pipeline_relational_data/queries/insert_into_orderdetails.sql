
-- pipeline_relational_data/queries/insert_into_orderdetails.sql

-- Insert data into table: orderdetails
INSERT INTO {db}.{schema}.OrderDetails
   (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
    (?, ?, ?, ?, ?);
