USE ORDERS_DIMENSIONAL_DB;

-- Drop table if it exists
DROP TABLE IF EXISTS DimRegion_SCD3;

-- Create the SCD3 dimension table
CREATE TABLE dbo.DimRegion_SCD3 (
    RegionID_PK_SK INT PRIMARY KEY IDENTITY(1, 1),
    RegionID_NK INT,
    CurrentRegionDescription VARCHAR(255) NOT NULL,
    Previous1RegionDescription VARCHAR(255) NULL,
    Previous2RegionDescription VARCHAR(255) NULL,
    Prevregion1_valid_to DATETIME NULL,
    Prevregion2_valid_to DATETIME NULL,
);


--SElect * from DimRegion_SCD3

