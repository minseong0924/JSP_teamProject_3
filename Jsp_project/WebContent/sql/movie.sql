create table movie(
    movieCode number(5) primary key,
    title_ko varchar2(30) not null,
    title_en varchar2(30) not null,
    poster varchar2(50) not null,
    genre varchar2(20) not null,
    director varchar2(30) not null,
    actor varchar2(50) not null,
    summary varchar2(200) not null,
    runningTime varchar2(20) not null,
    age varchar2(20) not null,
    nation varchar2(20) not null,
    openDate date not null,
    movie_state varchar2(20) not null,
    movie_type varchar2(20) not null
);