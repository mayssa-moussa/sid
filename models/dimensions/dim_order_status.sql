select
    orders_status_id,
    status_name
from {{ ref('stg_orders_status') }}
