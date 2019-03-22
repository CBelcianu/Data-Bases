create database Practice4

use Practice4

--a)

create table Clienti(
	CID int primary key identity(1,1),
	Nume varchar(70),
	CodFiscal int
)

create table Agenti(
	AID int primary key identity(1,1),
	Nume varchar(70),
	Prenume varchar(70)
)

create table Produse(
	PID int primary key identity(1,1),
	Denumire varchar(70),
	UnitateMasura varchar(70)
)

create table Factura(
	FID int primary key identity(1,1),
	CID int references Clienti(CID),
	AID int references Agenti(AID),
	Numar int,
	Datae date
)

create table FacturaProduse(
	FPID int primary key identity(1,1),
	FID int references Factura(FID),
	PID int references Produse(PID),
	NrOrdine int,
	Pret int,
	Cantitate int,
)

--b)

insert into Clienti values ('n1',1234),('n2',2234),('n3',2434),('n4',1534)
insert into Agenti values ('na1','pa1'),('na2','pa2'),('na3','pa3'),('na4','pa4'),('na5','pa5')
insert into Produse values ('p1','L'),('p2','Kg'),('p3','Cm'),('p4','Mm'),('p5','Gr')
insert into Factura values (1,1,24,'2019-01-02'),(2,2,44,'2018-01-02'),(3,3,94,'2017-09-02'),(1,2,25,'2019-01-02')
insert into Factura values (2,1,44,'2018-01-02')
insert into FacturaProduse values (1,1,7,5,2),(1,2,8,14,2),(2,3,1,21,6),(3,4,10,5,2)
insert into FacturaProduse values (2,1,1,5,8)
insert into FacturaProduse values (1,2,11,3,21)


select * from Clienti
select * from Agenti
select * from Produse
select * from Factura
select * from FacturaProduse
go

create or alter proc uspAddProdus @numarFactura int ,@produs varchar(70), @nrOdr int, @pret int, @cantitate int
as
	declare @fid int = (select fid from Factura where Numar=@numarFactura)
	declare @pid int = (select pid from Produse where Denumire=@produs)

	if @fid is null or @pid is null
		raiserror('factura sau produs inexistent!',16,1)
	else if exists(select * from FacturaProduse where PID=@pid and FID=@fid)
		insert into FacturaProduse values (@fid,@pid,@nrOdr,@pret,0-@cantitate)
	else
		insert into FacturaProduse values (@fid,@pid,@nrOdr,@pret,@cantitate)
go

exec uspAddProdus 24, 'p3', 20, 7, 1
go

--c)

create or alter view vw_shaorma
as
select F.Numar, F.Datae, C.Nume, q2.ceva as 'Total'
from Factura F inner join ( 
						select *
						from FacturaProduse FP
						where FP.PID in(
										select P.Pid
										from Produse P
										where Denumire='p3')) q1 on F.FID=q1.FID
				inner join Clienti C on C.CID=F.CID
				inner join
				(
				select FP1.NrOrdine, sum(FP1.pret*FP1.cantitate) as 'ceva'
				from FacturaProduse FP1
				group by FP1.NrOrdine
				) q2 on q2.NrOrdine=q1.NrOrdine
where q2.ceva>100
go

select * from vw_shaorma
go

--d)

create function usfLunaAgentTotal()
returns table
return
select month(Datae) as luna, sum(q2.pret) as total, A.Nume, A.Prenume
from Factura F inner join (
						select Fid,Pret
						from FacturaProduse) q2 on F.FID=q2.FID inner join Agenti A on A.AID=F.AID
group by MONTH(datae), A.Nume, A.Prenume
go

select * from usfLunaAgentTotal()