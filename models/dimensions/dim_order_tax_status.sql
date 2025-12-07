select
    orders_tax_status_id,
    tax_status_name
from {{ ref('stg_orders_tax_status') }}
