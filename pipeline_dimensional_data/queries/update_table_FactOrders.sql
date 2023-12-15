-- MERGE statement to update and insert data for FactOrders table
MERGE ORDERS_DIMENSIONAL_DB.dbo.FactOrders AS DST
USING (
    -- Your basic insertion query with SCD1 joins
    SELECT
        o.OrderID AS OrderID_NK,
        od.ProductID AS ProductID_NK,
        p.ProductID_PK_SK AS ProductID_SK,
        od.UnitPrice,
        od.Quantity,
        od.Discount,
        o.CustomerID,
        c.CustomerID_PK_SK AS CustomerID_SK,
        o.EmployeeID,
        e.EmployeeID_PK_SK AS EmployeeID_SK,
        o.OrderDate,
        o.RequiredDate,
        o.ShippedDate,
        o.ShipVia,
        s.ShipperID_PK_SK AS ShipVia_SK,
        o.Freight,
        o.ShipName,
        o.ShipAddress,
        o.ShipCity,
        o.ShipRegion,
        o.ShipPostalCode,
        o.ShipCountry,
        o.TerritoryID,
        t.TerritoryID_PK_SK AS TerritoryID_SK
    FROM
        ORDERS_RELATIONAL_DB.dbo.Orders o
    JOIN
        ORDERS_RELATIONAL_DB.dbo.OrderDetails od ON o.OrderID = od.OrderID
    LEFT JOIN ORDERS_DIMENSIONAL_DB.dbo.DimProduct p ON od.ProductID = p.ProductID_NK
    LEFT JOIN ORDERS_DIMENSIONAL_DB.dbo.DimCustomers_SCD2 c ON o.CustomerID = c.CustomerID_NK
    LEFT JOIN ORDERS_DIMENSIONAL_DB.dbo.DimEmployees e ON o.EmployeeID = e.EmployeeID_NK
    LEFT JOIN ORDERS_DIMENSIONAL_DB.dbo.DimShippers_SCD1 s ON o.ShipVia = s.ShipperID_NK
    LEFT JOIN ORDERS_DIMENSIONAL_DB.dbo.DimTerritories_SCD3 t ON o.TerritoryID = t.TerritoryID_NK
    WHERE c.IsCurrent = 1
) AS SRC
ON DST.OrderID_NK = SRC.OrderID_NK AND DST.ProductID_NK = SRC.ProductID_NK

-- When matched and data has changed, update
-- When matched and data has changed, update
WHEN MATCHED AND (
    ISNULL(DST.UnitPrice, '') <> ISNULL(SRC.UnitPrice, '') OR
    ISNULL(DST.Quantity, '') <> ISNULL(SRC.Quantity, '') OR
    ISNULL(DST.Discount, '') <> ISNULL(SRC.Discount, '') OR
    ISNULL(DST.CustomerID, '') <> ISNULL(SRC.CustomerID, '') OR
    ISNULL(DST.CustomerID_SK, '') <> ISNULL(SRC.CustomerID_SK, '') OR
    ISNULL(DST.EmployeeID, '') <> ISNULL(SRC.EmployeeID, '') OR
    ISNULL(DST.EmployeeID_SK, '') <> ISNULL(SRC.EmployeeID_SK, '') OR
    ISNULL(DST.OrderDate, '') <> ISNULL(SRC.OrderDate, '') OR
    ISNULL(DST.RequiredDate, '') <> ISNULL(SRC.RequiredDate, '') OR
    ISNULL(DST.ShippedDate, '') <> ISNULL(SRC.ShippedDate, '') OR
    ISNULL(DST.ShipVia, '') <> ISNULL(SRC.ShipVia, '') OR
    ISNULL(DST.ShipVia_SK, '') <> ISNULL(SRC.ShipVia_SK, '') OR
    ISNULL(DST.Freight, '') <> ISNULL(SRC.Freight, '') OR
    ISNULL(DST.ShipName, '') <> ISNULL(SRC.ShipName, '') OR
    ISNULL(DST.ShipAddress, '') <> ISNULL(SRC.ShipAddress, '') OR
    ISNULL(DST.ShipCity, '') <> ISNULL(SRC.ShipCity, '') OR
    ISNULL(DST.ShipRegion, '') <> ISNULL(SRC.ShipRegion, '') OR
    ISNULL(DST.ShipPostalCode, '') <> ISNULL(SRC.ShipPostalCode, '') OR
    ISNULL(DST.ShipCountry, '') <> ISNULL(SRC.ShipCountry, '') OR
    ISNULL(DST.TerritoryID, '') <> ISNULL(SRC.TerritoryID, '') OR
    ISNULL(DST.TerritoryID_SK, '') <> ISNULL(SRC.TerritoryID_SK, '')
)
THEN UPDATE SET
    DST.UnitPrice = SRC.UnitPrice,
    DST.Quantity = SRC.Quantity,
    DST.Discount = SRC.Discount,
    DST.CustomerID = SRC.CustomerID,
    DST.CustomerID_SK = SRC.CustomerID_SK,
    DST.EmployeeID = SRC.EmployeeID,
    DST.EmployeeID_SK = SRC.EmployeeID_SK,
    DST.OrderDate = SRC.OrderDate,
    DST.RequiredDate = SRC.RequiredDate,
    DST.ShippedDate = SRC.ShippedDate,
    DST.ShipVia = SRC.ShipVia,
    DST.ShipVia_SK = SRC.ShipVia_SK,
    DST.Freight = SRC.Freight,
    DST.ShipName = SRC.ShipName,
    DST.ShipAddress = SRC.ShipAddress,
    DST.ShipCity = SRC.ShipCity,
    DST.ShipRegion = SRC.ShipRegion,
    DST.ShipPostalCode = SRC.ShipPostalCode,
    DST.ShipCountry = SRC.ShipCountry,
    DST.TerritoryID = SRC.TerritoryID,
    DST.TerritoryID_SK = SRC.TerritoryID_SK



-- When not matched by target, insert new record
WHEN NOT MATCHED BY TARGET
THEN INSERT (OrderID_NK, ProductID_NK, ProductID_SK, UnitPrice, Quantity, Discount, CustomerID, CustomerID_SK, EmployeeID, EmployeeID_SK, OrderDate, RequiredDate, ShippedDate, ShipVia, ShipVia_SK, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry, TerritoryID, TerritoryID_SK)
VALUES (
    SRC.OrderID_NK, SRC.ProductID_NK, SRC.ProductID_SK, SRC.UnitPrice, SRC.Quantity, SRC.Discount, SRC.CustomerID, SRC.CustomerID_SK, SRC.EmployeeID, SRC.EmployeeID_SK, SRC.OrderDate, SRC.RequiredDate, SRC.ShippedDate, SRC.ShipVia, SRC.ShipVia_SK, SRC.Freight, SRC.ShipName, SRC.ShipAddress, SRC.ShipCity, SRC.ShipRegion, SRC.ShipPostalCode, SRC.ShipCountry, SRC.TerritoryID, SRC.TerritoryID_SK
)

-- When not matched by source, delete from target
WHEN NOT MATCHED BY SOURCE
THEN DELETE
OUTPUT 
    $action, 
    DELETED.OrderID_NK,
    DELETED.ProductID_NK,
    DELETED.ProductID_SK,
    DELETED.UnitPrice,
    DELETED.Quantity,
    DELETED.Discount,
    DELETED.CustomerID,
    DELETED.CustomerID_SK,
    DELETED.EmployeeID,
    DELETED.EmployeeID_SK,
    DELETED.OrderDate,
    DELETED.RequiredDate,
    DELETED.ShippedDate,
    DELETED.ShipVia,
    DELETED.ShipVia_SK,
    DELETED.Freight,
    DELETED.ShipName,
    DELETED.ShipAddress,
    DELETED.ShipCity,
    DELETED.ShipRegion,
    DELETED.ShipPostalCode,
    DELETED.ShipCountry,
    DELETED.TerritoryID,
    DELETED.TerritoryID_SK,
    INSERTED.OrderID_NK,
    INSERTED.ProductID_NK,
    INSERTED.ProductID_SK,
    INSERTED.UnitPrice,
    INSERTED.Quantity,
    INSERTED.Discount,
    INSERTED.CustomerID,
    INSERTED.CustomerID_SK,
    INSERTED.EmployeeID,
    INSERTED.EmployeeID_SK,
    INSERTED.OrderDate,
    INSERTED.RequiredDate,
    INSERTED.ShippedDate,
    INSERTED.ShipVia,
    INSERTED.ShipVia_SK,
    INSERTED.Freight,
    INSERTED.ShipName,
    INSERTED.ShipAddress,
    INSERTED.ShipCity,
    INSERTED.ShipRegion,
    INSERTED.ShipPostalCode,
    INSERTED.ShipCountry,
    INSERTED.TerritoryID,
    INSERTED.TerritoryID_SK;

