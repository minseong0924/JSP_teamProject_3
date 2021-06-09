create table movie(
    movieCode number(5) primary key,
    title_ko varchar2(30) not null,
    title_en varchar2(30) not null,
    poster varchar2(50) not null,
    genre varchar2(20) not null,
    director varchar2(30) not null,
    actor varchar2(50) not null,
    summary varchar2(1500) not null,
    runningtime number(20) not null,
    age varchar2(30) not null,
    nation varchar2(20) not null,
    opendate date not null,
    mstate varchar2(20) not null,
    mtype varchar2(20) not null
);

