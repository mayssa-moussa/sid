select
    order_detail_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount,
    order_details_status_id,

    

    purchase_order_id,
    inventory_id as inventory_transaction_id 

from {{ ref('stg_order_details') }}
