select
    inventory_transaction_id,
    inventory_transaction_type_id,

    -- Date keys
    cast(format_date('%Y%m%d', cast(transaction_created_date as date))as int64)  as created_date_id,
    cast(format_date('%Y%m%d', cast(transaction_modified_date as date))as int64) as modified_date_id,

    product_id,
    quantity
    
   
    

from {{ ref('stg_inventory_transactions') }}
