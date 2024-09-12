create database ecommerce_project1;
use consummers_project;
rename table  `amazon retail sales` to `sales`;
select *from sales;
SELECT ORDER_ID FROM SALES;
DESC SALES;

ALTER TABLE SALES CHANGE `ORDER ID` ORDER_ID TEXT(20);
ALTER TABLE SALES CHANGE `ORDER DATE` ORDER_DATE TEXT(20);
ALTER TABLE SALES CHANGE `SHIP DATE` SHIP_DATE TEXT(20);
ALTER TABLE SALES CHANGE `SHIP MODE` SHIP_MODE TEXT(20);
ALTER TABLE SALES CHANGE `CUSTOMER ID` CUSTOMER_ID TEXT(20);
ALTER TABLE SALES CHANGE `CUSTOMER NAME` CUSTOMER_NAME TEXT(20);
ALTER TABLE SALES CHANGE `POSTAL CODE` POSTAL_CODE TEXT(20);
ALTER TABLE SALES CHANGE `PRODUCT ID` PRODUCT_ID TEXT(20);
ALTER TABLE SALES CHANGE `SUB-CATEGORY` SUB_CATEGORY TEXT(20);
ALTER TABLE SALES CHANGE `PRODUCT NAME` PRODUCT_NAME TEXT(20);

 DESC SALES;
 ALTER TABLE SALES MODIFY ORDER_DATE DATE;
 set sql_safe_updates=0;
 
 UPDATE SALES SET ORDER_DATE=str_to_date(ORDER_DATE,'%d/%m/%Y');
 UPDATE SALES SET ORDER_DATE=REPLACE(ORDER_DATE,'-','/');

UPDATE SALES SET ORDER_ID=CASE
                           WHEN ORDER_DATE LIKE '%/%/%' THEN str_to_date(ORDER_DATE, '%d/%m/%Y')
                           WHEN ORDER_DATE LIKE '%-%-%' THEN str_to_date(ORDER_DATE, '%d-%m-%Y')
                          else null
				          END;
                          
			ALTER TABLE SALES MODIFY ORDER_DATE DATE;	          
                    
#CHECK THE BLANK VALUES IN EACH COLUMN
select *from sales where order_id=' ' or customer_id=' ' or product_id=' ';

#check the null values in each column 
SELECT *FROM SALES WHERE ORDER_ID IS NULL OR PRODUCT_ID IS NULL ;

#FIND THE  DUPLICTAES
select order_id,product_id,count(*)
from sales 
group by order_id, product_id
having count(*)>1;

#DISPLAY THE UNIQUE NUMBER OF ORDERS,CUSTOMERS,CITY,AND STATES
SELECT *FROM SALES;
SELECT  COUNT(DISTINCT(ORDER_ID)) AS TOTAL_ORDERS,
COUNT(DISTINCT(CUSTOMER_NAME)) AS TOTAL_CUSTOMER,
COUNT(DISTINCT(CITY))AS NO_OF_CITIES,
COUNT(DISTINCT(STATE))AS NO_OF_SATES
FROM SALES;

# DETERMINE THE NUMBER OF PRODUCTS SOLD AND THE NUMBER OF CUSTOMERS AND TOP 10 PROFITABLE STATES AND CITIES.
select state,city,count(distinct(customer_name))as no_of_customers,sum(quantity)as product_sold,
round(sum(profit),2)as total_profit from sales
 group by state,city
 order by total_profit desc
 limit 10;
 
 #TOP 5 CUSTOMERS WITH THE MOST NO. OF  ORDERS
 
 select distinct(customer_name)as no_of_customer, count(distinct(order_id))as no_of_orders
 from sales
 group by customer_name
 order by no_of_orders desc
 limit 5;
 
 # TOP 5 CITY WITH most NO. OF ORDERS
 select distinct(city)as name_of_cities,count(distinct(order_id))as no_of_orders
 from sales
 group by city
 order by  no_of_orders desc
 limit 5;
 
 #TOP 5 state WITH most NO. OF ORDERS
 select distinct(state)as name_of_states,count(distinct(order_id))as no_of_orders
 from sales
 group by state
 order by  no_of_orders desc
 limit 5;
 
 #TOP 5 DATES ON WHICH THE HIGHEST SALES WAS GENERATERD
 select order_date as dates, round(sum(sales),2)as total_sales
 from sales
 group by order_date
 order by  total_sales desc
 limit 5;
 
 # CALCULATE TOTAL SALES PER MONTH
 select year(order_date) as year,month(order_date) as month, 
 monthname(order_date) as monthname,round(sum(sales),2) as total_sales
 from sales
 group by year,
 month,monthname
 order by year,month desc;
 
 #WHAT IS THE AVERAGE SALES IN EACH OF THE REGION IN 2017
 select region,floor(avg(sales))as avg_sales
 from sales
 where year(order_date)=2017
 group by region
 order by avg_sales desc;
 
 #WHICH SATES HAD THE MAXIMUM AND MINIMUM SALES IN 2016
 (select state,sum(sales)as total_sales
 from sales
 where year(order_date)=2016
 group by state
 order by total_sales desc
 limit 1)
 union
 (select state,sum(sales)as total_sales
 from sales
 where year(order_date)=2016
 group by state
 order by total_sales asc
 limit 1);
 
 #WHAT ARE THE TOTAL SALES AND PROFIT IN EACH OF THE REGION IN 2015
 select region ,sum(sales)as total_sales ,sum(profit) as profits
 from sales
 where year(order_date)=2015
 group by region 
 order by total_sales desc;
 
 use consummers_project;
 # YOY GROWTH 
 select
 year(order_date) as year,
 sum(sales)as total_sales,
 lag(sum(sales)) over(order by year(order_date))as previous_year_sales,
 concat(
       format(
               sum(sales)-lag(sum(sales)) over(order by year(order_date)) /
                 lag(sum(sales)) over(order by year(order_date)) * 100,
  2),
 '%'
 )
   as yoy_growth_precent
  from sales
  group by year(order_date)
  order by
  year;
  
  # daily report
  select date(order_date)as day ,sum(sales)
  from sales
  group by date(order_date)
  order by day;
  
  #weekly
  select year(order_date) as year,
  week(order_date,1)as weekly,
  sum(sales)
  from sales
  group by year,weekly
  order by year;
  
  #monthly
  select year(order_date) as year,
  month(order_date)as monthly,
  sum(sales)
  from sales
  group by year,monthly
  order by year,monthly;
  
  #Quatqerly
  select year(order_date) as year,
  quarter(order_date)as quaterly,
  sum(sales)
  from sales
  group by year,quarter(order_date)
  order by year;
  
  #yearly
  select year(order_date) as year,
  sum(sales)
  from sales
  group by year
  order by year;
  
  #BETWEEN DATES
  select date(order_date)as date,sum(sales)
  from sales
  where order_date between
  date(2017-05-28) and date(2014-10-26)
  group by date
  order by date;
  
  # 3 month sales report jan,feb,march for year 2015
  select year(order_date)as year,month(order_date) as month,sum(sales)
  from sales
  where year(order_date)=2015 and month(order_date) in(1,2,3)
  group by year,month
  order by year,month;
  
select *from sales;
desc sales;




