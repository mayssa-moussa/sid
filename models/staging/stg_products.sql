with source as (
    select * from {{ ref('products') }}
),
renamed as (
    select
        id as product_id,
        supplier_ids,
        product_code,
        product_name,
        description,
        standard_cost,
        list_price,
        reorder_level,
        target_level,
        quantity_per_unit,
        discontinued,
        minimum_reorder_quantity,
        category
    from source
)
select * from renamed