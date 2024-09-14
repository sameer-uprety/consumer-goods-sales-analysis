-- Q1. List top 5 customers by zones
select * from
(SELECT m.zone, 
           c.custmer_name, 
           SUM(t.sales_amount) AS total_sales,
           ROW_NUMBER() OVER (PARTITION BY m.zone ORDER BY SUM(t.sales_amount) DESC) AS ranked
    FROM markets m
    JOIN transactions t ON m.markets_code = t.market_code
    JOIN customers c ON t.customer_code = c.customer_code
    GROUP BY m.zone, c.custmer_name) ranked_customers
    where ranked <=5;
-- See the query output here: https://docs.google.com/spreadsheets/d/1obs31VzcFcczj1aFsfJLVuldW1XllStzDCW5eW7_B2M/edit?usp=sharing

-- Q2.Least sold market by zones
select * from
(select m.zone, m.markets_name, sum(t.sales_amount) as total_sales,
row_number() over (partition by m.zone
 order by sum(t.sales_amount)
) as ranked
from markets m inner join transactions t on m.markets_code = t.market_code
group by m.zone, m.markets_name
) ranked_by_sales
where ranked = 1;

-- See the query output here: https://docs.google.com/spreadsheets/d/1ZjlNuDfF8JUpgW_1UKB6B5nABw150_lnKIrWaKHxUGI/edit?usp=sharing

-- Q3. Least sold product by year
select Sale_Year, product_code, Total_Sales from
(
select year(t.order_date) as Sale_Year, t.product_code, sum(t.sales_amount) as Total_Sales,
row_number() over (partition by year(t.order_date)
order by sum(t.sales_amount))
as ranked
from transactions t  
group by Sale_Year, t.product_code	
order by Sale_Year,Total_Sales) ranked_products
where ranked = 1;

-- See the qery output here: https://docs.google.com/spreadsheets/d/1LQZxuB_d4T5evMt5c01mKjQixhOdbwgKJVdFkh-7pjM/edit?usp=sharing

