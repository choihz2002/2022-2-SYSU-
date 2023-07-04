create table cat(
    catID int(11) primary key auto_increment,
    userID int(11) not null,
    catName varchar(20) not null
);

insert into cat values(1, 1, '生活分享');
insert into cat values(2, 2, '兴趣爱好');
insert into cat values(3, 3, '生活分享');
insert into cat values(4, 4, '求助咨询');
insert into cat values(5, 5, '学习相关');
insert into cat values(6, 6, '学习相关');
insert into cat values(7, 7, '兴趣爱好');