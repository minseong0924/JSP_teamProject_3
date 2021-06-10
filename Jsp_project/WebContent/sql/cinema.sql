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

insert into cinema values
    ('1', '1', '신림점', '신림에 있어요', '서울시 관악구 신림동 신림사거리 포도몰 10층', '1', '1', '1', '1', '0', '0');
insert into cinema values
    ('1', '2', '신도림점', '신도림에 있어요', '서울시 구로구 신도림동 테크노마트 10층', '1', '1', '1', '1', '0', '0');
insert into cinema values
    ('1', '3', '홍대입구점', '홍대입구에 있어요', '서울시 마포구 동교동 토로스 쇼핑타워 4층', '1', '1', '1', '1', '0', '0');

insert into cinema values
    ('2', '4', '인계동점', '인계동에 있어요', '경기도 수원시 팔달구 인계동 1113-12', '1', '1', '1', '1', '0', '0');
insert into cinema values
    ('2', '5', '일산점', '일산에 있어요', '경기도 고양시 일산동구 장항동 867', '1', '1', '1', '1', '0', '0');

insert into cinema values
    ('3', '6', '연수점', '연수역에 있어요', '인천광역시 연수구 청능대로210 4층', '1', '1', '1', '1', '0', '0');
insert into cinema values
    ('3', '7', '송도점', '송도에 있어요', '인천광역시 연수구 하모니로158 지하 1층', '1', '1', '1', '1', '0', '0');