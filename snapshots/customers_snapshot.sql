-- Example snapshot: Customer profile changes over time
-- This file demonstrates dbt snapshot functionality

{% snapshot customers_snapshot %}

    {{
        config(
          target_database='analytics',
          target_schema='snapshots',
          unique_key='customer_id',
          strategy='timestamp',
          updated_at='updated_at',
        )
    }}

    select 
        customer_id,
        first_name,
        last_name,
        email,
        phone,
        address,
        updated_at
    from {{ source('raw', 'customers') }}

{% endsnapshot %}