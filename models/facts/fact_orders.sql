select
    order_id,
    customer_id,
    employee_id,
    shipper_id,
    orders_status_id,
    

    -- Date keys
    
    cast(format_date('%Y%m%d', cast(order_date as date)) as int64) as order_date_id,
    cast(format_date('%Y%m%d', cast(shipped_date as date))as int64) as shipped_date_id,

    shipping_fee,
    taxes
    

from {{ ref('stg_orders') }}
