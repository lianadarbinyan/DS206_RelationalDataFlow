
-- pipeline_relational_data/queries/insert_into_territories.sql

-- Insert data into table: territories
INSERT INTO {db}.{schema}.Territories
   (TerritoryID, TerritoryDescription, RegionID)
VALUES
    (?, ?, ?);
