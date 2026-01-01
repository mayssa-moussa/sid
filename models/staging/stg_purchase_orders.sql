with source as (
    select * from {{ ref('purchase_orders') }}
),
renamed as (
    select
        id as purchase_order_id,
        supplier_id,
        created_by as created_by_employee_id,
        
        {{ parse_datetime_to_date('submitted_date') }} as submitted_date,
        {{ parse_datetime_to_date('creation_date') }} as creation_date,
        {{ parse_datetime_to_date('expected_date') }} as expected_date,
        status_id as purchase_order_status_id,
        
        shipping_fee,
        taxes,
        {{ parse_datetime_to_date('payment_date') }} as payment_date,
        payment_amount,
        payment_method,
        notes,
        approved_by as approved_by_employee_id,
        {{ parse_datetime_to_date('approved_date') }} as approved_date,
        submitted_by as submitted_by_employee_id
    from source
)
select * from renamed