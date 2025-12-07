with source as (
    select * from {{ ref('inventory_transactions') }}
),
renamed as (
    select
        id as inventory_transaction_id,
        transaction_type as inventory_transaction_type_id,
        CAST(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', transaction_created_date) AS DATE) as transaction_created_date,
        CAST(PARSE_DATETIME('%m/%d/%Y %H:%M:%S', transaction_modified_date) AS DATE) as transaction_modified_date,
        product_id,
        quantity,
        purchase_order_id,
        customer_order_id as order_id,
        comments
    from source
)
select * from renamed
