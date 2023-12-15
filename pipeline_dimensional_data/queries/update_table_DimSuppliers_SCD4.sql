DECLARE @Suppliers_SCD4 TABLE
(
    SupplierID_NK INT,
    CompanyName VARCHAR(100) ,
    ContactName VARCHAR(40) NULL,
    ContactTitle VARCHAR(30) NULL,
    Address VARCHAR(60) NULL,
    City VARCHAR(20) NULL,
    Region VARCHAR(15) NULL,
    PostalCode VARCHAR(10) NULL,
    Country VARCHAR(15) NULL,
    Phone VARCHAR(24) NULL,
    Fax VARCHAR(24) NULL,
    HomePage VARCHAR(500) NULL,
    StartDate DATETIME NULL,
    MergeAction VARCHAR(10) NULL
);

MERGE INTO {db_dim}.{schema_dim}.DimSuppliers AS DST
USING {db_rel}.{schema_rel}.Suppliers AS SRC
ON (SRC.SupplierID = DST.SupplierID_NK)

WHEN NOT MATCHED THEN
    INSERT (SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom)
    VALUES (SRC.SupplierID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, SRC.Fax, SRC.HomePage, GETDATE())

WHEN MATCHED
AND (
    ISNULL(DST.CompanyName, '') <> ISNULL(SRC.CompanyName, '') OR
    ISNULL(DST.ContactName, '') <> ISNULL(SRC.ContactName, '') OR
    ISNULL(DST.ContactTitle, '') <> ISNULL(SRC.ContactTitle, '') OR
    ISNULL(DST.Address, '') <> ISNULL(SRC.Address, '') OR
    ISNULL(DST.City, '') <> ISNULL(SRC.City, '') OR
    ISNULL(DST.Region, '') <> ISNULL(SRC.Region, '') OR
    ISNULL(DST.PostalCode, '') <> ISNULL(SRC.PostalCode, '') OR
    ISNULL(DST.Country, '') <> ISNULL(SRC.Country, '') OR
    ISNULL(DST.Phone, '') <> ISNULL(SRC.Phone, '') OR
    ISNULL(DST.Fax, '') <> ISNULL(SRC.Fax, '') OR
    ISNULL(DST.HomePage, '') <> ISNULL(SRC.HomePage, '')
)
THEN
    UPDATE
    SET
        DST.CompanyName = SRC.CompanyName,
        DST.ContactName = SRC.ContactName,
        DST.ContactTitle = SRC.ContactTitle,
        DST.Address = SRC.Address,
        DST.City = SRC.City,
        DST.Region = SRC.Region,
        DST.PostalCode = SRC.PostalCode,
        DST.Country = SRC.Country,
        DST.Phone = SRC.Phone,
        DST.Fax = SRC.Fax,
        DST.HomePage = SRC.HomePage,
        DST.ValidFrom = GETDATE()

OUTPUT
    DELETED.SupplierID_NK,
    DELETED.CompanyName,
    DELETED.ContactName,
    DELETED.ContactTitle,
    DELETED.Address,
    DELETED.City,
    DELETED.Region,
    DELETED.PostalCode,
    DELETED.Country,
    DELETED.Phone,
    DELETED.Fax,
    DELETED.HomePage,
    DELETED.ValidFrom,
    $Action AS MergeAction
INTO @Suppliers_SCD4;

UPDATE DimSuppliers_SCD4_History
SET ValidTo = DATEADD(day, -1, GETDATE())
FROM {db_dim}.{schema_dim}.DimSuppliers_SCD4_History
INNER JOIN @Suppliers_SCD4 suppliers_temp
ON DimSuppliers_SCD4_History.SupplierID_NK = suppliers_temp.SupplierID_NK
WHERE DimSuppliers_SCD4_History.ValidTo IS NULL;

INSERT INTO {db_dim}.{schema_dim}.DimSuppliers_SCD4_History (SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom)
SELECT SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, GETDATE()
FROM @Suppliers_SCD4
WHERE SupplierID_NK IS NOT NULL;

Select * from DimSuppliers