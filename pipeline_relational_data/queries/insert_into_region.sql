
-- pipeline_relational_data/queries/insert_into_region.sql

-- Insert data into table: region
INSERT INTO {db}.{schema}.Region
   (RegionID, RegionDescription)
VALUES
    (?, ?);
