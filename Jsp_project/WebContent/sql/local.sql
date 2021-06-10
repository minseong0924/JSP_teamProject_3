create table local(
    localcode number(5) primary key,
    localname varchar2(20) not null
);

insert into local values('1', '서울');
insert into local values('2', '경기');
insert into local values('3', '인천');