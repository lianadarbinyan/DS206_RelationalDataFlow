-- MERGE statement to update and insert data for Categories table
MERGE {db_dim}.{schema_dim}.{table_dim} AS DST
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON (DST.CategoryID_NK = SRC.CategoryID) -- Add your join conditions

WHEN MATCHED AND (
  ISNULL(DST.CategoryName, '') <> ISNULL(SRC.CategoryName, '') OR
  ISNULL(DST.Description, '') <> ISNULL(SRC.Description, '') -- Add conditions for other columns as needed
)
THEN UPDATE
SET
    DST.CategoryName = SRC.CategoryName,
    DST.Description = SRC.Description -- Update other columns as needed

WHEN NOT MATCHED BY TARGET
THEN INSERT (CategoryID_NK, CategoryName, Description)
VALUES (
    SRC.CategoryID,
    SRC.CategoryName,
    SRC.Description
)

WHEN NOT MATCHED BY SOURCE
THEN DELETE
OUTPUT $action, 
    DELETED.CategoryID_PK_SK,
    DELETED.CategoryID_NK,
    DELETED.CategoryName,
    DELETED.Description,
    INSERTED.CategoryID_PK_SK,
    INSERTED.CategoryID_NK,
    INSERTED.CategoryName,
    INSERTED.Description;


