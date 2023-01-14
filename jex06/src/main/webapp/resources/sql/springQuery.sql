create table users(
    username varchar(50) not null primary key,
    password varchar(50) not null,
    enabled char(1) default '1'
);

create table authorities (
    username varchar(50) not null,
    authority varchar(50) not null,
    constraint fk_auth_username foreign key(username) references users(username) on delete cascade
);

create unique index ix_auth_username on authorities (username,authority);

insert into users (username, password) values ('user00','pw00');
insert into users (username, password) values ('member00','pw00');
insert into users (username, password) values ('admin00','pw00');

insert into authorities (username, authority) values ('user00', 'ROLE_USER');
insert into authorities (username, authority) values ('member00', 'ROLE_MANAGER');
insert into authorities (username, authority) values ('admin00', 'ROLE_MANAGER');
insert into authorities (username, authority) values ('admin00', 'ROLE_ADMIN');

create table tbl_member (
    userid varchar(50) not null primary key,
    userpw varchar(100) not null,
    username varchar(100) not null,
    regdate date default sysdate,
    updatadata date default sysdate,
    enabled char(1) default '1'
);

create table tbl_member_auth (
    userid varchar(50) not null,
    auth varchar(50) not null,
    constraint fk_member_auth foreign key(userid) references tbl_member(userid)
);


CREATE table persistent_logins (
    username varchar(64) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used TIMESTAMP not null
);


commit;
