use Practice5

--a)

create table Clienti(
	CID int primary key identity(1,1),
	Nume varchar(70),
	Prenume varchar(70)
)

create table Angajati(
	AID int primary key identity(1,1),
	Nume varchar(70),
	Prenume varchar(70)
)

create table Marci(
	MID int primary key identity(1,1),
	Denumire varchar(70)
)

create table Autovehicule(
	AVID int primary key identity(1,1),
	NrMat varchar(70),
	Motorizare varchar(70),
	MID int references Marci(MID)
)

create table Inchirieri(
	IID int primary key identity(1,1),
	CID int references Clienti(CID),
	AID int references Angajati(AID),
	AVID int references Autovehicule(AVID),
	DataInch datetime,
	DataRat datetime
)

--b)

insert into Clienti values ('cn1','cp1'),('cn2','cp2'),('cn3','cp3'),('cn4','cp4')
insert into Angajati values ('an1','ap1'),('an2','ap2'),('an3','ap3'),('an4','ap4')
insert into Marci values ('Dacia'),('BMW'),('Hyundai')
insert into Autovehicule values ('BC 10 ABC','benzina',1),('BC 11 ABD','motorina',2),('BC 07 CRD','benzina',3),('CJ 10 MSS','GPL',1)
insert into Inchirieri values (1,1,3,'2018-10-21 12:31:21','2018-11-21 12:40:00'),(2,1,1,'2018-09-12 18:11:11','2018-10-01 10:00:00'),(3,3,2,'2018-12-21 15:30:25','2018-12-27 9:30:00')

select * from Clienti
select * from Angajati
select * from Marci
select * from Autovehicule
select * from Inchirieri
go

create proc uspAMC @anm varchar(70), @apr varchar(70), @masina varchar(70), @cnm varchar(70), @cpr varchar(70), @di datetime, @dr datetime, @op bit
as
	declare @aid int = (select aid from Angajati where Nume=@anm and Prenume=@apr)
	declare @avid int = (select avid from Autovehicule where NrMat=@masina)
	declare @cid int = (select cid from Clienti where Nume=@cnm and Prenume=@cpr)
	if @aid is null or @avid is null or @cid is null
		raiserror('angajat sau masina sau client inexistent!',16,1)
	else if @op=1
		insert into Inchirieri values(@cid,@aid,@avid,@di,@dr)
	else
		update Inchirieri set DataInch=@di, DataRat=@dr where CID=@cid and AID=@aid and AVID=@avid
go

exec uspAMC 'an2', 'ap2',  'CJ 10 MSS', 'cn4', 'cp4', '2018-01-21 12:31:11','2018-01-22 12:31:11',1
go

--c)

create view vw_AngajatMarcaLuna
as
select month(I.DataInch) as lunaCurenta, A.Nume, A.Prenume, count(I.CID) as nrMasniInchiriate
from Inchirieri I inner join Autovehicule AV on I.AVID=AV.AVID inner join Marci M on AV.MID=M.MID inner join Angajati A on A.AID=I.AID
where M.Denumire='Dacia'
group by month(I.DataInch), A.Nume, A.Prenume
having MONTH(I.DataInch)=MONTH(getdate())
go

select * from vw_AngajatMarcaLuna
go

--d)

create function usfMasiniLibere(@d datetime)
returns table
return
select NrMat
from Autovehicule
where AVID in(
			select AVID
			from Inchirieri
			where @d not between DataInch and DataRat)
go

select * from usfMasiniLibere('2018-10-21 13:00:00')