create table booking (
	bookingcode varchar2(5) primary key,
	id varchar2(15) not null,
	localcode number(5) not null,
	cinemaname varchar2(100) not null,
	title_ko varchar2(30) not null,
	screencode number(5) not null,
	cincode number(5) not null,
	start_date date not null,
	end_date date not null,
	start_time number(10) not null,
	end_time number(10) not null,
	seat_no varchar2(5) not null
);
