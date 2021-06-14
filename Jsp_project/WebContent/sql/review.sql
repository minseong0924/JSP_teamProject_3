create table review (
	no number(5) primary key,
	id varchar2(15) not null,
	moviecode number(5) not null,
	title_ko varchar2(30) not null,
	content varchar2(1000) not null,
	point number(5) not null,
	regdate date
);

