use Practice1

--a)

create table TrainTypes(
	TYID int primary key identity(1,1),
	descr varchar(70)
)

create table Trains(
	TID int primary key identity(1,1),
	tname varchar(70),
	TYID int,
	foreign key(TYID) references TrainTypes(TYID)
)

create table Routes(
	RID int primary key identity(1,1),
	rname varchar(70) unique,
	TID int,
	foreign key(TID) references Trains(TID)
)

create table Stations(
	STID int primary key identity(1,1),
	sname varchar(70) unique
)

create table RoutesStations(
	RID int references Routes(RID),
	STID int references Stations(STID),
	arrtime time,
	deptime time,
	primary key(RID,STID)
)
go

--b)

insert TrainTypes values ('interregio'),('mocanita')
insert Trains values ('t1',1),('t2',2),('t3',1)
insert Routes values ('r1',1),('r2',2),('r3',1)
insert Stations values ('s1'),('s2'),('s3')
insert RoutesStations(RID,STID,arrtime,deptime)
values (1,1,'7:00','7:10'),(1,2,'8:00','8:10'),(1,3,'9:00','9:10'),(2,1,'7:00','7:10'),(3,1,'7:00','7:10'),(3,2,'8:00','8:10'),(3,3,'9:00','9:10')
go

select * from TrainTypes
select * from Trains
select * from Routes
select * from Stations
select * from RoutesStations
go

create proc uspRS @routeName varchar(70), @stationName varchar(70), @arr time, @dep time
as
	declare @rid int=(select RID from Routes where rname=@routeName)
	declare @sid int=(select STID from Stations where sname=@stationName)
	if @rid is null or @sid is null
		raiserror('station/route does not exist',16,1)
	else if exists(select * from RoutesStations where RID=@rid and STID=@sid)
		raiserror('station already on route!',16,1)
	else insert into RoutesStations(RID,STID,arrtime,deptime) values (@rid,@sid,@arr,@dep)
go

exec uspRS 'r2','s2','5:00','5:50'
go

--c)

create view vw_1 as
select rname
from Routes
where rid in(select rid
			 from RoutesStations
			 group by rid
			 having count(rid)=3)
go

select * from vw_1
go

--d)

create or alter function usfStationsByNoOfRoutes(@R int)
returns table
return select S.sname
from Stations S
where S.STID in
	(select STID
	from RoutesStations
	group by STID
	having count(*) > @R)
go

select *
from usfStationsByNoOfRoutes(2)