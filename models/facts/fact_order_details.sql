select
    order_detail_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount,
    order_details_status_id,

    -- Date key
    cast(format_date('%Y%m%d', cast(date_allocated as date))as int64) as allocated_date_id,

    purchase_order_id,
    inventory_id as inventory_transaction_id 

from {{ ref('stg_order_details') }}
