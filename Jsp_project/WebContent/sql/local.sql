create table local(
    localcode number(5) primary key,
    localname varchar2(20) not null
);

insert into local values(10001,'서울');
insert into local values(10002,'경기');
insert into local values(10003,'인천');
insert into local values(10004,'대전/충청/세종');
insert into local values(10007,'부산/대구/경상');
insert into local values(10010,'광주/전라');
insert into local values(10011,'전라');
insert into local values(10012,'강원');
insert into local values(10013,'제주');

