with orders as (
    select
        order_id,
        customer_id,
        employee_id,
        shipper_id,
        orders_status_id,
        {{ to_date_id('order_date ') }} as order_date_id,
        {{ to_date_id('shipped_date ') }} as shipped_date_id,
        shipping_fee,
        taxes
    from {{ ref('stg_orders') }}
),

order_details as (
    select
        order_detail_id,
        order_id,
        product_id,
        quantity,
        unit_price,
        discount,
        order_details_status_id,
        purchase_order_id
    from {{ ref('stg_order_details') }}
)

select
    od.order_detail_id,
    od.order_id,
    o.customer_id,
    o.employee_id,
    o.shipper_id,

    -- Dates
    o.order_date_id,
    o.shipped_date_id,

    -- Produit
    od.product_id,

    -- Quantité & prix
    od.quantity,
    od.unit_price,
    od.discount,

    -- Revenue calculée au niveau ligne
    od.quantity * od.unit_price * (1 - od.discount) as revenue,

    -- Taxes et shipping au niveau commande (facultatif selon besoin)
    o.shipping_fee,
    o.taxes,

    -- Statuts
    o.orders_status_id,
    od.order_details_status_id,

   

from order_details od
left join orders o
    on od.order_id = o.order_id
