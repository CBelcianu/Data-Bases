use ArtGallery

--######
--INSERT
--######

--ARTISTS
insert into Artists(ArtistID,ArtistFname,ArtistLname,ArtistRank,ArtistEarnings)
values (1,'Ethan','Hunter',3,1200)

insert into Artists(ArtistID,ArtistFname,ArtistLname,ArtistRank,ArtistEarnings)
values (2,'Marcelo','Alford',1,5700)

insert into Artists(ArtistID,ArtistFname,ArtistLname,ArtistRank,ArtistEarnings)
values (3,'Declan','Cabrera',1,5570)

insert into Artists(ArtistID,ArtistFname,ArtistLname,ArtistRank,ArtistEarnings)
values (4,'Abel','Sawyer',2,3650)

insert into Artists(ArtistID,ArtistFname,ArtistLname,ArtistRank,ArtistEarnings)
values (5,'Aaron','Richarlison',3,1900)

insert into Artists(ArtistID,ArtistFname,ArtistLname,ArtistRank,ArtistEarnings)
values (6,'Jairo','Petersen',3,1900)

insert into Artists(ArtistID,ArtistFname,ArtistLname,ArtistRank,ArtistEarnings)
values (7,'Calvin','Best',1,6980)

--TAXES
insert into Taxes(TaxID,ArtistID,TaxPrice)
values (1,1,500)

insert into Taxes(TaxID,ArtistID,TaxPrice)
values (2,2,900)

insert into Taxes(TaxID,ArtistID,TaxPrice)
values (3,3,850)

insert into Taxes(TaxID,ArtistID,TaxPrice)
values (4,4,550)

insert into Taxes(TaxID,ArtistID,TaxPrice)
values (5,5,500)

insert into Taxes(TaxID,ArtistID,TaxPrice)
values (6,6,500)

insert into Taxes(TaxID,ArtistID,TaxPrice)
values (7,7,1200)

--SECTIONS
insert into Sections(SectionID,SectionType)
values (1,'Abstract Expressionism')

insert into Sections(SectionID,SectionType)
values (2,'AConceptual Art')

insert into Sections(SectionID,SectionType)
values (3,'Minimalism')

insert into Sections(SectionID,SectionType)
values (4,'Surrealism')

insert into Sections(SectionID,SectionType)
values (5,'Futurism')

--ARTS
insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (1,1,1,2000,'Honorable Depression')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (2,1,3,2300,'Weight of Forever')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (3,2,2,4700,'Enchanted Future')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (4,3,1,5300,'Demand of Death')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (5,3,4,4900,'Clock')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (6,4,5,2900,'Deadeye')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (7,5,4,1300,'The Gift')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (8,6,1,1400,'Traditions')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (9,7,5,7300,'End of Belief')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (10,7,4,6300,'Wounds of Time')

insert into Arts(ArtID,ArtistID,SectionID,ArtPrice,ArtTitle)
values (11,7,4,6700,'Breath')

--MANAGERS
insert into Managers(ManagerID,ManagerFname,ManagerLname,ManagerSalary)
values (1,'Ray','Knight',4000)

insert into Managers(ManagerID,ManagerFname,ManagerLname,ManagerSalary)
values (2,'Dennis','Knight',4100)

insert into Managers(ManagerID,ManagerFname,ManagerLname,ManagerSalary)
values (3,'Xander','Barker',3995)

insert into Managers(ManagerID,ManagerFname,ManagerLname,ManagerSalary)
values (4,'Olivia','Rose',4500)

insert into Managers(ManagerID,ManagerFname,ManagerLname,ManagerSalary)
values (5,'Delete','Delete',4500)

--DISCOUNTS
insert into Discounts(DiscountID,ArtID,ManagerID,NewPrice)
values (1,4,4,5000)

insert into Discounts(DiscountID,ArtID,ManagerID,NewPrice)
values (2,11,3,6100)

insert into Discounts(DiscountID,ArtID,ManagerID,NewPrice)
values (3,6,2,900)

insert into Discounts(DiscountID,ArtID,ManagerID,NewPrice)
values (4,2,1,1300)

--CUSTOMERS
insert into Customers(CustomerID,CustomerFname,CustomerLname,CustomerFavStyle,CustomerBudget)
values (1,'Laura','Phillips','Futurism',130000)

insert into Customers(CustomerID,CustomerFname,CustomerLname,CustomerFavStyle,CustomerBudget)
values (2,'Sofia','Henderson','Futurism',170000)

insert into Customers(CustomerID,CustomerFname,CustomerLname,CustomerFavStyle,CustomerBudget)
values (3,'Ellen','Miller','Surrealism',155000)

insert into Customers(CustomerID,CustomerFname,CustomerLname,CustomerFavStyle,CustomerBudget)
values (4,'Mark','Cooper','Abstract Expressionism',147700)

--ORDERS
insert into Orders(OrderID,ArtID,CustomerID,ManagerID,Offered_price)
values (1,1,4,2,2000)

insert into Orders(OrderID,ArtID,CustomerID,ManagerID,Offered_price)
values (2,11,3,4,6100)

insert into Orders(OrderID,ArtID,CustomerID,ManagerID,Offered_price)
values (3,3,1,1,4700)

insert into Orders(OrderID,ArtID,CustomerID,ManagerID,Offered_price)
values (4,6,2,3,900)

--ROLES
insert into Roles(RoleID,ManagerID,RoleRank,RoleName)
values (1,1,2,'Cashier')

insert into Roles(RoleID,ManagerID,RoleRank,RoleName)
values (2,2,1,'Security')

--Employees
insert into Employees(EmployeeID,RoleID,EmployeeFname,EmployeeLname,EmployeeSalary)
values (1,1,'William','Stones',1500)

insert into Employees(EmployeeID,RoleID,EmployeeFname,EmployeeLname,EmployeeSalary)
values (2,2,'Alex','Barkley',2500)

insert into Employees(EmployeeID,RoleID,EmployeeFname,EmployeeLname,EmployeeSalary)
values (3,2,'Adam','Long',2400)

--Critics
insert into Critics(CriticID,CriticFname,CriticLname)
values(4,'Delete','Delete')

--######
--UPDATE
--######

update Critics
set CriticFname='Dan'
where CriticID=1

update Sections
set SectionType='BKJ'
where SectionID is null

update Roles
set RoleName='Curator'
where RoleID in (1)

--######
--DELETE
--######

delete from Critics
where CriticFname like 'Delete' or CriticLname='Delete'

delete from Managers
where ManagerFname like 'Delete' and ManagerLname like 'Delete'