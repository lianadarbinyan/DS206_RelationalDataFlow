
-- pipeline_relational_data/queries/insert_into_shippers.sql

-- Insert data into table: shippers
INSERT INTO {db}.{schema}.Shippers
   (ShipperID, CompanyName, Phone)
VALUES
    (?, ?, ?);
