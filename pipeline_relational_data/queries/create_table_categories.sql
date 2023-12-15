DROP TABLE IF EXISTS Categories;

USE ORDERS_RELATIONAL_DB;

--DROP TABLE IF EXISTS Categories;
-- Table creation query for sheet Categories
CREATE TABLE Categories (

CategoryID INT NOT NULL,
CategoryName VARCHAR (20),
Description VARCHAR (100)
);

ALTER TABLE Categories
ADD CONSTRAINT PK_Categories PRIMARY KEY (CategoryID);

select * from Categories