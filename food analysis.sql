create database zomato;

use zomato;
desc user;
desc restaurants;
desc menu;
desc orders;
desc food;


-- find the customer who never order;

select name from 
user 
where user_id not in(select user_id from orders);

-- avarage price od dish
select * from menu;

select f_name,avg(price) as avarage_price
from menu m
join food f
on m.f_id=f.f_id
group by f_name;

-- find top resturants in term of order for given month

select r.r_name,count(*) 
from orders o 
join restaurants r
on o.r_id=r.r_id
 where monthname(date) like 'May'
 group by o.r_id
 order by count(*) desc limit 1;

SELECT r.r_name, COUNT(*) AS order_count
FROM orders o
JOIN restaurants r ON o.r_id = r.r_id
WHERE MONTHNAME(date) = 'May'
GROUP BY r.r_id, r.r_name
ORDER BY order_count DESC
LIMIT 1;

-- monththly sales >x price

select r_name from orders;
select r.r_name,sum(amount) 
from orders o
join restaurants r on o.r_id=r.r_id
where monthname(date) like 'june'
group by r.r_name
having sum(amount)>500
order by sum(amount) desc;
orders
-- show all order with order deatails for customer in date range

select o.order_id,r.r_name,d.f_id
from orders o
join restaurants r
on o.r_id=r.r_id
join order_details d
on o.order_id=d.order_id
where user_id=(select user_id from user where name like 'Ankit')
And date between  '2022-05-01' and '2022-07-01';

-- show all orders with order details for customer in date range
SELECT o.order_id, r.r_name, d.f_id
FROM orders o
JOIN restaurants r ON o.r_id = r.r_id
JOIN order_details d ON o.order_id = d.order_id
WHERE user_id = (SELECT user_id FROM user WHERE name LIKE 'Ankit')
AND date BETWEEN '2022-05-01' AND '2022-07-01';

--  find  restaurants with max reapeated customer
select r_id,count(*) as loyal_customer
from(
select user_id,r_id,count(*) as visit
from orders
group by r_id,user_id
having visit>1)t
group by r_id
order by loyal_customer desc limit 1;


-- month over month revenue growth

select monthname(date) as 'month',sum(amount) as 'revenue' from orders group by month order by month(date);


SELECT MONTHNAME(date) AS 'month', SUM(amount) AS 'revenue'
FROM orders
GROUP BY MONTH(date)
ORDER BY MONTH(date);
