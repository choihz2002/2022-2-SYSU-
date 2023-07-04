create table likes(
    likeID int(11) primary key auto_increment,
    userID int(11) not null,
    blogID int(11) not null,
    likeOrNot tinyint(1) not null
);


insert into likes values(1, 1, 2, 1);
insert into likes values(2, 1, 4, 1);
insert into likes values(3, 1, 6, 1);
insert into likes values(4, 2, 1, 1);
insert into likes values(5, 2, 3, 1);
insert into likes values(6, 3, 1, 1);
insert into likes values(7, 3, 7, 1);
insert into likes values(8, 4, 5, 1);
insert into likes values(9, 5, 1, 1);
insert into likes values(10, 6, 3, 1);
insert into likes values(11, 7, 2, 1);
insert into likes values(12, 8, 7, 1);
insert into likes values(13, 9, 1, 1);