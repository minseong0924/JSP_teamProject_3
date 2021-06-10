create table screen (
    screencode number(5) primary key,
    moviecode number(5),
    cinemacode number(5),
    cinemaname varchar2(200),
    cincode number(5),
    start_time number(10),
    end_time number(10),
    start_date date,
    end_date date
);