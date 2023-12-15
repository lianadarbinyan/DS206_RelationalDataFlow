DECLARE @Yesterday VARCHAR(8) = 
    CAST(YEAR(DATEADD(dd, -1, GETDATE())) AS CHAR(4)) + 
    RIGHT('0' + CAST(MONTH(DATEADD(dd, -1, GETDATE())) AS VARCHAR(2)), 2) + 
    RIGHT('0' + CAST(DAY(DATEADD(dd, -1, GETDATE())) AS VARCHAR(2)), 2);

-- SCD3 for Territories
MERGE {db_dim}.{schema_dim}.{table_dim} AS DST 
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON (SRC.TerritoryID = DST.TerritoryID_NK)
WHEN NOT MATCHED THEN
    INSERT (TerritoryID_NK, CurrentTerritoryDescription, RegionID) 
    VALUES (SRC.TerritoryID, SRC.TerritoryDescription, SRC.RegionID)
WHEN MATCHED
AND 
    (
        ISNULL(DST.CurrentTerritoryDescription, '') <> ISNULL(SRC.TerritoryDescription, '')
    )
THEN 
    UPDATE 
    SET  
        DST.CurrentTerritoryDescription = SRC.TerritoryDescription, -- simple overwrite
        DST.PreviousTerritoryDescription = DST.CurrentTerritoryDescription,
        DST.PrevTerritoryDescriptionValidTo = @Yesterday
OUTPUT
    $action,
    DELETED.TerritoryID_NK AS DSTTerritoryID,
    DELETED.CurrentTerritoryDescription AS DSTCurrentTerritoryDescription,
    DELETED.PreviousTerritoryDescription AS DSTPreviousTerritoryDescription,
    DELETED.RegionID AS DSTRegionID,
    DELETED.PrevTerritoryDescriptionValidTo AS DSTPrevTerritoryDescriptionValidTo,
    INSERTED.TerritoryID_NK AS SRCTerritoryID,
    INSERTED.CurrentTerritoryDescription AS SRCCurrentTerritoryDescription,
    INSERTED.PreviousTerritoryDescription AS SRCPreviousTerritoryDescription,
    INSERTED.RegionID AS SRCRegionID,
    NULL AS SRCPrevTerritoryID, -- Set to NULL if not available
    INSERTED.PrevTerritoryDescriptionValidTo AS SRCPrevTerritoryDescriptionValidTo;
