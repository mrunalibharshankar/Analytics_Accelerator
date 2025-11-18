
Select * from orders
where standard_qty > 1000 and poster_qty = 0 and gloss_qty =0;


Select occurred_at, gloss_qty from orders
where gloss_qty between 24 and 29;

Select * from web_events
where channel in ('organic','adwords') and occurred_at >= "2016%"
occurred_at Desc;

select name from accounts
where (name like 'C%' or name like  'W%') 
     and ((primary_poc like '%ana%' or primary_poc like '%Ana%') 
  and primary_poc not like '%eana%');

select accounts.primary_poc,web_events.occurred_at, web_events.channel
from accounts
join web_events
on accounts.id = web_events.id
where accounts.name = 'Walmart';

select region.name as Region_name, sales_reps.name as SalesPerson, accounts.name as AccountName 
from region
join sales_reps
on region.id = sales_reps.region_id
join accounts
on sales_reps.id = accounts.sales_rep_id
order by accounts.name;

select region.name as Region_name,
accounts.name as Account_name,
round(orders.total_amt_usd/(orders.total+0.01),2) as unit_price
from orders
join accounts
on orders.account_id = accounts.id
join sales_reps
on sales_reps.id = accounts.sales_rep_id
join region
on region.id = sales_reps.region_id
order by accounts.name;

-- Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name ``

select region.name as Region_name, 
  sales_reps.name as Sales_reps_name,
  accounts.name as Account_name
from region
join sales_reps on region.id = sales_reps.region_id
join accounts on sales_reps.id = accounts.sales_rep_id
where region.name = 'Midwest'
order by accounts.name;

-- Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
-- Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.``
  
select region.name as Region_name, sales_reps.name as Sales_reps_name,
accounts.name as Account_name
from region
join sales_reps
on region.id = sales_reps.region_id
join accounts 
on sales_reps.id = accounts.sales_rep_id
where sales_reps.name like 'S%' and 
region.name = 'Midwest'
order by accounts.name;


-- Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
-- Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name. ``

select region.name as Region_name, sales_reps.name as Sales_reps_name,
accounts.name as Account_name
from region
join sales_reps
on region.id = sales_reps.region_id
join accounts 
on sales_reps.id = accounts.sales_rep_id
where split_part(sales_reps.name, ' ', 2) like 'K%' and 
region.name = 'Midwest'
order by accounts.name;

-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
--  However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. 
--  In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01). ``

select region.name as Region_name,
accounts.name as Account_name,
round(orders.total_amt_usd/ (orders.total +0.01), 2) as unit_price
from region
join sales_reps on region.id = sales_reps.region_id
join accounts on sales_reps.id = accounts.sales_rep_id
join orders on orders.account_id = accounts.id
where orders.total >100;
  

-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
-- However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
-- Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. 
-- In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

select region.name as Region_name,
accounts.name as Account_name,
round(orders.total_amt_usd/ (orders.total +0.01), 2) as unit_price
from region
join sales_reps on region.id = sales_reps.region_id
join accounts on sales_reps.id = accounts.sales_rep_id
join orders on orders.account_id = accounts.id
where orders.total >100 and orders.poster_qty > 50
order by unit_price;

-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
--However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
--Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. 
--In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). ``

select region.name as Region_name,
accounts.name as Account_name,
round(orders.total_amt_usd/ (orders.total +0.01), 2) as unit_price
from region
join sales_reps on region.id = sales_reps.region_id
join accounts on sales_reps.id = accounts.sales_rep_id
join orders on orders.account_id = accounts.id
where orders.total >100 and orders.poster_qty > 50
order by unit_price DESC;
  

-- What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. 
-- You can try SELECT DISTINCT to narrow down the results to only the unique values.``

select Distinct
accounts.name as Account_name,
web_events.channel as Channel
from accounts
join web_events on accounts.id = web_events.account_id
where accounts.id = 1001;

-- Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd. ``
select orders.occurred_at as Order_placed, 
accounts.name as Name,
orders.total as Total,
orders.total_amt_usd as Total_Price_usd
from orders
join accounts on accounts.id = orders.account_id
where orders.occurred_at between '2015-01-01' and '2015-12-31'
order by orders.occurred_at;


-- Find the total amount of poster_qty paper ordered in the orders table.``
select sum(poster_qty) as total_poster_sales
from orders;
  

-- Find the total amount of standard_qty paper ordered in the orders table.
  select sum(standard_qty) as total_standard_sales
from orders;

-- Find the total dollar amount of sales using the total_amt_usd in the orders table.
  select sum(total_amt_usd) as total
from orders;

-- Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.

  select standard_amt_usd + gloss_amt_usd as total
from orders;

-- Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.
select round(sum(standard_amt_usd)/ sum(standard_qty),2) as standard_amt_per_unit
from orders;


-- When was the earliest order ever placed? You only need to return the date.``

select min(to_char(occurred_at, 'YYYY-MM-DD')) as early_order
from orders;

-- Try performing the same query as in question 1 without using an aggregation function.``
select to_char(occurred_at, 'YYYY-MM-DD') as Order_date
from orders
order by occurred_at
limit 1;

-- When did the most recent (latest) web_event occur?``
select max(to_char(occurred_at, 'YYYY-MM-DD')) as Order_date
from web_events;

-- Try to perform the result of the previous query without using an aggregation function.``
select to_char(occurred_at, 'YYYY-MM-DD') as Order_date
from web_events
order by occurred_at Desc
limit 1;

-- Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. 
  Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.``
select avg(standard_qty) as Avg_standard_qty,
avg(gloss_qty) as Avg_gloss_qty,
avg(poster_qty) as Avg_poster_qty,
avg(standard_amt_usd) as avg_standard_amt_usd,
avg(gloss_amt_usd)  as avg_gloss_amt_usd,
avg(poster_amt_usd)  as avg_poster_amt_usd
from orders;

-- Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?``
SELECT *
FROM (SELECT total_amt_usd
         FROM orders
         ORDER BY total_amt_usd
         LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
select a.name as Account_Name,
max(o.occurred_at) as Earliest_order_date
from accounts a
Join orders o
on a.id = o.account_id
group by a.name
order by a.name;

or 
  
select a.name as Account_Name,
max(o.occurred_at) as Earliest_order_date
from accounts a
Join orders o
on a.id = o.account_id
group by a.name
order by Earliest_order_date Desc
limit 1;

-- Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.``

select a.name as Account_Name,
sum(o.total_amt_usd) as Total_sales
from accounts a
Join orders o
on a.id = o.account_id
group by a.name
order by Account_Name;

-- Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

-- Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.

-- Who was the primary contact associated with the earliest web_event?

-- What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

-- Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.





























