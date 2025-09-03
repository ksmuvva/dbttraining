-- Example analysis: Customer order patterns
-- This file demonstrates ad-hoc analysis using dbt

select 
    c.customer_id,
    c.first_name,
    c.last_name,
    count(o.order_id) as total_orders,
    avg(o.order_total) as avg_order_value,
    min(o.order_date) as first_order_date,
    max(o.order_date) as last_order_date
from {{ ref('stg_customers') }} c
left join {{ ref('stg_orders') }} o 
    on c.customer_id = o.customer_id
group by 1, 2, 3
order by total_orders desc