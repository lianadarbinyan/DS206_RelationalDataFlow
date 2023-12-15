DECLARE @Employees_SCD4 TABLE
(
    EmployeeID_NK INT,
    LastName VARCHAR(40) ,
    FirstName VARCHAR(40) ,
    Title VARCHAR(100),
    TitleOfCourtesy VARCHAR(10),
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR(100),
    City VARCHAR(50),
    Region VARCHAR(20),
    PostalCode VARCHAR(10),
    Country VARCHAR(30),
    HomePhone VARCHAR(20),
    Extension INT,
    Notes TEXT,
    ReportsTo INT,
    PhotoPath VARCHAR(200),
    StartDate DATETIME NULL,
    MergeAction VARCHAR(10) NULL
);

--MERGE INTO ORDERS_DIMENSIONAL_DB.dbo.DimEmployees AS DST
--USING ORDERS_RELATIONAL_DB.dbo.Employees AS SRC
MERGE INTO {db_dim}.{schema_dim}.{table_dim}  AS DST 
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON (SRC.EmployeeID = DST.EmployeeID_NK)

WHEN NOT MATCHED THEN
    INSERT (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, StartDate)
    VALUES (SRC.EmployeeID, SRC.LastName, SRC.FirstName, SRC.Title, SRC.TitleOfCourtesy, SRC.BirthDate, SRC.HireDate, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.HomePhone, SRC.Extension, SRC.Notes, SRC.ReportsTo, SRC.PhotoPath, GETDATE())

WHEN MATCHED
AND (
    ISNULL(DST.LastName, '') <> ISNULL(SRC.LastName, '') OR
    ISNULL(DST.FirstName, '') <> ISNULL(SRC.FirstName, '') OR
    ISNULL(DST.Title, '') <> ISNULL(SRC.Title, '') OR
    ISNULL(DST.TitleOfCourtesy, '') <> ISNULL(SRC.TitleOfCourtesy, '') OR
    ISNULL(DST.BirthDate, '1900-01-01') <> ISNULL(SRC.BirthDate, '1900-01-01') OR
    ISNULL(DST.HireDate, '1900-01-01') <> ISNULL(SRC.HireDate, '1900-01-01') OR
    ISNULL(DST.Address, '') <> ISNULL(SRC.Address, '') OR
    ISNULL(DST.City, '') <> ISNULL(SRC.City, '') OR
    ISNULL(DST.Region, '') <> ISNULL(SRC.Region, '') OR
    ISNULL(DST.PostalCode, '') <> ISNULL(SRC.PostalCode, '') OR
    ISNULL(DST.Country, '') <> ISNULL(SRC.Country, '') OR
    ISNULL(DST.HomePhone, '') <> ISNULL(SRC.HomePhone, '') OR
    ISNULL(DST.Extension, 0) <> ISNULL(SRC.Extension, 0) OR
    ISNULL(DST.Notes, '') <> ISNULL(SRC.Notes, '') OR
    ISNULL(DST.ReportsTo, 0) <> ISNULL(SRC.ReportsTo, 0) OR
    ISNULL(DST.PhotoPath, '') <> ISNULL(SRC.PhotoPath, '')
)
THEN
    UPDATE
    SET
        DST.LastName = SRC.LastName,
        DST.FirstName = SRC.FirstName,
        DST.Title = SRC.Title,
        DST.TitleOfCourtesy = SRC.TitleOfCourtesy,
        DST.BirthDate = SRC.BirthDate,
        DST.HireDate = SRC.HireDate,
        DST.Address = SRC.Address,
        DST.City = SRC.City,
        DST.Region = SRC.Region,
        DST.PostalCode = SRC.PostalCode,
        DST.Country = SRC.Country,
        DST.HomePhone = SRC.HomePhone,
        DST.Extension = SRC.Extension,
        DST.Notes = SRC.Notes,
        DST.ReportsTo = SRC.ReportsTo,
        DST.PhotoPath = SRC.PhotoPath,
        StartDate = GETDATE()

OUTPUT
    DELETED.EmployeeID_NK,
    DELETED.LastName,
    DELETED.FirstName,
    DELETED.Title,
    DELETED.TitleOfCourtesy,
    DELETED.BirthDate,
    DELETED.HireDate,
    DELETED.Address,
    DELETED.City,
    DELETED.Region,
    DELETED.PostalCode,
    DELETED.Country,
    DELETED.HomePhone,
    DELETED.Extension,
    DELETED.Notes,
    DELETED.ReportsTo,
    DELETED.PhotoPath,
    DELETED.StartDate,
    $Action AS MergeAction
INTO @Employees_SCD4;

UPDATE DimEmployees_SCD4_History
SET EndDate = DATEADD(day, -1, GETDATE())
FROM {db_dim}.{schema_dim}.DimEmployees_SCD4_History
INNER JOIN @Employees_SCD4 employees_temp
ON DimEmployees_SCD4_History.EmployeeID_NK = employees_temp.EmployeeID_NK
WHERE DimEmployees_SCD4_History.EndDate IS NULL;

INSERT INTO {db_dim}.{schema_dim}.DimEmployees_SCD4_History (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, StartDate)
SELECT EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, GETDATE()
FROM @Employees_SCD4
WHERE EmployeeID_NK IS NOT NULL;

