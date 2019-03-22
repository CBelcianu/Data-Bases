USE ArtGallery
/*
CREATE TABLE Artists (
	ArtistID int NOT NULL,
	ArtistFname varchar(255) NOT NULL,
	ArtistLname varchar(255) NOT NULL,
	ArtistRank int,
	ArtistEarnings int,
	PRIMARY KEY(ArtistID)
);
*/
/*
CREATE TABLE Sections (
	SectionID int NOT NULL,
	SectionType varchar(255) NOT NULL,
	PRIMARY KEY(SectionID)
);
*/
/*
CREATE TABLE Arts (
	ArtID int NOT NULL,
	ArtPrice int,
	ArtTitle varchar(255) NOT NULL,
	ArtistID int,
	SectionID int,
	PRIMARY KEY(ArtID),
	FOREIGN KEY(ArtistID) REFERENCES Artists (ArtistID),
	FOREIGN KEY(SectionID) REFERENCES Sections (SectionID)
);
*/
/*
CREATE TABLE Customers (
	CustomerID int NOT NULL,
	CustomerFname varchar(255) NOT NULL,
	CustomerLname varchar(255) NOT NULL,
	CustomerFavStyle varchar(255),
	CustomerBudget int,
	PRIMARY KEY(CustomerID)
);
*/
/*
CREATE TABLE Managers (
	ManagerID int NOT NULL,
	ManagerFname varchar(255) NOT NULL,
	ManagerLname varchar(255) NOT NULL,
	ManagerSalary int,
	PRIMARY KEY(ManagerID)
);
*/
/*
CREATE TABLE Orders (
	OrderID int NOT NULL,
	Offered_price int NOT NULL,
	CustomerID int,
	ManagerID int,
	ArtID int,
	PRIMARY KEY(OrderID),
	FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
	FOREIGN KEY(ManagerID) REFERENCES Managers(ManagerID),
	FOREIGN KEY(ArtID) REFERENCES Arts(ArtID)
);
*/
/*
CREATE TABLE Taxes (
	TaxID int NOT NULL,
	TaxPrice int,
	ArtistID int,
	PRIMARY KEY(TaxID),
	FOREIGN KEY(ArtistID) REFERENCES Artists(ArtistID)
);
*/
/*
CREATE TABLE Discounts (
	DiscountID int NOT NULL,
	NewPrice int,
	ArtID int,
	ManagerID int,
	PRIMARY KEY(DiscountID),
	FOREIGN KEY(ArtID) REFERENCES Arts(ArtID),
	FOREIGN KEY(ManagerID) REFERENCES Managers(ManagerID)
);
*/
/*
CREATE TABLE Roles (
	RoleID int NOT NULL,
	RoleName varchar(255) NOT NULL,
	RoleRank int NOT NULL,
	ManagerID int,
	PRIMARY KEY (RoleID),
	FOREIGN KEY(ManagerID) REFERENCES Managers(ManagerID)
);
*/
/*
CREATE TABLE Employees(
	EmployeeID int NOT NULL,
	EmployeeFname varchar(255) NOT NULL,
	EmployeeLname varchar(255) NOT NULL,
	EmployeeSalary int,
	RoleID int,
	PRIMARY KEY(EmployeeID),
	FOREIGN KEY(RoleID) REFERENCES Roles(RoleID)
);
*/