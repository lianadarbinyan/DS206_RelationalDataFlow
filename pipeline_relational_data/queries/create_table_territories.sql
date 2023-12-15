USE ORDERS_RELATIONAL_DB;

DROP TABLE IF EXISTS Territories;

-- Table creation query for sheet Territories
CREATE TABLE Territories (
 TerritoryID INT PRIMARY KEY NOT NULL,
 TerritoryDescription VARCHAR (40),
 RegionID INT REFERENCES dbo.Region(RegionID)
);

