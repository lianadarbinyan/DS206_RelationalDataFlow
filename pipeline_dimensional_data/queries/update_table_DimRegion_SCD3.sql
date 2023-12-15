DECLARE @Yesterday VARCHAR(8) = CAST(YEAR(DATEADD(dd, -1, GETDATE())) AS CHAR(4)) + RIGHT('0' + CAST(MONTH(DATEADD(dd, -1, GETDATE())) AS VARCHAR(2)), 2) + RIGHT('0' + CAST(DAY(DATEADD(dd, -1, GETDATE())) AS VARCHAR(2)), 2)

MERGE {db_dim}.{schema_dim}.{table_dim} AS DST 
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON (SRC.RegionID = DST.RegionID_NK)
WHEN NOT MATCHED THEN
    INSERT (RegionID_NK, CurrentRegionDescription) 
    VALUES (SRC.RegionID, SRC.RegionDescription)
WHEN MATCHED
AND 
    (
        ISNULL(DST.CurrentRegionDescription, '') <> ISNULL(SRC.RegionDescription, '')
    )
THEN 
    UPDATE 
    SET  
       DST.Previous1RegionDescription = DST.CurrentRegionDescription,
	   DST.CurrentRegionDescription = SRC.RegionDescription, -- simple overwrite
        
        DST.Prevregion1_valid_to = @Yesterday,
        DST.Previous2RegionDescription = DST.Previous1RegionDescription,
        DST.Prevregion2_valid_to = DST.Prevregion1_valid_to

OUTPUT
    $action,
    DELETED.RegionID_NK AS DSTRegionID,
    DELETED.CurrentRegionDescription AS DSTCurrentRegionDescription,
    DELETED.Previous1RegionDescription AS DSTPrevious1RegionDescription,
    DELETED.Prevregion1_valid_to AS DSTPrevregion1_valid_to,
    DELETED.Previous2RegionDescription AS DSTPrevious2RegionDescription,
    DELETED.Prevregion2_valid_to AS DSTPrevregion2_valid_to,
    INSERTED.RegionID_NK AS SRCRegionID,
    INSERTED.CurrentRegionDescription AS SRCCurrentRegionDescription,
    INSERTED.Previous1RegionDescription AS SRCPrevious1RegionDescription,
    INSERTED.Prevregion1_valid_to AS SRCPrevregion1_valid_to,
    INSERTED.Previous2RegionDescription AS SRCPrevious2RegionDescription,
    INSERTED.Prevregion2_valid_to AS SRCPrevregion2_valid_to;

