use project;
desc coffee;
select *from coffee; 
ALTER TABLE coffee CHANGE `Coffee consumption (kg per capita per year)` Coffee_consumption double;
ALTER TABLE coffee CHANGE `Average Coffee Price (USD per kg)` Avg_Coffee_price double;
ALTER TABLE coffee CHANGE `Population (millions)` population double;
ALTER TABLE coffee CHANGE `Type of Coffee Consumed` Coffee_Type text(30);
# top 5 country by coffee consumption
select country,sum(coffee_consumption) as total_consumption from coffee
group by country, year 
order by total_consumption desc
limit 5;
# year wise coffee consumption
select year,sum(coffee_consumption) as total_consumption from coffee
group by year 
order by year desc;
# WHICH COUNTRY HAD THE MAXIMUM AND MINIMUM consumtion IN 2023
(select country, sum(coffee_consumption) as total_comp from coffee
where year=2023
group by country
order by Total_comp desc
limit 1) 
    union
    (select country, sum(coffee_consumption) as total_comp from coffee
where year=2023
group by country
order by Total_comp asc
limit 1) ;

# WHICH COUNTRY HAD THE MAXIMUM AND MINIMUM AVG_COFFEE_PRICE IN 2023
(select country, sum(Avg_Coffee_price) as avg_price from coffee
where year=2023
group by country
order by avg_price desc
limit 1) 
    union
    (select country, sum(Avg_Coffee_price) as avg_price from coffee
where year=2023
group by country
order by avg_price asc
limit 1) ;

# YOY Growth in avg price
select year,sum(Avg_Coffee_price) as avg_price ,lag(sum(Avg_Coffee_price)) over (order by year) as previous_yr_Avg,
concat(
      format(
            (sum(Avg_Coffee_price)-lag(sum(Avg_Coffee_price)) over (order by year)) /
            (lag(sum(Avg_Coffee_price)) over (order by year))*100,
            2),
           ' %'
           ) as yoy_growth
           from coffee
           group by year 
           order by year;
# DETERMINE COFFEE_TYPE AND POPULATION USE 
select Coffee_Type, round(sum(population),2) as population from coffee
group by coffee_type
order by population desc;

#determine the coffee type and their consumption
select coffee_type,round(sum(coffee_consumption),2) as consumption from coffee
group by coffee_type
order by consumption desc;

#determine the coffee type and their avg price
select coffee_type,round(sum(Avg_Coffee_price),2) as total_price from coffee
group by coffee_type
order by total_price desc;

# determine country wise coffee type and their consumption
select country, coffee_type, round(sum(coffee_consumption),2) as total_cons from coffee
group by country,coffee_type
order by total_cons desc;

# determine country wise coffee type and their consumption and their avg price
select country, coffee_type, round(sum(coffee_consumption),2) as total_cons,
round(sum(Avg_coffee_price),2) as total_price from coffee
group by country,coffee_type
order by total_cons ,total_price desc;