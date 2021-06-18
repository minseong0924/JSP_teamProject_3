create table seat(
    seatno number(5) primary key,
    allseat number(5) not null,
    cinemacode number(5) not null,
    cincode number(5) not null
);

drop table seat;


insert into seat values(1,0,90001,1);
insert into seat values((select max(seatno)+1 from seat),20,90001,2);
insert into seat values((select max(seatno)+1 from seat),30,90001,3);
insert into seat values((select max(seatno)+1 from seat),40,90001,4);
insert into seat values((select max(seatno)+1 from seat),50,90001,5);
insert into seat values((select max(seatno)+1 from seat),0,90001,6);

insert into seat values((select max(seatno)+1 from seat),10,90003,1);
insert into seat values((select max(seatno)+1 from seat),0,90003,2);
insert into seat values((select max(seatno)+1 from seat),30,90003,3);
insert into seat values((select max(seatno)+1 from seat),0,90003,4);
insert into seat values((select max(seatno)+1 from seat),0,90003,5);
insert into seat values((select max(seatno)+1 from seat),60,90003,6);

insert into seat values((select max(seatno)+1 from seat),10,90004,1);
insert into seat values((select max(seatno)+1 from seat),0,90004,2);
insert into seat values((select max(seatno)+1 from seat),30,90004,3);
insert into seat values((select max(seatno)+1 from seat),40,90004,4);
insert into seat values((select max(seatno)+1 from seat),0,90004,5);
insert into seat values((select max(seatno)+1 from seat),60,90004,6);

insert into seat values((select max(seatno)+1 from seat),0,90010,1);
insert into seat values((select max(seatno)+1 from seat),0,90010,2);
insert into seat values((select max(seatno)+1 from seat),0,90010,3);
insert into seat values((select max(seatno)+1 from seat),40,90010,4);
insert into seat values((select max(seatno)+1 from seat),50,90010,5);
insert into seat values((select max(seatno)+1 from seat),60,90010,6);

insert into seat values((select max(seatno)+1 from seat),10,90020,1);
insert into seat values((select max(seatno)+1 from seat),20,90020,2);
insert into seat values((select max(seatno)+1 from seat),30,90020,3);
insert into seat values((select max(seatno)+1 from seat),0,90020,4);
insert into seat values((select max(seatno)+1 from seat),0,90020,5);
insert into seat values((select max(seatno)+1 from seat),0,90020,6);

insert into seat values((select max(seatno)+1 from seat),0,90021,1);
insert into seat values((select max(seatno)+1 from seat),20,90021,2);
insert into seat values((select max(seatno)+1 from seat),30,90021,3);
insert into seat values((select max(seatno)+1 from seat),0,90021,4);
insert into seat values((select max(seatno)+1 from seat),50,90021,5);
insert into seat values((select max(seatno)+1 from seat),60,90021,6);

insert into seat values((select max(seatno)+1 from seat),0,90029,1);
insert into seat values((select max(seatno)+1 from seat),20,90029,2);
insert into seat values((select max(seatno)+1 from seat),30,90029,3);
insert into seat values((select max(seatno)+1 from seat),40,90029,4);
insert into seat values((select max(seatno)+1 from seat),50,90029,5);
insert into seat values((select max(seatno)+1 from seat),60,90029,6);

insert into seat values((select max(seatno)+1 from seat),10,90031,1);
insert into seat values((select max(seatno)+1 from seat),20,90031,2);
insert into seat values((select max(seatno)+1 from seat),30,90031,3);
insert into seat values((select max(seatno)+1 from seat),0,90031,4);
insert into seat values((select max(seatno)+1 from seat),0,90031,5);
insert into seat values((select max(seatno)+1 from seat),0,90031,6);

insert into seat values((select max(seatno)+1 from seat),10,90033,1);
insert into seat values((select max(seatno)+1 from seat),20,90033,2);
insert into seat values((select max(seatno)+1 from seat),30,90033,3);
insert into seat values((select max(seatno)+1 from seat),0,90033,4);
insert into seat values((select max(seatno)+1 from seat),50,90033,5);
insert into seat values((select max(seatno)+1 from seat),0,90033,6);

insert into seat values((select max(seatno)+1 from seat),10,90036,1);
insert into seat values((select max(seatno)+1 from seat),20,90036,2);
insert into seat values((select max(seatno)+1 from seat),30,90036,3);
insert into seat values((select max(seatno)+1 from seat),0,90036,4);
insert into seat values((select max(seatno)+1 from seat),50,90036,5);
insert into seat values((select max(seatno)+1 from seat),60,90036,6);

insert into seat values((select max(seatno)+1 from seat),0,90040,1);
insert into seat values((select max(seatno)+1 from seat),20,90040,2);
insert into seat values((select max(seatno)+1 from seat),30,90040,3);
insert into seat values((select max(seatno)+1 from seat),0,90040,4);
insert into seat values((select max(seatno)+1 from seat),50,90040,5);
insert into seat values((select max(seatno)+1 from seat),60,90040,6);

insert into seat values((select max(seatno)+1 from seat),10,90042,1);
insert into seat values((select max(seatno)+1 from seat),20,90042,2);
insert into seat values((select max(seatno)+1 from seat),0,90042,3);
insert into seat values((select max(seatno)+1 from seat),0,90042,4);
insert into seat values((select max(seatno)+1 from seat),0,90042,5);
insert into seat values((select max(seatno)+1 from seat),60,90042,6);

insert into seat values((select max(seatno)+1 from seat),0,90044,1);
insert into seat values((select max(seatno)+1 from seat),20,90044,2);
insert into seat values((select max(seatno)+1 from seat),0,90044,3);
insert into seat values((select max(seatno)+1 from seat),40,90044,4);
insert into seat values((select max(seatno)+1 from seat),50,90044,5);
insert into seat values((select max(seatno)+1 from seat),60,90044,6);

insert into seat values((select max(seatno)+1 from seat),10,90050,1);
insert into seat values((select max(seatno)+1 from seat),20,90050,2);
insert into seat values((select max(seatno)+1 from seat),0,90050,3);
insert into seat values((select max(seatno)+1 from seat),40,90050,4);
insert into seat values((select max(seatno)+1 from seat),0,90050,5);
insert into seat values((select max(seatno)+1 from seat),60,90050,6);

insert into seat values((select max(seatno)+1 from seat),10,90052,1);
insert into seat values((select max(seatno)+1 from seat),20,90052,2);
insert into seat values((select max(seatno)+1 from seat),30,90052,3);
insert into seat values((select max(seatno)+1 from seat),40,90052,4);
insert into seat values((select max(seatno)+1 from seat),0,90052,5);
insert into seat values((select max(seatno)+1 from seat),60,90052,6);

insert into seat values((select max(seatno)+1 from seat),10,90060,1);
insert into seat values((select max(seatno)+1 from seat),20,90060,2);
insert into seat values((select max(seatno)+1 from seat),30,90060,3);
insert into seat values((select max(seatno)+1 from seat),40,90060,4);
insert into seat values((select max(seatno)+1 from seat),0,90060,5);
insert into seat values((select max(seatno)+1 from seat),0,90060,6);

insert into seat values((select max(seatno)+1 from seat),10,90061,1);
insert into seat values((select max(seatno)+1 from seat),20,90061,2);
insert into seat values((select max(seatno)+1 from seat),30,90061,3);
insert into seat values((select max(seatno)+1 from seat),0,90061,4);
insert into seat values((select max(seatno)+1 from seat),0,90061,5);
insert into seat values((select max(seatno)+1 from seat),0,90061,6);

insert into seat values((select max(seatno)+1 from seat),10,90062,1);
insert into seat values((select max(seatno)+1 from seat),20,90062,2);
insert into seat values((select max(seatno)+1 from seat),30,90062,3);
insert into seat values((select max(seatno)+1 from seat),40,90062,4);
insert into seat values((select max(seatno)+1 from seat),50,90062,5);
insert into seat values((select max(seatno)+1 from seat),60,90062,6);

insert into seat values((select max(seatno)+1 from seat),10,90070,1);
insert into seat values((select max(seatno)+1 from seat),0,90070,2);
insert into seat values((select max(seatno)+1 from seat),0,90070,3);
insert into seat values((select max(seatno)+1 from seat),0,90070,4);
insert into seat values((select max(seatno)+1 from seat),50,90070,5);
insert into seat values((select max(seatno)+1 from seat),60,90070,6);

insert into seat values((select max(seatno)+1 from seat),10,90073,1);
insert into seat values((select max(seatno)+1 from seat),20,90073,2);
insert into seat values((select max(seatno)+1 from seat),0,90073,3);
insert into seat values((select max(seatno)+1 from seat),0,90073,4);
insert into seat values((select max(seatno)+1 from seat),50,90073,5);
insert into seat values((select max(seatno)+1 from seat),60,90073,6);

insert into seat values((select max(seatno)+1 from seat),10,90081,1);
insert into seat values((select max(seatno)+1 from seat),20,90081,2);
insert into seat values((select max(seatno)+1 from seat),30,90081,3);
insert into seat values((select max(seatno)+1 from seat),0,90081,4);
insert into seat values((select max(seatno)+1 from seat),0,90081,5);
insert into seat values((select max(seatno)+1 from seat),60,90081,6);

insert into seat values((select max(seatno)+1 from seat),10,90082,1);
insert into seat values((select max(seatno)+1 from seat),20,90082,2);
insert into seat values((select max(seatno)+1 from seat),30,90082,3);
insert into seat values((select max(seatno)+1 from seat),0,90082,4);
insert into seat values((select max(seatno)+1 from seat),0,90082,5);
insert into seat values((select max(seatno)+1 from seat),0,90082,6);

insert into seat values((select max(seatno)+1 from seat),10,90091,1);
insert into seat values((select max(seatno)+1 from seat),20,90091,2);
insert into seat values((select max(seatno)+1 from seat),30,90091,3);
insert into seat values((select max(seatno)+1 from seat),40,90091,4);
insert into seat values((select max(seatno)+1 from seat),50,90091,5);
insert into seat values((select max(seatno)+1 from seat),0,90091,6);
