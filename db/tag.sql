create table tag(
    tagID int(11) primary key auto_increment,
    userID int(11) not null,
    tagName varchar(20) not null
);

insert into tag values(1, 1, '生活');
insert into tag values(2, 2, '爱好');
insert into tag values(3, 3, '生活');
insert into tag values(4, 4, '求助');
insert into tag values(5, 5, '学习');
insert into tag values(6, 6, '学习');
insert into tag values(7, 7, '爱好');
