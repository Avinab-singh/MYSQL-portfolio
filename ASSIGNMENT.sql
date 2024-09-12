use classicmodels;
# Q1 (a)
select *from employees;
select employeenumber,firstname,lastname from employees where jobTitle="Sales Rep" and reportsTo=1102;
# (b)
select *from products;
select distinct productline from products where productLine like '________c___';

#Q2
select *from customers;
select customerNumber,customerName,
case when country='USA' then 'North America'
when country='Canada' then 'North America'
when country='UK' then 'Europe'
when country='France' then 'Europe'
when country='Germany' then 'Europe'
else 'other'
end as customersegment
from customers; 

#Q3 (a)
select *from orderdetails;
select productcode,sum(quantityOrdered) as total_order from orderdetails 
group by productcode
order by sum(quantityOrdered) desc limit 10 ;

# (b)

select *from payments;
select paymentdate ,
count(amount)  from payments
order by count(amount) desc;
# Q4
create database customers_order;
use customers_order;
# (a)
create table customers(c_id int primary key auto_increment,
first_name varchar(50) not null,last_name varchar(50) not null,
email varchar(255) unique,
phone_number varchar(20));

select *from customers;
# (b)
create table orders(order_id int primary key auto_increment,
c_id int, foreign key(c_id) references customers(c_id),
order_date date ,total_amount decimal(10,2) check(total_amount>0));



# Q5

select *from customers;
select *from orders;

select customers.country,
count(orders.ordernumber) as order_count from customers
as customers inner join orders as orders on customers.customernumber=orders.customernumber
group by customers.country
order by order_count desc
limit 5;

# Q6

create table project(EmployeeID int primary key auto_increment,
Fullname varchar(50) not null,
Gender enum('male','female') ,
ManagerID int);

select *from project;
insert into project(fullname,gender,managerid) values('Pranaya','male',3),
('Priyanka','female',1),('preety','female',null),
('Anurag','male',1),('sambit','male',1),
('rajesh','male',3),('Hina','female',3);

select e.fullname as managername,m.fullname as employeename
 from project as e left join project as m on e.managerid=m.employeeid;


#Q7
create table facility(facility_id int not null,
Name varchar(100),State varchar(100),country varchar(100));

# i
alter table facility modify column facility_id int primary key auto_increment;
desc facility;
#ii
alter table facility add column city varchar(100) not null;


#8
select *from orders;
select *from products;
select *from orderdetails;
select *from productlines;
create view product_category_sales as 
select pl.productline as productline,
sum(od.quantityordered)*priceeach as total_sales,
count(distinct(o.ordernumber)) as number_of_orders from productlines as pl
join products as p on pl.productline=p.productline
join orderdetails as od on p.productcode=od.productcode
join orders as o on od.ordernumber=o.ordernumber
group by  pl.productline;


#Q10
select *from customers;
select *from orders;
#a
select c.customername as customername,count(o.ordernumber) as order_count ,
rank() over(order by count(o.ordernumber)  desc) as order_frequency_rnk
 from customers as c join orders as o on c.customernumber=o.customernumber
 group by customername;  
use classicmodels;
#b
select year(orderdate) as year,monthname(orderdate) as month,
count(ordernumber) as Total_Orders,
concat(
      format(
count(ordernumber)-lag(count(ordernumber)) over(order by year(orderdate)) /
lag(count(ordernumber)) over(order by year(orderdate)) * 100,
0),
'%')
as '% yoy change'
from orders
group by year,month
order by year asc;

#Q 11
#a
select distinct(productline),count(productline) as Total from products 
where buyprice>(select avg(buyprice) from products) 
group by productline
order by total desc;

#Q 12
create table EMP_EH(EmpID int primary key,
EmpName varchar(50),EmailAddress varchar(50));

insert into EMP_EH values('abc','avi','avisingh@gmail.com');

#Q 13
create table EMP_BIT(Name varchar(50),Occupation varchar(50),Working_Date date,Working_Hour int);
insert into emp_bit values('Robin','scientist','2020-10-04',12),
('Warner','Engineer','2020-10-04',10),
('Peter','Actor','2020-10-04',13),
('Marco','Doctor','2020-10-04',14),
('Brayden','Teacher','2020-10-04',12),
('Antonio','Business','2020-10-04',11);


