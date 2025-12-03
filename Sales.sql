-- Warm up 1
-- the earliest year of purchase
select max(year) as early_year from Prework.Sales;

-- the average customer age per year? Order the years in ascending order.
select round(avg(customer_age), 2) as Avg_Age, 
       Year
 from Prework.Sales
 group by Year
 order by Year;

-- Return all clothing purchases from September 2015 where the cost was at least $70.
select * from Prework.Sales
where Product_Category = 'Clothing' And Month = 'September' And Year = 2015 and Cost >= 70;

-- What are all the different types of product categories that were sold from 2014 to 2016 in France?
select count(*) as Count,
       Product_Category
 from Prework.Sales
where Year between 2014 and 2016 and Country = 'France'
group by Product_Category;

-- Within each product category and age group (combined), what is the average order quantity and total profit?

Select Product_Category,
Age_Group,
Round(Avg(Order_quantity),2) as Avg_Quantity,
Sum(Profit) as Total_Profit
from Prework.Sales
Group by 1, 2;


-- Warm Up 2































