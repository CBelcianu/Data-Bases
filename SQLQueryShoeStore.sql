use ShoeStore

--a)

create table PresentationShops(
	PID int primary key identity(1,1),
	Nune varchar(70),
	Oras varchar(70),
)

create table Women(
	WID int primary key identity(1,1),
	Nume varchar(70),
	MaxAmmount int
)

create table Models(
	MID int primary key identity(1,1),
	Nume varchar(70),
	Season varchar(70)
)

create table Shoes(
	SHID int primary key identity(1,1),
	Price int,
	MID int references Models(MID)
)

create table ShopShoes(
	SSID int primary key identity(1,1),
	PID int references PresentationShops(PID),
	SHID int references Shoes(SHID),
	NrAvailalbe int
)

create table ShoesWomen(
	SWID int primary key identity(1,1),
	SHID int references Shoes(SHID),
	WID int references Women(WID),
	NrBought int,
	Spent int
)

--b)

insert into PresentationShops values ('ps1','o1'),('ps2','o2'),('ps3','o3'),('ps4','o4')
insert into Women values ('wn1',2000),('wn2',3000),('wn3',1000),('wn4',2500)
insert into Models values ('mn1','summer'),('mn2','spring'),('mn3','fall')
insert into Shoes values (300,1),(200,1),(350,2),(500,3),(700,2)
insert into ShopShoes values (1,1,20),(2,2,20),(3,3,20),(4,4,20)
insert into ShoesWomen values (1,1,2,600)
insert into ShoesWomen values (2,2,1,200)

insert into ShoesWomen values (2,1,1,200)

select * from PresentationShops
select * from Women
select * from Models
select * from Shoes
select * from ShopShoes
select * from ShoesWomen
go

create or alter proc uspSPS @shoe int, @shopn varchar(70), @shopc varchar(70), @amm int
as
	declare @shid int = (select SHID from Shoes where Price=@shoe)
	declare @pid int = (select PID from PresentationShops where Nune=@shopn and Oras=@shopc)

	if @shid is null or @pid is null
		raiserror('shoe or shop inexistent!',16,1)
	else if exists ( select * from ShopShoes where SHID=@shid and PID=@pid )
		update ShopShoes set NrAvailalbe=NrAvailalbe+@amm where SHID=@shid and PID=@pid
	else
		insert into ShopShoes values (@pid,@shid,@amm)
go

exec uspSPS 700, 'ps1', 'o1', 3
go

--c)

create view vwWP
as
select M.Nume as Model,sum(SW.NrBought) as NrPapuci, W.Nume as Woman
from ShoesWomen SW inner join Shoes S on SW.SHID=S.SHID inner join Models M on M.MID=S.MID inner join Women W on SW.WID=W.WID
group by M.Nume,W.Nume
having sum(SW.NrBought)>=2
go

select * from vwWP
go

--d)

create or alter function usfMultipleShops(@P int)
returns table
return
select S.Price, q7.NrShops, q7.SHID
from Shoes S inner join (
					select SHID, count(PID) as NrShops
					from ShopShoes
					group by SHID
					having count(PID)>=@P) q7 on S.SHID=q7.SHID
go

select * from usfMultipleShops(2)
