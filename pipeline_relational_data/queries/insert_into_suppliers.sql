
-- pipeline_relational_data/queries/insert_into_suppliers.sql

-- Insert data into table: suppliers
INSERT INTO {db}.{schema}.Suppliers
   (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage)
VALUES
    (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

select * from dbo.Suppliers
