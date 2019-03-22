/*
Create Proc uspModifyTypeCol
As
	Alter Table Critics
	Alter column CriticLname varchar(10)
Go
--Exec uspModifyTypeCol
*/
/*
Create Proc uspModifyTypeColUndo
As
	Alter Table Critics
	Alter column CriticLname varchar(255)
Go
--Exec uspModifyTypeColUndo
*/
/*
Create Proc uspAddColumn
As
	Alter Table Critics
	Add CriticAge int
Go
--Exec uspAddColumn
*/
/*
Create Proc uspAddColumnUndoo
As
	Alter Table Critics
	Drop column CriticAge
Go
--Exec uspAddColumnUndoo
*/
/*
Create Proc uspRemoveCol
As
	Alter Table Critics
	Drop column CriticLname
Go
--Exec uspRemoveCol
*/
/*
Create Proc uspRemoveColUndo
As
	Alter Table Critics
	Add CriticLname varchar(255)
Go
--Exec uspRemoveColUndo
*/
/*
Create Proc uspAddDefaultConst
As
	Alter Table Critics
	Add constraint default_Lname
	Default 'Last Name' for CriticLname
Go
Exec uspAddDefaultConst
*/
/*
Create Proc uspAddDefaultConstUndo
As
	Alter Table Critics
	Drop constraint default_Lname
Go
--Exec uspAddDefaultConstUndo
*/
/*
alter Proc uspRemoveDefaultConst
As
	Alter Table Critics
	Drop constraint detault_Fname
Go
--Exec uspRemoveDefaultConst
*/
/*
Create Proc uspRemoveDefaultConstUndo
As
	Alter Table Critics
	Add constraint detault_Fname
	Default 'First Name' for CriticFname
Go
--Exec uspRemoveDefaultConstUndo
*/
/*
Create Proc uspAddPrimaryKey
As
	Alter Table Ceva
	Add constraint PK_CevaId Primary Key(CevaId)
Go
--Exec uspAddPrimaryKey
*/
/*
Create Proc uspAddPrimaryKeyUndo
As
	Alter Table Ceva
	Drop constraint PK_CevaId
Go
--Exec uspAddPrimaryKeyUndo
*/
/*
Create Proc uspRemovePrimaryKey
As
	Alter Table Ceva
	Drop constraint PK_CevaId
Go
--Exec uspRemovePrimaryKey
*/
/*
Create Proc uspRemovePrimaryKeyUndo
As
	Alter Table Ceva
	Add constraint PK_CevaId Primary Key(CevaId)
Go
--Exec uspRemovePrimaryKeyUndo
*/
/*
Create Proc uspAddCandidate
As
	Alter Table Ceva
	Add constraint UQ_CevaNume unique(Nume)
Go
--Exec uspAddCandidate
*/
/*
Create Proc uspAddCandidateUndo
As
	Alter Table Ceva
	Drop UQ_CevaNume
Go
--Exec uspAddCandidateUndo
*/
/*
Create Proc uspRemoveCandidate
As
	Alter Table Ceva
	Drop UQ_CevaNume
Go
--Exec uspRemoveCandidate
*/
/*
Create Proc uspRemoveCandidateUndo
As
	Alter Table Ceva
	Add constraint UQ_CevaNume unique(Nume)
Go
--Exec uspRemoveCandidateUndo
*/
/*
Create Proc uspAddForeign
As
	Alter Table Taxes
	Add constraint FK__TaxesArtistID foreign key(ArtistID) references Artists(ArtistID)
Go
--Exec uspAddForeign
*/
/*
Create Proc uspAddForeignUndo
As
	Alter Table Taxes
	Drop constraint FK__TaxesArtistID
Go
--Exec uspAddForeignUndo
*/
/*
Create Proc uspRemoveForeign
As
	Alter Table Taxes
	Drop constraint FK__TaxesArtistID
Go
--Exec uspRemoveForeign
*/
/*
Create Proc uspRemoveForeignUndo
As
	Alter Table Taxes
	Add constraint FK__TaxesArtistID foreign key(ArtistID) references Artists(ArtistID)
Go
--Exec uspRemoveForeignUndo
*/
/*
alter Proc uspCreateTable
As
	Create Table Ceva1(
		CevaId int not null,
		Nume varchar(255),
		CriticID int,
	);
Go
--Exec uspCreateTable
*/
/*
Create Proc uspCreateTableUndo
As
	Drop Table Ceva1
Go
--Exec uspCreateTableUndo
*/
/*
alter Proc uspRemoveTable
As
	Drop Table Ceva1
Go
--Exec uspRemoveTable
*/
/*
Create Proc uspRemoveTableUndo
As
	Create Table Ceva1(
		CevaId int not null,
		Nume varchar(255),
		CriticID int,
	);
Go
--Exec uspRemoveTableUndo
*/
--USE ArtGallery
/*
alter proc uspVersion @nrVersion int
as
	declare @CurrentVersion int=0;
	set @CurrentVersion=(select CurrentVersion from Versiune)
	if @nrVersion>@CurrentVersion
	begin
		while @nrVersion>@CurrentVersion
		begin
			if @CurrentVersion=1
				Exec uspModifyTypeCol
			else if @CurrentVersion=2
				Exec uspAddColumn
			else if @CurrentVersion=3
				Exec uspAddDefaultConst
			else if @CurrentVersion=4
				Exec uspRemoveDefaultConst
			else if @CurrentVersion=5
				Exec uspAddPrimaryKey
			else if @CurrentVersion=6
				Exec uspAddCandidate
			else if @CurrentVersion=7
				Exec uspRemoveForeign
			else if @CurrentVersion=8
				Exec uspCreateTable
			set @CurrentVersion=@CurrentVersion+1
		end
	end
	Else if @CurrentVersion>@nrVersion
	begin
		while @CurrentVersion>@nrVersion
		begin
			if @CurrentVersion=2
				Exec uspModifyTypeColUndo
			else if @CurrentVersion=3
				Exec uspAddColumnUndoo
			else if @CurrentVersion=4
				Exec uspAddDefaultConstUndo
			else if @CurrentVersion=5
				Exec uspRemoveDefaultConstUndo
			else if @CurrentVersion=6
				Exec uspRemovePrimaryKey
			else if @CurrentVersion=7
				Exec uspRemoveCandidate
			else if @CurrentVersion=8
				Exec uspAddForeign
			else if @CurrentVersion=9
				Exec uspRemoveTable
			set @CurrentVersion=@CurrentVersion-1
			end
		end
	else
		print 'The database is already in this version'
	update Versiune set CurrentVersion=@CurrentVersion
Go
*/
exec uspVersion 1
