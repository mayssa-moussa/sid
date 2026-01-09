with purchase_orders as (
    select
        purchase_order_id,
        supplier_id,
        created_by_employee_id,
        {{ to_date_id('submitted_date') }} as submitted_date_id,
        {{ to_date_id('creation_date') }} as creation_date_id,

        {{ to_date_id('approved_date') }} as approved_date_id,
        purchase_order_status_id,
        shipping_fee,
        taxes,
        payment_amount,
        payment_method,
        approved_by_employee_id,
        submitted_by_employee_id

    from {{ ref('stg_purchase_orders') }}
),

purchase_order_details as (
    select
        purchase_order_detail_id,
        purchase_order_id,
        product_id,
        posted_to_inventory,
        quantity,
        unit_cost,
        
        {{ to_date_id('date_received') }} as date_received_id
    from {{ ref('stg_purchase_order_details') }}
)

select
    pod.purchase_order_detail_id,
    pod.purchase_order_id,

    -- Dimensions
    po.supplier_id,
    po.created_by_employee_id,
    po.approved_by_employee_id,
    po.submitted_by_employee_id,

    -- Dates
    po.creation_date_id,
    po.submitted_date_id,
    po.approved_date_id,
    pod.date_received_id,

    -- Produit
    pod.product_id,

    -- Quantité & coûts
    pod.quantity,
    pod.unit_cost,
    pod.quantity * pod.unit_cost as cost,

    -- Statuts
    po.purchase_order_status_id,
    pod.posted_to_inventory,

    -- Paiement / frais (au niveau commande)
    po.shipping_fee,
    po.taxes,
    po.payment_amount,
    po.payment_method

from purchase_order_details pod
left join purchase_orders po
    on pod.purchase_order_id = po.purchase_order_id
