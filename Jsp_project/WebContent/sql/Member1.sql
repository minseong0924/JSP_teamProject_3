create table member1(
    id varchar2(15) primary key,
    pwd varchar2(20) not null,
    name varchar2(20) not null,
    phone varchar2(20) not null,
    point number(10) default 0,
    permission varchar2(10) default 'È¸¿ø',
    birth date not null,
    regdate date
);