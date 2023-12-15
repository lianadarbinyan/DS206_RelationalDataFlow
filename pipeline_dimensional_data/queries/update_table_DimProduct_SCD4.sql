-- Temporary table to store changes
DECLARE @DimProduct_History TABLE (
    ProductID_NK INT,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(50),
    UnitPrice DECIMAL(8, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued VARCHAR(30),
    StartDate DATETIME,
    EndDate DATETIME,
    MergeAction VARCHAR(10)
);

-- Merge into SCD4 table
MERGE dbo.DimProduct AS DST
USING ORDERS_RELATIONAL_DB.dbo.Products AS SRC
ON (SRC.ProductID = DST.ProductID_NK)

WHEN NOT MATCHED THEN
INSERT (ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, StartDate)
VALUES (SRC.ProductID, SRC.ProductName, SRC.SupplierID, SRC.CategoryID, SRC.QuantityPerUnit, SRC.UnitPrice, SRC.UnitsInStock, SRC.UnitsOnOrder, SRC.ReorderLevel, SRC.Discontinued, GETDATE())

WHEN MATCHED AND (
    ISNULL(DST.ProductName, '') <> ISNULL(SRC.ProductName, '') OR
    DST.SupplierID <> SRC.SupplierID OR
    DST.CategoryID <> SRC.CategoryID OR
    ISNULL(DST.QuantityPerUnit, '') <> ISNULL(SRC.QuantityPerUnit, '') OR
    DST.UnitPrice <> SRC.UnitPrice OR
    DST.UnitsInStock <> SRC.UnitsInStock OR
    DST.UnitsOnOrder <> SRC.UnitsOnOrder OR
    DST.ReorderLevel <> SRC.ReorderLevel OR
    DST.Discontinued <> SRC.Discontinued
)
THEN UPDATE SET
    DST.ProductName = SRC.ProductName,
    DST.SupplierID = SRC.SupplierID,
    DST.CategoryID = SRC.CategoryID,
    DST.QuantityPerUnit = SRC.QuantityPerUnit,
    DST.UnitPrice = SRC.UnitPrice,
    DST.UnitsInStock = SRC.UnitsInStock,
    DST.UnitsOnOrder = SRC.UnitsOnOrder,
    DST.ReorderLevel = SRC.ReorderLevel,
    DST.Discontinued = SRC.Discontinued

OUTPUT DELETED.ProductID_NK, DELETED.ProductName, DELETED.SupplierID, DELETED.CategoryID, DELETED.QuantityPerUnit, DELETED.UnitPrice, DELETED.UnitsInStock, DELETED.UnitsOnOrder, DELETED.ReorderLevel, DELETED.Discontinued, DELETED.StartDate, GETDATE(), $Action AS MergeAction
INTO @DimProduct_History (ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, StartDate, EndDate, MergeAction);

-- Update history table to set final date
UPDATE TP4
SET TP4.EndDate = GETDATE()
FROM dbo.DimProduct_SCD4_History TP4
    INNER JOIN @DimProduct_History TMP
    ON TP4.ProductID_NK = TMP.ProductID_NK
WHERE TP4.EndDate IS NULL

-- Add latest history records to history table
INSERT INTO dbo.DimProduct_SCD4_History (ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, StartDate, EndDate)
SELECT ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, StartDate, GETDATE()
FROM @DimProduct_History
WHERE MergeAction = 'UPDATE';
