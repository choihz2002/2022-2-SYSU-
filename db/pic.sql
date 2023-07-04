create table pic(
    picID int(11) primary key auto_increment,
    userID int(11) not null,
    name varchar(20) not null default '未命名',
    content varchar(255) not null,
    uploadTime timestamp not null default current_timestamp
);

insert into pic values(1, 1, '1', 'medias/imgs/1.jpg', '2022-10-11 12:00:00');
insert into pic values(2, 1, '2', 'medias/imgs/2.jpg', '2022-10-12 12:00:00');
insert into pic values(3, 1, '3', 'medias/imgs/3.jpg', '2022-10-13 12:00:00');
insert into pic values(4, 1, '4', 'medias/imgs/4.jpg', '2022-10-14 12:00:00');
insert into pic values(5, 2, '5', 'medias/imgs/5.jpg', '2023-03-03 13:00:00');