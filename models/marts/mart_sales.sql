

with order_details as (
    select
        fod.order_id,
        fod.product_id,
        fod.quantity,
        fod.unit_price,
        fod.discount,

        fo.customer_id,
        fo.employee_id,
        fo.shipper_id,
        fo.orders_status_id,

        fo.order_date_id,
        fo.shipped_date_id,
        fo.shipping_fee,
        fo.taxes

    from {{ ref('fact_order_details') }} fod
    join {{ ref('fact_orders') }} fo
        on fod.order_id = fo.order_id
)

select
    -- extraire les noms des clients ,des employés et des produits à partir de leurs dimensions
    p.product_name,

    CONCAT(c.last_name, ' ', c.first_name)
        AS customer_name,

    CONCAT(e.employee_last_name, ' ', e.employee_first_name)
        AS employee_name,

    s.shipper_company AS shipper_name,
    os.status_name AS order_status_name,

    -- Converssion des dates_id en dates lisibles
    PARSE_DATE('%Y%m%d', CAST(od.order_date_id AS STRING))   AS order_date,
    PARSE_DATE('%Y%m%d', CAST(od.shipped_date_id AS STRING)) AS shipped_date,

    -- extraire les Mesures à partir de la table des faits
    od.quantity,
    od.unit_price,
    od.discount,

    -- KPI : chiffre d’affaires (revenue)
    (od.unit_price * od.quantity * (1 - od.discount))
        + od.shipping_fee
        + od.taxes AS revenue

from order_details od
left join {{ ref('dim_products') }} p
    on od.product_id = p.product_id
left join {{ ref('dim_customers') }} c
    on od.customer_id = c.customer_id
left join {{ ref('dim_employees') }} e
    on od.employee_id = e.employee_id
left join {{ ref('dim_shippers') }} s
    on od.shipper_id = s.shipper_id
left join {{ ref('dim_order_status') }} os
    on od.orders_status_id = os.orders_status_id
