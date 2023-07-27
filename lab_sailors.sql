create database lab_sailors
create table sailors
(
 SID int primary key,
 SNAME varchar(30) not null unique,
 rating int not null,
 age int null
)
create table Boat
(
 BID int primary key,
 Bname varchar(30) not null,
 colour varchar(30) not null
)
create table reserves
(
SID int foreign key references sailors(SID),
BID int foreign key references Boat(BID),
day date not null
)


insert into sailors values(1502,'trisha',9,19);
insert into sailors values(1504,'abhi',8,20);
insert into sailors values(1532,'gowtham',10,19);
insert into sailors values(1550,'sailaja',9,19);
insert into sailors values(3814,'hruthik',10,19);
insert into sailors values(3811,'riya',7,19);
insert into sailors values(1562,'uday',9,21);
insert into sailors values(3812,'deva',6,18);

select * from sailors;

insert into Boat values(101,'king suite','red');
insert into Boat values(501,'Titanic','orange')
insert into Boat values(502,'carpe diem','green')
insert into Boat values(503,'Below deck','red')
insert into Boat values(504,'Destiny','orange')
insert into Boat values(505,'Aboat time','red')
insert into Boat values(506,'Yumi','orange')

select * from Boat;

insert into reserves values(1502,101,'2023-03-02');
insert into reserves values(1504,501,'2023-03-03');
insert into reserves values(1532,501,'2023-03-04');
insert into reserves values(1550,502,'2023-03-05');
insert into reserves values(3814,503,'2023-03-06');
insert into reserves values(1562,504,'2023-03-07');
insert into reserves values(3812,506,'2023-03-08');
insert into reserves values(3811,505,'2023-03-09');

select * from reserves;


--find the totalcount of sailors who had reserved green boat
select count(*) as total_count
from sailors as s,boat as b,reserves as r
where s.SID=r.SID and b.BID=r.BID and b.colour='green'

--find the sid of sailors who had reserved all the boats
select s.SID
from sailors as s,boat as b,reserves as r
where s.SID=r.SID and b.BID=r.BID 
group by s.SID
having count(b.BID)=(select count(*) from Boat)

--find the SID of sailors who reserved boat on 2023-03-02
select s.SID
from sailors as s,reserves as r
where s.SID=r.SID and r.day='2023-03-02'

--find the snames of sailors who reserved boat 103
select SNAME
from sailors
where SID in
(select SID from reserves
  where BID in
  (
   select BID from Boat
   where BID=503
  ))

--find the sidof sailors who had reserved a boat 505
  select s.SID
  from sailors as s
  where exists
  (select r.SID from reserves as r where r.BID=505)


--find snames of sailors who had reserved red boat
  select SNAME from sailors
  where SID in
  (
   select SID from reserves
   where BID in
   (
    select BID from Boat
	where colour='red'
   )
  )


  --find the names of sailors who had reserved each and every boat
select SNAME
from sailors as s,boat as b,reserves as r
where s.SID=r.SID and b.BID=r.BID
group by SNAME

--find the total no. of sailors who had reserved king suite boat
select count(s.SID) as total
from sailors as s,boat as b,reserves as r
where s.SID=r.SID and b.BID=r.BID and b.Bname='king suite'