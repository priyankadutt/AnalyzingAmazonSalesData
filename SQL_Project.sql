## Create database and import the dataset in a table name amazon_data
use project;
select * from amazon_data;
## Initial insight into dataset -- 1000 of rows and 17 columns are present and no null and missing value is there.amazon_data

## create day_time column
alter table amazon_data
add column day_time varchar(10);
update amazon_data
set day_time = 
  case
     when time(time) >= '04:00:00' and time(time) < '12:00:00' then 'Morning'
     when time(time) >= '12:00:00' and time(time) < '16:00:00' then 'AfterNoon'
     else 'Evening'
  end;
## create day column
alter table amazon_data
add column Day_name varchar(10);
update amazon_data
set Day_name = dayname(date);
## create month column
alter table amazon_data
add column Month_name varchar(10);
update amazon_data
set Month_name = monthname(date);


## product analysis
select product_line, sum(Total) as Highest_sales
from amazon_data
group by Product_line
order by Highest_sales desc;
## Food and beverages = 56144.844000000005 highest revenew & Health and beauty	49193.739000000016 lowest revenew

## Sales analysis
select sum(Total) as Highest_sales, Month_name
from amazon_data
group by Month_name
order by Highest_sales desc;
## 116291.86800000005 = January  & 109455.50700000004 = March & 97219.37399999997 = February

select distinct branch,city
from amazon_data;
select city, sum(Total) as Highest_sales
from amazon_data
group by city
order by Highest_sales desc;
## Naypyita = 110568.70649999994 highest sales & Mandalay = 106197.67199999996 lowest sales
select city, sum(Quantity) as Highest_quantity
from amazon_data
group by city
order by Highest_quantity desc;
## Yangon = 1859 highest quantity & Mandalay = 1820 lowest quantity

select day_time,count(*) as frequency
from amazon_data
group by day_time
order by frequency desc;
## AfterNoon=377 times and Evening=357 times and Morning=191 times and Night=75 times

select Payment,count(*) as Payment_frequency
from amazon_data
group by Payment
order by Payment_frequency desc;
## Ewallet=345 and Cash=344 and Credit card=311

## Customer Analysis
select Customer_type,count(*) as frequency
from amazon_data
group by Customer_type
order by frequency desc;
## Member = 501 and Normal = 499

select gender,count(*) as gender_count
from amazon_data
group by gender
order by gender_count desc;
## Female = 501 and Male = 499
select gender,branch,count(*) as gender_count
from amazon_data
group by gender,branch
order by gender_count desc;
## Male -> A -> 179 high
## Female -> C -> 178 high
## Female -> A -> 161 low
## Male -> C -> 150 low

-- 1. What is the count of distinct cities in the dataset?
select count(distinct city) as city_count
from amazon_data;
## city_count -> 3

-- 2. For each branch, what is the corresponding city?
select city, branch
from amazon_data
group by city,branch;
## Yangon -> A and Naypyitaw -> C and Mandalay -> B

-- 3. What is the count of distinct product lines in the dataset?
select count(distinct product_line) as unique_product_line
from amazon_data;
## unique_product_line = 6

-- 4. Which payment method occurs most frequently?
select Payment,count(*) as Payment_frequency
from amazon_data
group by Payment
order by Payment_frequency desc;
## Ewallet=345

-- 5. Which product line has the highest sales?
select product_line, sum(Total) as Highest_sales
from amazon_data
group by Product_line
order by Highest_sales desc;
## Food and beverages = 56144.844000000005 

-- 6. How much revenue is generated each month?
select Month_name,round(sum(Total),2) as Highest_revenew
from amazon_data
group by Month_name
order by Highest_revenew desc;
## January=116291.87

-- 7. In which month did the cost of goods sold reach its peak?
select month_name, round(sum(cogs),2) as total_cogs
from amazon_data
group by Month_name
order by total_cogs;
## February=92589.88

-- 8. Which product line generated the highest revenue?
select Product_line, round(sum(total),2) as highest_revenew
from amazon_data
group by Product_line
order by highest_revenew desc;
## Food and beverages=56144.84

-- 9. In which city was the highest revenue recorded?
select city, round(sum(total),2) as highest_revenew
from amazon_data
group by city
order by highest_revenew desc;
## Naypyitaw=110568.71

-- 10. Which product line incurred the highest Value Added Tax?
select Product_line, round(sum(VAT),2) as highest_revenew
from amazon_data
group by Product_line
order by highest_revenew desc;
## Food and beverages=2673.56

-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

-- 12. Identify the branch that exceeded the average number of products sold.

-- 13. Which product line is most frequently associated with each gender?
select gender,Product_line,count(product_line) as product_count
from amazon_data
group by gender,Product_line
order by product_count desc;
## Female -> Fashion accessories -> 96  and  Male -> Health and beauty -> 88

-- 14. Calculate the average rating for each product line.
select product_line,round(avg(rating),2) as avarage_rating
from amazon_data
group by Product_line
order by avarage_rating desc;
## Food and beverages -> 7.11  and  Fashion accessories -> 7.03  and  Health and beauty -> 7
## Electronic accessories -> 6.92  and  Sports and travel -> 6.92  and  Home and lifestyle -> 6.84

-- 15. Count the sales occurrences for each time of day on every weekday.
select day_name,day_time,count(*) as sales_count
from amazon_data
where dayofweek(date) between 2 and 6
group by day_name,Day_time
order by day_name,sales_count desc;

-- 16. Identify the customer type contributing the highest revenue.
select customer_type,round(sum(total),2) as highest_revenew
from amazon_data
group by Customer_type
order by highest_revenew desc;
# Member -> 164223.44  and  Normal -> 158743.31

-- 17. Determine the city with the highest VAT percentage.
select city,VAT
from amazon_data
group by city,VAT
order by VAT desc;
## Naypyitaw city has highest vat parcentage and that is 49.65%

-- 18. Identify the customer type with the highest VAT payments.
select Customer_type,round(sum(VAT),2) as total_vat
from amazon_data
group by Customer_type
order by total_vat desc;
## Member -> 7820.16  and  Normal -> 7559.21

-- 19. What is the count of distinct customer types in the dataset?
select customer_type,count(*) as cout_of_customer
from amazon_data
group by Customer_type;
## Member -> 501  and Normal -> 499

-- 20. What is the count of distinct payment methods in the dataset?
select Payment,count(*) as Payment_frequency
from amazon_data
group by Payment
order by Payment_frequency desc;
## Ewallet=345 and Cash=344 and Credit card=311

-- 21. Which customer type occurs most frequently?
select customer_type,count(*) as cout_of_customer
from amazon_data
group by Customer_type;
## Member -> 501

-- 22. Identify the customer type with the highest purchase frequency.
select customer_type,count(*) as highest_purchase_frequency
from amazon_data
group by Customer_type;
## Member -> 501  and Normal -> 499

-- 23. Determine the predominant gender among customers.
select gender,count(*) as frequency_of_gender
from amazon_data
group by gender;
## Female -> 501  and  Male -> 499

-- 24. Examine the distribution of genders within each branch.
select branch,city,gender,count(gender) as gender_count
from amazon_data
group by branch,gender,city
order by branch,gender_count desc;

-- 25. Identify the time of day when customers provide the most ratings.
select day_time,count(rating) as count_of_rating 
from amazon_data
group by day_time
order by count_of_rating desc;
## Evening -> 432  and AfterNoon -> 377 and Morning -> 191

-- 26. Determine the time of day with the highest customer ratings for each branch.
with cte as(
select branch,day_time,avg(rating) as avg_rating
from amazon_data
group by branch,day_time
)
select branch,day_time,round(avg_rating,2) as highest_customer_rating
from ( 
select branch,day_time,avg_rating,
row_number() over (partition by branch order by avg_rating desc) as rn
from cte
)as ranking
where rn=1;
## Branch A -> AfterNoon -> 7.19  and  Branch B -> Morning -> 6.89  and  Branch C -> Evening -> 7.12

-- 27. Identify the day of the week with the highest average ratings.
select day_name,round(avg(rating),2) as avg_rating
from amazon_data
group by day_name
order by avg_rating desc;
## Wednesday -> 7.11

-- 28. Determine the day of the week with the highest average ratings for each branch.
with cte as
(
select branch,day_name,avg(rating) as avg_rating,row_number() over (partition by branch order by avg(rating) desc) as row_num
from (
        select branch,day_name,rating
        from amazon_data
) as daily_rating
group by branch,day_name
)
select branch,day_name,round(avg_rating,2) as highest_avg_rating
from cte
where row_num=1
order by branch,avg_rating desc;
## Branch A -> Tuesday -> 7.23  and  Branch B -> Friday -> 7.23  and  Branch C -> Sunday -> 7.48













