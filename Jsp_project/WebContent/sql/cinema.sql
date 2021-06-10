create table cinema (
    localcode number(5),
    cinemacode number(5) primary key,
    cinemaname varchar2(20) not null,
    intro varchar2(500) not null,
    address varchar2(200) not null,
    one_cin number(1) default 0,
    two_cin number(1) default 0,
    three_cin number(1) default 0,
    four_cin number(1) default 0,
    five_cin number(1) default 0,
    six_cin number(1) default 0,
    FOREIGN KEY (localcode) REFERENCES local(localcode)
    ON DELETE CASCADE
);