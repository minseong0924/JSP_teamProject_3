create table seat(
    seatno varchar2(5) primary key,
    seat_row varchar2(5) not null,
    seat_col varchar2(5) not null,
    cinemacode number(5) not null,
    cincode number(5) not null
);

DROP TABLE SEAT;

insert into seat values('A1','A','1',90001,5);