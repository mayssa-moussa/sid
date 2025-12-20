select
    purchase_order_detail_id,
    purchase_order_id,
    product_id,
    --inventory_transaction_id,
    posted_to_inventory,

    quantity,
    unit_cost,

    cast(format_date('%Y%m%d', cast(date_received as date)) as int64) as date_received_id


from {{ ref('stg_purchase_order_details') }}