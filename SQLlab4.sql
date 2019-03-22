insert into Tables(Name)
values('Critics'),('Ratings'),('Arts')

insert into Views(Name)
values ('view_1'),('view_2'),('view_3')

insert into Tests(Name)
values ('uspInsertTest'),('uspDeleteTest'),('uspViewTest')

insert into TestViews(TestID,ViewID)
values (1,1),(1,2),(1,3)

insert into TestTables(TestID,TableID,NoOfRows,Position)
values (1,1,100,1),(1,2,100,3),(1,3,100,2)

insert into TestTables(TestID,TableID,NoOfRows,Position)
values (2,1,100,5),(2,2,100,6),(2,3,100,4)

--Proceduri

alter proc uspInsertTest
as
	declare @idTabel int
	declare @nrRows int
	declare curs cursor local for
		select TT.TableID,TT.NoOfRows from TestTables TT where TT.TestID=1 order by TT.Position
	open curs
	fetch next from curs into @idTabel,@nrRows
	while @@FETCH_STATUS=0
	begin
		if @idTabel=1
		begin
			exec uspInsertCritics @nrRows
		end
		else if @idTabel=3
		begin
			exec uspInsertArts @nrRows
		end
		else if @idTabel=2
		begin 
			exec uspInsertRatings @nrRows
		end
		fetch next from curs into @idTabel,@nrRows
	end
	close curs
	deallocate curs
go

create proc uspInsertCritics @nrRows int
as
	declare @n int
	set @n=1
	while @n<@nrRows
	begin
		insert into Critics(CriticID,CriticFname,CriticLname)
		values(@n,'Nume'+CONVERT(varchar(255),@n),'Prenume'+CONVERT(varchar(255),@n))
		set @n=@n+1
	end
go

create proc uspInsertArts @nrRows int
as
	declare @n int
	set @n=1
	while @n<@nrRows
	begin
		insert into Arts(ArtID,ArtistID,ArtPrice,ArtTitle,SectionID)
		values(@n,1,255,'Nume'+CONVERT(varchar(255),@n),1)
		set @n=@n+1
	end
go

create proc uspInsertRatings @nrRows int
as
	declare @n int
	set @n=1
	while @n<@nrRows
	begin
		insert into Ratings(Rating,ArtID,CriticID)
		values(10,@n,@n)
		set @n=@n+1
	end
go

create or alter proc uspDeleteTest
as
	declare @idTabel int
	declare @nrRows int
	declare curs cursor local for
		select TT.TableID,TT.NoOfRows from TestTables TT where TT.TestID=2 order by TT.Position
	open curs
	fetch next from curs into @idTabel,@nrRows
	while @@FETCH_STATUS=0
	begin
		declare @ceva varchar(100)
		if @idTabel=1
		begin
			set @ceva='DELETE TOP ('+CONVERT(varchar(3),@nrRows)+') FROM Critics'
		end
		else if @idTabel=3
		begin
			set @ceva='DELETE TOP ('+CONVERT(varchar(3),@nrRows)+') FROM Arts'
		end
		else if @idTabel=2
		begin 
			set @ceva='DELETE TOP ('+CONVERT(varchar(3),@nrRows)+') FROM Ratings'
		end
		exec (@ceva)
		fetch next from curs into @idTabel,@nrRows
	end
	close curs
	deallocate curs
go

create proc uspRunTests
as
	declare @startT datetime
	declare @endT datetime

	set @startT=GETDATE()
	exec uspRunTableTest
	set @endT=GETDATE()

	declare @startV datetime
	declare @endV datetime

	set @startV=GETDATE()
	exec uspRunViewTest
	set @endV=GETDATE()

	insert into TestRuns(Description,StartAt,EndAt)
	values ('Tests',@startT,@endV)

	declare @last int
	select @last = max(TestRuns.TestRunID) from TestRuns

	insert into TestRunTables(TestRunID,TableID,StartAt,EndAt)
	values (@last,1,@startT,@endT),(@last,2,@startT,@endT),(@last,3,@startT,@endT)

	insert into TestRunViews(TestRunID,ViewID,StartAt,EndAt)
	values (@last,1,@startV,@endV),(@last,2,@startV,@endV),(@last,3,@startV,@endV)
go

create proc uspRunTableTest
as
	declare @start datetime
	declare @end datetime

	set @start=GETDATE()
	exec uspInsertTest
	exec uspDeleteTest
	set @end=GETDATE()
go

create or alter proc uspRunViewTest
as
	declare @start datetime
	declare @end datetime

	exec uspInsertTest
	set @start=GETDATE()

	declare @idV int
	declare curs cursor local for select T.ViewID from TestViews as T where T.TestID=1
	open curs
	fetch next from curs into @idV
	while @@FETCH_STATUS=0
	begin
		declare @cmd varchar(100)
		if @idV=1
		begin
			set @cmd='select * from view_1'
		end
		else if @idV=2
		begin
			set @cmd='select * from view_2'
		end
		else if @idV=3
		begin
			set @cmd='select * from view_3'
		end
		exec (@cmd)
		fetch next from curs into @idV
	end
	close curs
	deallocate curs
	set @end=GETDATE()
	exec uspDeleteTest
go

exec uspRunTests

delete from Ratings
delete from Critics
delete from Arts

--mara.petrusel@yahoo.ro


