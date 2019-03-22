create database Practice3

use Practice3

--a)

create table BankAccounts(
	BID int primary key identity(1,1),
	IBAN bigint,
	balance int
)

create table Customers(
	CID int primary key identity(1,1),
	cname varchar(70),
	dob date,
	BID int references BankAccounts(BID)
)

create table Cards(
	CDID int primary key identity(1,1),
	CVV int,
	number int
)

create table ATMs(
	AID int primary key identity(1,1),
	addres varchar(70)
)

create table CustomerAccount(
	CID int references Customers(CID),
	BID int references BankAccounts(BID),
	primary key(CID,BID)
)

create table AccountCard(
	BID int references BankAccounts(BID),
	CDID int references Cards(CDID),
	primary key(BID,CDID)
)

create table Transactions(
	TID int primary key identity(1,1),
	wsum int,
	wdate datetime,
	AID int references ATMs(AID),
	CDID int references Cards(CDID)
)

--b)

insert into BankAccounts values (1232141234167,3515),(1232143844167,4515),(1732131239167,5512),(1238141284167,1515),(1132141934167,9515),(1232419234167,8588)
insert into Customers values ('n1','1990-02-20',1),('n2','1999-06-27',2),('n3','1991-09-11',3),('n4','1995-02-14',4),('n5','1980-01-21',5)
insert into Cards values (123,6788),(425,3463),(463,4635),(134,2356),(346,6343)
insert into ATMs values ('a1'),('a2'),('a3')
insert into CustomerAccount values (2,2),(3,3)
insert into AccountCard values (1,1),(2,2),(3,3)
insert into Transactions values (421,'2019-01-02 14:31:12',1,1),(421,'2019-01-02 14:31:12',2,1),(421,'2019-01-02 14:31:12',3,1),(421,'2019-01-02 14:31:12',1,2)

select * from BankAccounts
select * from Customers
select * from Cards
select * from ATMs
select * from CustomerAccount
select * from AccountCard
select * from Transactions
go

create proc uspCT @card int
as
	declare @cardid int = (select CDID from Cards where CVV=@card)
	if @cardid is null
		raiserror('this card is inexistent!',16,1)
	
	delete from Transactions where CDID=@cardid
go

exec uspCT 123
go

--c)

create view vw_atmcard
as
select number as CardNumber
from Cards
where CDID in(
				select CDID
				from Transactions
				group by CDID
				having count(AID)=3)
go

select * from vw_atmcard
go

--d)

create or alter function usfBigTransactions()
returns table
return
select CVV, number
from Cards
where CDID in (
				select CDID
				from Transactions
				group by CDID
				having sum(wsum)>2000)
go

select * from usfBigTransactions()