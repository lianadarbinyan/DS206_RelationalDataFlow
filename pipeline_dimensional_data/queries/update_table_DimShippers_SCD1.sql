MERGE {db_dim}.{schema_dim}.{table_dim} AS DST
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON (DST.ShipperID_NK = SRC.ShipperID) 

WHEN MATCHED AND (
    ISNULL(DST.CompanyName, '') <> ISNULL(SRC.CompanyName, '') OR
    ISNULL(DST.Phone, '') <> ISNULL(SRC.Phone, '') 
)
THEN UPDATE
SET
    DST.CompanyName = SRC.CompanyName,
    DST.Phone = SRC.Phone 

WHEN NOT MATCHED BY TARGET 
THEN INSERT (ShipperID_NK, CompanyName, Phone)
VALUES (
    SRC.ShipperID,
    SRC.CompanyName,
    SRC.Phone
)
OUTPUT $action, 
    DELETED.ShipperID_NK,
    INSERTED.ShipperID_NK,
    INSERTED.CompanyName,
    INSERTED.Phone;
select * from DimShippers_SCD1