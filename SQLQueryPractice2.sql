use Practice2

--a)

if object_id('CartiLibrarii','U') is not null
	drop table CartiLibrarii

if object_id('CartiAutori','U') is not null
	drop table CartiAutori

if object_id('Carti','U') is not null
	drop table Carti

if object_id('Autori','U') is not null
	drop table Autori

if object_id('Domenii','U') is not null
	drop table Domenii

if object_id('Librarii','U') is not null
	drop table Librarii

create table Librarii(
	LID int primary key identity(1,1),
	lname varchar(70),
	adresa varchar(70)
)

create table Domenii(
	DID int primary key identity(1,1),
	descr varchar(70)
)

create table Autori(
	AID int primary key identity(1,1),
	aname varchar(70),
	aprenume varchar(70)
)

create table Carti(
	CID int primary key identity(1,1),
	titlu varchar(70),
	DID int references Domenii(DID),
)

create table CartiAutori(
	AID int references Autori(AID),
	CID int references Carti(CID),
	primary key(AID,CID)
)

create table CartiLibrarii(
	LID int references Librarii(LID),
	CID int references Carti(CID),
	an int,
	primary key(LID,CID)
)
go

--b)

insert into Librarii values ('l1','adr1'),('l2','adr2'),('l3','adr3')
insert into Domenii values ('d1'),('d2')
insert into Autori values ('n1','p1'),('n2','p2'),('n3','p3'),('n4','p4')
insert into Carti values ('t1',1),('t2',1),('t3',2)
insert into CartiAutori values (1,1),(2,2)
insert into CartiLibrarii values (1,1,2011),(2,2,2012),(2,3,2009)

insert into Carti values ('t4',1),('t4',1),('t6',2)
insert into Carti values ('t7',1),('t8',1),('t9',2)
insert into Carti values ('t10',1),('t11',1),('t12',2)
insert into Carti values ('t13',1),('t14',1),('t15',2)
insert into Carti values ('t16',1),('t17',1),('t18',2)
insert into Carti values ('t19',1),('t20',1),('t21',2)

insert into Librarii values ('l4','adr4')

insert into CartiLibrarii values (1,4,2001),(1,5,2012),(1,6,2019),(1,7,2019),(1,8,2019)
insert into CartiLibrarii values (3,9,2011),(3,10,2012),(3,11,2019),(3,12,2019),(3,13,2019)
insert into CartiLibrarii values (2,14,2001),(2,15,2002),(2,16,2009),(2,17,2009),(2,18,2009)
insert into CartiLibrarii values (4,19,2011),(4,20,2012),(4,21,2019)

insert into CartiAutori values (1,2),(3,2)

select * from Librarii
select * from Domenii
select * from Autori
select * from Carti
select * from CartiAutori
select * from CartiLibrarii
go

create or alter proc uspAutorCarte @autorn varchar(70), @autorp varchar(70), @carte varchar(70)
as
	declare @aid int = (select AID from Autori where aname=@autorn and aprenume=@autorp)
	declare @cid int = (select CID from Carti where titlu=@carte)

	if @cid is null
		raiserror('cartea nu exista!',16,1)
	else if @aid is null 
		insert into Autori values(@autorn,@autorp)

	declare @naid int= (select AID from Autori where aname=@autorn and aprenume=@autorp)
	if exists(select * from CartiAutori where AID=@naid and CID=@cid)
		raiserror('author already associated with this book',16,1)
	else
		insert into CartiAutori values (@naid,@cid)
go

exec uspAutorCarte 'n3','p3','t7'
go

--c)

create view vw_fup
as
select L.lname, count(cid) as nr
from CartiLibrarii CL inner join Librarii L on CL.lid=L.LID
where an>2010 and CL.lid in (
							select lid
							from CartiLibrarii
							group by lid
							having count(cid)>=5
							intersect
							select lid
							from CartiLibrarii
							where an>2010
							group by LID
							)
group by L.lname
go

select * from vw_fup
go

--d)

create or alter function usCbyA(@R int)
returns table
return
select titlu, L.lname, L.adresa
from Carti C inner join CartiLibrarii CL on C.CID=CL.CID inner join Librarii L on CL.LID=L.LID
where C.CID in (
select CID
from CartiAutori
group by CID
having count(AID)=@R )
go

select *
from usCbyA(3)
