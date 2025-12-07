select
    purchase_order_id,
    supplier_id,
    created_by_employee_id,

    -- Date keys
    cast(format_date('%Y%m%d', cast(submitted_date as date)) as int64)as submitted_date_id,
    cast(format_date('%Y%m%d', cast(creation_date as date)) as int64)as creation_date_id,
    cast(format_date('%Y%m%d', cast(payment_date as date))as int64) as payment_date_id,
    cast(format_date('%Y%m%d', cast(approved_date as date))as int64) as approved_date_id,

    purchase_order_status_id,
    shipping_fee,
    taxes,
    payment_amount,
    payment_method,
    approved_by_employee_id,
    submitted_by_employee_id

from {{ ref('stg_purchase_orders') }}
