select
    product_id,
    supplier_ids ,
    product_code,
    product_name,
    standard_cost,
    list_price,
    reorder_level,
    target_level,
    quantity_per_unit,
    discontinued,
    minimum_reorder_quantity,
    category
from {{ ref('stg_products') }}
