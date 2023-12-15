
-- pipeline_relational_data/queries/insert_into_categories.sql

-- Insert data into table: categories
INSERT INTO {db}.{schema}.Categories
   (CategoryID, CategoryName, Description)
VALUES
    (?, ?, ?);
