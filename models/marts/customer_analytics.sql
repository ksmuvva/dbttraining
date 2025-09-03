/*
  Customer analytics mart
  This model demonstrates joining staging models and creating business metrics
*/

{{ config(materialized='table') }}

with customer_metrics as (
    
    select 
        c.customer_id,
        c.customer_name,
        c.email,
        c.created_at as customer_since,
        c.status as customer_status,
        c.is_recent_customer,
        
        -- Order metrics
        count(o.order_id) as total_orders,
        coalesce(sum(o.order_amount), 0) as total_order_value,
        coalesce(sum(o.completed_amount), 0) as total_completed_value,
        coalesce(avg(o.order_amount), 0) as avg_order_value,
        max(o.order_date) as last_order_date,
        min(o.order_date) as first_order_date
        
    from {{ ref('stg_customers') }} c
    left join {{ ref('stg_orders') }} o 
        on c.customer_id = o.customer_id
    group by 1, 2, 3, 4, 5, 6

)

select 
    *,
    case 
        when total_orders = 0 then 'No Orders'
        when total_orders = 1 then 'Single Order'
        when total_orders between 2 and 5 then 'Regular Customer'
        else 'VIP Customer'
    end as customer_segment,
    
    case 
        when last_order_date >= current_date - interval '30 days' then 'Active'
        when last_order_date >= current_date - interval '90 days' then 'At Risk'
        when last_order_date is null then 'Never Ordered'
        else 'Churned'
    end as engagement_status
    
from customer_metrics