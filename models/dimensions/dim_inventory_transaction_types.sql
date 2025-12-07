select
    inventory_transaction_type_id,
    inventory_transaction_type_name
from {{ ref('stg_inventory_transaction_types') }}
