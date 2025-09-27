create database ecommerce;

use ecommerce;

CREATE TABLE ecommerce_churn (
    customer_id INT PRIMARY KEY,
    churn VARCHAR(10),               
    tenure INT,                            
    preferred_login_device VARCHAR(50),    
    city_tier INT,                         
    warehouse_to_home INT,                 
    preferred_payment_mode VARCHAR(50),    
    gender VARCHAR(10),                    
    hours_spent_on_app DECIMAL(5,2),       
    number_of_devices_registered INT,
    preferred_order_category VARCHAR(50),  
    satisfaction_score INT,                
    marital_status VARCHAR(20),            
    number_of_addresses INT,
    complain_flag VARCHAR(3),              
    order_amount_hike_last_year DECIMAL(5,2), 
    coupons_used INT,
    order_count INT,
    days_since_last_order INT,
    cashback_amount DECIMAL(10,2)          
);

select * from ecommerce_churn;

select * from ecommerce_churn
limit 10;

select count(*) from ecommerce_churn;

select churn, count(*)
from ecommerce_churn
group by churn;

-- Average tenure of churned vs retained customers
select churn, avg(tenure)
from ecommerce_churn
group by churn;

-- Ordered by desc according to satisfaction score using Window function
select * ,
row_number() over(order by satisfaction_score desc ) as ss 
from ecommerce_churn;

-- Most common payment mode among churned customers
select preferred_payment_mode , count(*)  as churned_customers
from ecommerce_churn
where churn = 1
group by preferred_payment_mode
order by churned_customers desc; 

-- complains related to churn
SELECT complain_flag, Churn, COUNT(*) as count
FROM ecommerce_churn
GROUP BY Complain_flag, Churn;

-- Citytier with highest churn rate
select city_tier, sum(churn)*100 / count(*) as churn_rate
from ecommerce_churn
group by city_tier
order by churn_rate desc;

-- Average cashback among churners and non-churners
select churn, avg(cashback_amount) as avg_cashback
from ecommerce_churn
group by churn;

-- Avg hours spent
select churn , avg(hours_spent_on_app) as avg_hours 
from ecommerce_churn
group by churn;

-- Coupon usage impact on churn
select churn, avg(coupons_used) as coupons_used
from ecommerce_churn
group  by churn;

-- Churn by marital status
select marital_status, sum(churn) as churned_customers , count(*) as total_customers ,
sum(churn) *100 / count(*)as churned_rate from ecommerce_churn
group by marital_status;

-- Top 5 order categories where customers churn the most
select preferred_order_category , sum(churn) as churned_customers
from ecommerce_churn 
group by preferred_order_category
order by churned_customers desc
limit 5;

-- Churn prediction factor (multi-column)
SELECT Churn, 
AVG(Tenure) AS AvgTenure,
AVG(Order_Count) AS AvgOrders,
AVG(Coupons_Used) AS AvgCoupons,
AVG(Cashback_Amount) AS AvgCashback
FROM ecommerce_churn
GROUP BY Churn;
