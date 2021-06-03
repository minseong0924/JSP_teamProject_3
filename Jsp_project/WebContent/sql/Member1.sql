create table member1(
    id varchar2(15) primary key,
    pwd varchar2(20) not null,
    name varchar2(20) not null,
    phone varchar2(20) not null,
    point number(10) default 0,
    permission varchar2(10) default '회원',
    birth date not null,
    regdate date
);

insert into member1 values('1', '1', '홍길동', '010-1111-1111', default, default, '1996-09-24', sysdate);
insert into member1 values('2', '1', '유관순', '010-1111-1112', default, default, '1996-09-24', sysdate);
insert into member1 values('3', '1', '세종대왕', '010-1111-1113', default, default, '1996-09-24', sysdate);
insert into member1 values('4', '1', '광개토대왕', '010-1111-1114', default, default, '1996-09-24', sysdate);
insert into member1 values('5', '1', '길민성', '010-1111-1115', default, default, '1996-09-24', sysdate);
insert into member1 values('6', '1', '이상민', '010-1111-1116', default, default, '1996-09-24', sysdate);
insert into member1 values('7', '1', '서혜빈', '010-1111-1117', default, default, '1996-09-24', sysdate);
insert into member1 values('8', '1', '최범균', '010-1111-1118', default, default, '1996-09-24', sysdate);
insert into member1 values('9', '1', '아몬드', '010-1111-1119', default, default, '1996-09-24', sysdate);
insert into member1 values('10', '1', '텀블러', '010-1111-1120', default, default, '1996-09-24', sysdate);