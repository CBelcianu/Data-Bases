use ILikeTrains

--a)

if object_id('RoutesStations','U') is not null
	drop table RoutesStations

if object_id('Stations','U') is not null
	drop table Stations

if object_id('Routes','U') is not null
	drop table [Routes]

if object_id('Trains','U') is not null
	drop table Trains

if object_id('TrainTypes','U') is not null
	drop table TrainTypes

create table TrainTypes(
	typeID int primary key identity(1,1),
	decription varchar(200),
)

create table Trains(
	trainID int primary key identity(1,1),
	tname varchar(70),
	typeID int,
	foreign key(typeID) references TrainTypes(typeID)
)

create table Routes(
	routeID int primary key identity(1,1),
	rname varchar(70) unique,
	trainID int,
	foreign key(trainID) references Trains(trainID)
)

create table Stations(
	stationID int primary key identity(1,1),
	sname varchar(70) unique,
)

create table RoutesStations(
	routeID int references Routes(routeID),
	stationID int references Stations(stationID),
	arrTime time,
	depTime time,
	primary key(routeID,stationID)
)
go
--b)

insert TrainTypes values ('interregio'),('mocanita')
insert Trains values ('t1',1),('t2',2),('t3',1)
insert Routes values ('r1',1),('r2',2),('r3',1)
insert Stations values ('s1'),('s2'),('s3')
insert RoutesStations(routeID,stationID,arrTime,depTime)
values (1,1,'7:00','7:10'),(1,2,'8:00','8:10'),(1,3,'9:00','9:10'),(2,1,'7:00','7:10'),(3,1,'7:00','7:10'),(3,2,'8:00','8:10'),(3,3,'9:00','9:10')
go

select * from TrainTypes
select * from Trains
select * from Routes
select * from Stations
select * from RoutesStations
go

create or alter proc uspStationOnRoute @rname varchar(70), @sname varchar(70), @arr time, @dep time
as
	declare @rid int = (select routeID from Routes where rname=@rname),
	@sid int = (select stationID from Stations where sname=@sname)

	if @rid is null or @sid is null
		raiserror('station and/or route does not exist',16,1)
	else if exists(select * from RoutesStations where routeID=@rid and stationID=@sid)
		raiserror('station already exists',16,1)
	else
		insert RoutesStations(routeID,stationID,arrTime,depTime) values (@rid,@sid,@arr,@dep)
go

exec uspStationOnRoute 'r2','s2','5:00','5:10'
go

--c)

create or alter view view_rs as
select R.rname
from Routes R
where not exists
	(select stationID
	 from Stations
	 except
	 select stationID
	 from RoutesStations
	 where routeID=R.routeID)
go

select * from view_rs
go

--d)

create or alter function usfStationsByNoOfRoutes(@R int)
returns table
return select S.sname
from Stations S
where S.stationID in
	(select stationID
	from RoutesStations
	group by stationID
	having count(*) > @R)
go

select *
from usfStationsByNoOfRoutes(2)