create table restaurant(Rid int primary key,Rname varchar(20));
create table category( Cid int primary key,Cname varchar(20));
create table items (I_id int primary key,iname varchar(20),
                    Cid int FOREIGN KEY REFERENCES category(Cid)
				   ,price int );


 create table rest_category(primary key(Rid,Cid),
                     Rid int FOREIGN KEY REFERENCES restaurant(Rid),
                      Cid int FOREIGN KEY REFERENCES category(Cid));



insert into restaurant values(1,'break time');
insert into restaurant values(2,'7 days');
insert into restaurant values(3,'ocean');
insert into restaurant values(4,'vanilla');
insert into restaurant values(5,'Dahab');

insert into category values(10,'appetizers');
insert into category values(11,'main course');
insert into category values(12,'drinks');
insert into category values(13,'sweet');
insert into category values(14,'dessert');

insert into items values(15,'hummos',10,7);
insert into items values(16,'chips',10,10);
insert into items values(17,'mtabal',10,12);
insert into items values(18,'salad',10,20);
insert into items values(19,'cheese chips',10,15);

insert into items values(20,'pizza',11,30);
insert into items values(21,'kabab',11,60);
insert into items values(22,'wagye beef',11,200);
insert into items values(23,'chrimp',11,170);
insert into items values(24,'pasta',11,50);

insert into items values(25,'cola',12,5);
insert into items values(26,'orange juice',12,15);
insert into items values(27,'lemon mint',12,13);
insert into items values(28,'tea',12,8);
insert into items values(29,'coffee',12,9);

insert into items values(30,'vanilla icecream',13,20);
insert into items values(31,'chocolate icecream',13,20);
insert into items values(32,'pistachio icecream',13,25);
insert into items values(33,'mango icecream',13,25);
insert into items values(34,'strawberry ice cream',13,20);

insert into items values(35,'cookie',14,35);
insert into items values(36,'tiramisu',14,50);
insert into items values(37,'chocolate cake',14,30);
insert into items values(38,'apple pie',14,30);
insert into items values(39,'fruit salad',14,25);


insert into rest_category values(1,10);
insert into rest_category values(1,11);

insert into rest_category values(2,10);
insert into rest_category values(2,12);

insert into rest_category values(3,10);
insert into rest_category values(3,13);

insert into rest_category values(4,11);
insert into rest_category values(4,13);

insert into rest_category values(5,13);
insert into rest_category values(5,14);


create view namess
as 
SELECT restaurant.Rname, items.iname
FROM   restaurant INNER JOIN
             rest_category ON restaurant.Rid = rest_category.Rid INNER JOIN
             category ON rest_category.Cid = category.Cid INNER JOIN
             items ON category.Cid = items.Cid;

select*from namess;

select restaurant.Rname as restaurant, count(*) as number_of_items, AVG(bs.num/ds.cat)as avg_items_per_category  from
(select count(*) as cat from category)as ds,
(select count(*) as num from items)as bs,
 restaurant INNER JOIN
             rest_category ON restaurant.Rid = rest_category.Rid INNER JOIN
             category ON rest_category.Cid = category.Cid INNER JOIN
             items ON category.Cid = items.Cid
			 group by restaurant.Rname;


select restaurant.Rname,min(price) as lowest_price,MAX(price) as highest_price from
             restaurant INNER JOIN
             rest_category ON restaurant.Rid = rest_category.Rid INNER JOIN
             category ON rest_category.Cid = category.Cid INNER JOIN
             items ON category.Cid = items.Cid
			 group by restaurant.Rname;




select *from(select restaurant.Rname,items.iname ,items.price,
  ROW_NUMBER()over(partition by (restaurant.Rname)
                    order by(items.price)desc ) as foo
					from  restaurant INNER JOIN
             rest_category ON restaurant.Rid = rest_category.Rid INNER JOIN
             category ON rest_category.Cid = category.Cid INNER JOIN
             items ON category.Cid = items.Cid) groups
			 where groups.foo=3;





select restaurant.Rname ,zx.more_than_five
from
(select count(*) as more_than_five from category  ) as zx ,
 restaurant INNER JOIN
             rest_category ON restaurant.Rid = rest_category.Rid INNER JOIN
             category ON rest_category.Cid = category.Cid 
			 group by restaurant.Rname,zx.more_than_five
			having zx.more_than_five<5;




















