create table booking (
	bookingcode varchar2(50) primary key,
	id varchar2(50) not null,
	localcode number(5) not null,
	cinemaname varchar2(1000) not null,
	title_ko varchar2(1000) not null,
	screencode number(5) not null,
	cincode number(5) not null,
	start_date date not null,
	end_date date not null,
	start_time varchar2(100) not null,
	end_time varchar2(100) not null,
	seat_no varchar2(50) not null,
    credit varchar2(50) not null
);

drop table booking;

insert into booking values('20210617-1529-00001','hong',10001,'강남','분노의 질주 : 더 얼티메이트',
11112,3,'2021-06-17','2021-06-17','18:30','20:52','20/21/23/','신용카드');

insert into booking values('20210617-1544-00002','hong',10001,'강남','분노의 질주 : 더 얼티메이트',
11112,3,'2021-06-17','2021-06-17','18:30','20:52','40/41/42/43/','계좌이체');

select max(bookingcode) from booking;