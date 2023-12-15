USE Orders_RELATIONAL_DB;

DROP TABLE IF EXISTS Employees;


CREATE TABLE Employees ( 
 EmployeeID INT PRIMARY KEY NOT NULL, 
 LastName VARCHAR(40), 
 FirstName VARCHAR(40), 
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
 Notes VARCHAR(500), 
 ReportsTo INT, 
 PhotoPath VARCHAR(200) 
);

--ALTER TABLE Employees
--DROP CONSTRAINT PK_Employees
--ALTER TABLE Employees
--ADD CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID);

ALTER TABLE Employees
ADD FOREIGN KEY (ReportsTo) REFERENCES Employees(EmployeeID);


select * from dbo.Employees
