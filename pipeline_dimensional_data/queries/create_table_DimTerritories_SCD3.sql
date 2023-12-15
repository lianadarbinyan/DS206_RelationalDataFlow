USE ORDERS_DIMENSIONAL_DB;
Select * from DimTerritories_SCD3;
DROP TABLE IF EXISTS dbo.DimTerritories_SCD3;

-- Create the SCD3 dimension table
CREATE TABLE dbo.DimTerritories_SCD3 (
    TerritoryID_PK_SK INT PRIMARY KEY IDENTITY(1, 1),
    TerritoryID_NK VARCHAR(20),
    CurrentTerritoryDescription VARCHAR(255) NULL,
    PreviousTerritoryDescription VARCHAR(255) NULL,
    RegionID INT,
    PrevTerritoryDescriptionValidTo DATETIME NULL,
    FOREIGN KEY (RegionID) REFERENCES dbo.DimRegion_SCD3(RegionID_PK_SK)
);