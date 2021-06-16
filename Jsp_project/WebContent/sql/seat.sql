create table seat(
    seatno number(5) primary key,
    allseat number(5) not null,
    cinemacode number(5) not null,
    cincode number(5) not null
);

drop table seat;


insert into seat values(1,50,90001,1);
insert into seat values((select max(seatno)+1 from seat),70,90001,2);
insert into seat values((select max(seatno)+1 from seat),100,90001,3);
insert into seat values((select max(seatno)+1 from seat),70,90001,4);
insert into seat values((select max(seatno)+1 from seat),100,90001,5);
insert into seat values((select max(seatno)+1 from seat),60,90001,6);