/*
  Example staging model for order data
  This model demonstrates basic data transformation and cleaning
*/

{{ config(materialized='view') }}

with orders as (
    
    select 
        101 as order_id,
        1 as customer_id,
        '2020-01-20'::date as order_date,
        150.00 as order_amount,
        'completed' as order_status
    
    union all
    
    select 
        102 as order_id,
        2 as customer_id,
        '2020-02-25'::date as order_date,
        89.99 as order_amount,
        'completed' as order_status
    
    union all
    
    select 
        103 as order_id,
        1 as customer_id,
        '2020-03-15'::date as order_date,
        220.50 as order_amount,
        'pending' as order_status
    
    union all
    
    select 
        104 as order_id,
        3 as customer_id,
        '2020-04-01'::date as order_date,
        75.25 as order_amount,
        'cancelled' as order_status

)

select 
    order_id,
    customer_id,
    order_date,
    order_amount,
    order_status,
    case 
        when order_status = 'completed' then order_amount 
        else 0 
    end as completed_amount
from orders
where order_date >= '{{ var("start_date") }}'::date