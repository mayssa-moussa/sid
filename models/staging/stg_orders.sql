with source as (
    select * from {{ ref('orders') }}
),
renamed as (
    select
        id as order_id,
        employee_id,
        customer_id, 
        CAST(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', order_date) AS DATE) as order_date, 
        CAST(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', shipped_date) AS DATE) as shipped_date, 
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
        CAST(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', paid_date) AS DATE) as paid_date,
        notes,
        tax_rate,
        tax_status_id as orders_tax_status_id,
        status_id as orders_status_id
    from source
)
select * from renamed
