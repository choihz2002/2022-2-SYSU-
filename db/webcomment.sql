create table webcomment(
    msgID int(11) primary key auto_increment,
    userID int(11) not null,
    userPlace varchar(20) not null,
    content text not null,
    time timestamp not null default current_timestamp
);

insert into webcomment values(1, 1, '广州', '盼望世事总可有转机', '2023-05-24 10:00:00');
insert into webcomment values(2, 2, '广州', '生如远舟，为爱而活，向死而生', '2023-05-24 11:03:34');
insert into webcomment values(3, 3, '广州', '万物皆有裂痕，那是光进来的地方', '2023-05-24 12:12:12');
insert into webcomment values(4, 4, '广州', '家贫，无从致书以观，遂不观，开摆', '2023-05-24 12:59:52');
insert into webcomment values(5, 5, '深圳', '顽强地投入便没有错', '2023-05-24 13:31:13');
insert into webcomment values(6, 6, '珠海', 'I never felt so close to you', '2023-05-24 15:51:15');
insert into webcomment values(7, 7, '深圳', '温和从容，岁月静好', '2023-05-24 18:19:20');
