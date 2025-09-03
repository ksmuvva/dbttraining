/*
  Example staging model for customer data
  This model serves as a foundation for staging raw customer data
*/

{{ config(materialized='view') }}

with customers as (
    
    select 
        1 as customer_id,
        'John Doe' as customer_name,
        'john.doe@email.com' as email,
        '2020-01-15'::date as created_at,
        'active' as status
    
    union all
    
    select 
        2 as customer_id,
        'Jane Smith' as customer_name,
        'jane.smith@email.com' as email,
        '2020-02-20'::date as created_at,
        'active' as status
    
    union all
    
    select 
        3 as customer_id,
        'Bob Johnson' as customer_name,
        'bob.johnson@email.com' as email,
        '2020-03-10'::date as created_at,
        'inactive' as status

)

select 
    customer_id,
    customer_name,
    email,
    created_at,
    status,
    case 
        when created_at >= '{{ var("start_date") }}'::date 
        then true 
        else false 
    end as is_recent_customer
from customers