with source as (
    select * from {{ ref('order_details') }}
),
renamed as (
    select
        id as order_detail_id,
        order_id,
        product_id,
        quantity,
        unit_price,
        discount,
        status_id as order_details_status_id,
        PARSE_DATE('%Y%m%d', CAST(date_allocated AS STRING)) as date_allocated,
        purchase_order_id,
        inventory_id
    from source
)
select * from renamed