use Tdb

select *
from Ta
where aid=3

select *
from Ta
where a2 % 2 = 0

select a3
from Ta
where a3=2

select a3
from Ta
where a3 % 2 = 0

select *
from Ta
where a2=2

create nonclustered index IX_NC_Ta_A3
on Ta(a3)

--#######################################################################

select *
from Tb
where b2 = 9


create nonclustered index IX_NC_Tb_B2
on Tb(b2)
include (b3)

--#######################################################################

create or alter view view_t as
select A.a3,C.aid
from Ta A inner join Tc C on A.aid=C.aid
where A.a3=1

select * from view_t

