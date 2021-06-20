create table movie(
    movieCode number(5) primary key,
    title_ko varchar2(1000) not null,
    title_en varchar2(1000),
    poster varchar2(300) not null,
    genre varchar2(300) not null,
    director varchar2(300) not null,
    actor varchar2(300) not null,
    summary varchar2(1500) not null,
    runningtime number(20) not null,
    age varchar2(300) not null,
    nation varchar2(200) not null,
    opendate date not null,
    mstate varchar2(200) not null,
    mtype varchar2(200) not null
);

alter table movie modify title_en varchar2(1000);

