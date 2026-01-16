-- Create database CSDL_session05_04
create database CSDL_session05_04;
-- Create table customers
create table customers(
	customer_id serial primary key,
	customer_name varchar(100),
	city varchar(50)
);
-- create table orders
create table orders(
	order_id serial primary key,
	customer_id int references customers(customer_id),
	order_date date,
	total_amount numeric(10,2)
);
-- create table order_items
create table order_items (
	item_id serial primary key,
	order_id int references orders(order_id),
	product_name varchar(100),
	quantity int,
	price numeric(10,2)
);
-- insert data
insert into customers(customer_name, city) values
('Nguyễn Văn An', 'Hà Nội'),
('Trần Thị Bình', 'Hồ Chí Minh'),
('Lê Văn Cường', 'Đà Nẵng'),
('Phạm Thị Dung', 'Hà Nội'),
('Hoàng Văn Em', 'Cần Thơ'),
('Đỗ Thị Hoa', 'Hồ Chí Minh'),
('Vũ Văn Giang', 'Hải Phòng'),
('Đặng Thị Hạnh', 'Đà Nẵng'),
('Bùi Văn Ích', 'Hà Nội'),
('Ngô Thị Kim', 'Huế');

insert into orders(customer_id, order_date, total_amount) values
(1, '2024-01-15', 25000000),
(2, '2024-02-20', 18000000),
(1, '2024-03-10', 5000000),
(3, '2024-05-05', 3200000),
(4, '2024-06-01', 12000000),
(2, '2024-08-15', 7500000),
(5, '2025-01-10', 4500000),
(6, '2025-01-12', 20000000),
(1, '2025-02-01', 1500000),
(7, '2025-02-14', 6000000);

insert into order_items(order_id, product_name, quantity, price) values
(1, 'Laptop Dell XPS', 1, 25000000),
(2, 'IPhone 15 Pro', 1, 18000000),
(3, 'Màn hình LG 27"', 1, 5000000),
(4, 'Bàn phím cơ Keychron', 2, 1600000),
(5, 'Ghế công thái học', 2, 6000000),
(6, 'Tai nghe Sony', 3, 2500000),
(7, 'Chuột Logitech', 5, 900000),
(8, 'Tủ lạnh Samsung', 1, 20000000),
(9, 'Loa Bluetooth JBL', 1, 1500000),
(10, 'Máy lọc không khí', 2, 3000000);
select * from customers;
select * from orders;
select * from order_items;
-- alias
select c.customer_name as "Tên khách", o.order_date as "Ngày đặt hàng", o.total_amount as "Tổng tiền"
from customers c join orders o on c.customer_id = o.customer_id;

-- Aggregate Functions
select 
	sum(total_amount) as "Tổng doanh thu", 
 	avg(total_amount) as "Trung bình giá trị đơn hàng",
 	max(total_amount) as "Đơn hàng lớn nhất",
 	min(total_amount) as "Đơn hàng nhỏ nhất",
	count(order_id) as "Số lượng đơn hàng"
from orders;
-- Group by / having
select c.city as "Thành phố", sum(o.total_amount) as "Tổng doanh thu"
from customers c join orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_amount) > 10000;

-- join
select c.customer_name as "Tên khách hàng", oi.product_name as "Tên sản phẩm", o.order_date as "Ngày đặt hàng", oi.quantity as "Số lượng", oi.price as "Giá bán"
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id;

-- Subquery
select c.customer_name, sum(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(o.total_amount) = (
	select max(total_revenus)
	from (
		select sum(total_amount) as total_revenus
		from orders
		group by customer_id
	) as revenus
);

-- union and intersect
select city from customers
union
select c.city
from customers c join orders o on c.customer_id = o.customer_id;

select city from customers
intersect
select c.city
from customers c join orders o on c.customer_id = o.customer_id;