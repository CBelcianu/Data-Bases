USE ArtGallery

--find the artists that have earnings > 3000 and pay tax > 600
select T.ArtistID
from Taxes T
where T.TaxPrice>600
union
select A.ArtistID
from Artists A
where A.ArtistEarnings>3000

--find the first 3 artists that have earnings > 4000 or rank < 3
select top 3 A.ArtistFname,A.ArtistLname,A.ArtistEarnings,A.ArtistRank
from Artists A
where A.ArtistEarnings>4000 OR A.ArtistRank<3

--find the artist that have arts both in Section 1 and 3
select A.ArtistID
from Artists A, Arts AA
where A.ArtistID=AA.ArtistID and AA.SectionID=1
intersect
select A1.ArtistID
from Artists A1, Arts AA1
where A1.ArtistID=AA1.ArtistID and AA1.SectionID=3

--find the arts that have a new price of 5000 or 6100
select D.ArtID, A.ArtPrice-D.NewPrice as 'Discount'
from Discounts D, Arts A
where D.ArtID=A.ArtID and D.NewPrice in (5000,6100)

--find the artists that have arts in Section 1 bun not in 3
select A.ArtistID
from Artists A, Arts AA
where A.ArtistID=AA.ArtistID and AA.SectionID=1
except
select A1.ArtistID
from Artists A1, Arts AA1
where A1.ArtistID=AA1.ArtistID and AA1.SectionID=3

--find the arts have any new price but not 5000 or 6100
select D.ArtID,A.ArtPrice-D.NewPrice as 'Discount'
from Discounts D, Arts A
where D.ArtID=A.ArtID and D.NewPrice not in (5000,6100)

--find the first 3 artists that have arts in Section 1
select top 3 A.ArtistID, A.ArtistFname, A.ArtistLname
from Artists A inner join Arts AA on  A.ArtistID=AA.ArtistID
where AA.SectionID=1

--find all the sections with their arts, including the sections with no arts
select *
from Sections S left join Arts AA on S.SectionID=AA.SectionID

--find all the arts with their discounts and artists, including the arts with no discounts
select *,AA.ArtPrice-D.NewPrice as 'Discount'
from Discounts D right join Arts AA on AA.ArtID=D.ArtID right join Artists A on A.ArtistID=AA.ArtistID

--find the id of all the managers that gave a discount to a art, together with the orders id and the ratings of the art
select D.DiscountID,M.ManagerID,O.OrderID,AA.ArtID,R.Rating
from Discounts D full join Managers M on D.ManagerID=M.ManagerID full join Orders O on O.ManagerID=M.ManagerID
full join Arts AA on O.ArtID=AA.ArtID full join Ratings R on R.ArtID=AA.ArtID

--find the id and first name of all the artists that have arts in Section 2 and 5, ordered by their first name
select AA.ArtistID,A.ArtistFname,AA.SectionID
from Arts AA, Artists A
where AA.ArtistID=A.ArtistID AND AA.SectionID IN
	(select S.SectionID
	from Sections S
	where S.SectionID in (2,5))
	order by A.ArtistFname

--find the name of all the employees whose roles were assigned by a manager that has his first name starting with 'R'
select distinct E.EmployeeFname,E.EmployeeLname
from Employees E
where E.RoleID in(
	select R.RoleID
	from Roles R
	where R.ManagerID in(
		select M.ManagerID
		from Managers M
		where M.ManagerFname like 'R%'))

--find the id and the last name of all the artists that have arts in Section 5, ordered by their last name
select AA.ArtistID,A.ArtistLname,AA.SectionID
from Arts AA, Artists A
where EXISTS
	(select S.SectionID
	from Sections S
	where S.SectionID=AA.SectionID AND AA.ArtistID=A.ArtistID AND S.SectionID=5)
	order by A.ArtistLname

--find the id of all the customers that have placed orders for arts that have a new price of 5000 or 6100
select C.CustomerID
from Customers C
where EXISTS(
	select O.ArtID
	from Orders O
	where O.CustomerID=C.CustomerID and O.ArtID in(
		select D.ArtID
		from Discounts D
		where D.NewPrice=5000 or D.NewPrice=6100))

--find the average new price for the arts that have discounts
select B.AverageNewPrice
from(select AVG(D.NewPrice) as AverageNewPrice
	from Discounts D) as B

--find the min manager salary
select B.MinManagerSalary
from(select MIN(M.ManagerSalary) as MinManagerSalary
	from Managers M) as B

--find the number of arts in each section, without the empty sections
select COUNT(AA.ArtID) as 'Number of arts', AA.SectionID
from Arts AA
group by AA.SectionID

--find the number of arts having price > 2000, grouped by price
select COUNT(AA.ArtID) as 'Number of arts', AA.ArtPrice
from Arts AA
group by AA.ArtPrice
having AA.ArtPrice>2000

--find the all prices of the arts having a price lower than the average price of all the arts that have discounts
select AA.ArtPrice
from Arts AA
group by AA.ArtPrice
having AA.ArtPrice < (select AVG(D.NewPrice)
					  from Discounts D)

--find the prices of all the arts havng a price greater than the maximum price of all the arts that have discounts
select AA.ArtPrice
from Arts AA
group by AA.ArtPrice
having AA.ArtPrice > (select MAX(D.NewPrice)
					  from Discounts D)

--find the title of the arts in the sections that have SectionType starting with 'A'
select AA.ArtTitle
from Arts AA
where AA.SectionID = any (select S.SectionID
						  from Sections S
						  where S.SectionType like 'A%')

--find the number of the arts in the sections that have SectionType starting with 'A'
select COUNT(AA.ArtTitle) as 'No. of arts'
from Arts AA
where AA.SectionID = any (select S.SectionID
						  from Sections S
						  where S.SectionType like 'A%')

--find all of the offered prices for the arts that have a pice > 2000
select O.Offered_price
from Orders O
where O.ArtID = any (select AA.ArtID
					 from Arts AA
					 where AA.ArtPrice>3000)

--find the average offered price for arts that have a price > 2000
select AVG(O.Offered_price) as 'Avg. offered price'
from Orders O
where O.ArtID = any (select AA.ArtID
					 from Arts AA
					 where AA.ArtPrice>3000)

--find the name of the customers that have placed an order grater or equal than the average of each customer order
select distinct C.CustomerFname+' '+C.CustomerLname as 'Customer Name'
from Customers C, Orders O
where C.CustomerID=O.CustomerID and O.Offered_price >= all (select AVG(O1.Offered_price)
															from Orders O1
															group by O1.CustomerID)

--find the name of the customers that have placed an order that is less than the maximum order placed by each customer 
select distinct C.CustomerFname+' '+C.CustomerLname as 'Customer Name'
from Customers C, Orders O
where C.CustomerID=O.CustomerID and O.Offered_price < all (select MAX(O1.Offered_price)
															from Orders O1
															group by O1.CustomerID)
