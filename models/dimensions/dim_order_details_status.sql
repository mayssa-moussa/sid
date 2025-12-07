select
    order_details_status_id,
    status
from {{ ref('stg_order_details_status') }}
