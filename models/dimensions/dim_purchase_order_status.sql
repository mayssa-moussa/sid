select
    purchase_order_status_id,
    status
from {{ ref('stg_purchase_order_status') }}



