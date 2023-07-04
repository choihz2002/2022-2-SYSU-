create table users(
    userID int(11) primary key auto_increment,
    password varchar(26) not null,
    userName varchar(26) not null,
    isRoot tinyint(1) not null,
    speechStatus tinyint(1) not null,
    userAvatar varchar(255) not null,
    regTime timestamp not null default current_timestamp,
    motto text not null,
    homePage varchar(255) not null
);

insert into users values(1, '123', 'user', 0, 1, 'medias/user/user1.jpg', '2021-03-01 00:00:00', '鸭鸭集市主人公~', 'http://https://www.baidu.com');
insert into users values(2, '123', '阿白', 0, 1, 'medias/user/user2.jpg', '2021-06-01 00:00:00', '我是阿白balabala', 'http://user2.com');
insert into users values(3, '123', '抹茶旦旦', 0, 1, 'medias/user/user3.jpg', '2021-09-01 00:00:00', '抹茶旦旦在此！', 'http://user3.com');
insert into users values(4, '123', 'Rogerrr', 0, 1, 'medias/user/user4.jpg', '2021-12-01 00:00:00', 'Rogerrr is ME!', 'http://user4.com');
insert into users values(5, '123', '章鱼丸丸', 0, 1, 'medias/user/user5.jpg', '2022-03-01 00:00:00', '章鱼小丸子就是我最爱!', 'http://user5.com');
insert into users values(6, '123', 'evermore.', 0, 1, 'medias/user/user6.jpg', '2022-06-01 00:00:00', 'one for the money, two for the show', 'http://user6.com');
insert into users values(7, '123', '小奶龙', 0, 1, 'medias/user/user7.jpg', '2022-09-01 00:00:00', '床前明月光，疑是地上霜', 'http://user7.com');
insert into users values(8, '123', '鸭大农民工', 0, 0, 'medias/user/user8.jpg', '2022-12-01 00:00:00', '别再禁言我了555', 'http://user8.com');
insert into users values(9, '123', '俊俊子', 0, 1, 'medias/user/user9.jpg', '2023-03-01 00:00:00', 'welcome to sysu xixixi', 'http://user9.com');
insert into users values(10, '123', 'admin', 1, 1, 'medias/user/user10.jpg', '2020-11-11 00:00:00', '管理员在此，请谨言慎行', 'http://user10.com');

