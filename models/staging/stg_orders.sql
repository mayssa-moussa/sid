with source as (
    select * from {{ ref('orders') }}
),
renamed as (
    select
        id as order_id,
        employee_id,
        customer_id, 
        {{ parse_datetime_to_date('order_date') }}   as order_date,
        {{ parse_datetime_to_date('shipped_date') }} as shipped_date, 
        shipper_id,
        ship_name,
        ship_address,   
        ship_city,
        ship_state_province,
        ship_zip_postal_code,
        ship_country_region,
        shipping_fee,
        taxes,
        payment_type,
        {{ parse_datetime_to_date('paid_date') }} as paid_date,
        tax_rate,
        status_id as orders_status_id
    from source
)
select * from renamed
