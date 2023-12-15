
-- pipeline_relational_data/queries/insert_into_customers.sql

-- Insert data into table: customers
INSERT INTO {db}.{schema}.Customers
   (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
VALUES
    (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
