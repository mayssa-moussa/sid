with source as (
    select * from {{ ref('purchase_orders') }}
),
renamed as (
    select
        id as purchase_order_id,
        supplier_id,
        created_by as created_by_employee_id,
        DATE(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', CAST(submitted_date AS STRING))) as submitted_date,
        DATE(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', CAST(creation_date AS STRING))) as creation_date,
        DATE(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', CAST(expected_date AS STRING))) as expected_date,
        status_id as purchase_order_status_id,
        
        shipping_fee,
        taxes,
        DATE(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', CAST(payment_date AS STRING))) as payment_date,
        payment_amount,
        payment_method,
        notes,
        approved_by as approved_by_employee_id,
         DATE(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', CAST(approved_date AS STRING))) as approved_date,
        submitted_by as submitted_by_employee_id
    from source
)
select * from renamed