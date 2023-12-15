
-- pipeline_relational_data/queries/insert_into_products.sql

-- Insert data into table: products
INSERT INTO {db}.{schema}.Products
   (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
VALUES
    (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
