with po_details as (
    select
        pod.purchase_order_id,
        pod.product_id,
        pod.posted_to_inventory,
        pod.quantity,
        pod.unit_cost,

        po.supplier_id,
        po.created_by_employee_id,
        po.purchase_order_status_id,

        po.creation_date_id,
        po.submitted_date_id,
        po.approved_date_id

    from {{ ref('fact_purchase_order_details') }} pod
    join {{ ref('fact_purchase_orders') }} po
        on pod.purchase_order_id = po.purchase_order_id
)

select
    -- les noms des produits ,fournisseurs et des employés 
    p.product_name,
    s.supplier_company,
    CONCAT(e.employee_first_name, ' ', e.employee_last_name) AS created_by_employee_name,
    pos.status AS purchase_order_status_name,

    --convertir les dates au format DATE
    PARSE_DATE('%Y%m%d', CAST(po.creation_date_id AS STRING))  AS creation_date,
    PARSE_DATE('%Y%m%d', CAST(po.submitted_date_id AS STRING)) AS submitted_date,
    PARSE_DATE('%Y%m%d', CAST(po.approved_date_id AS STRING))  AS approved_date,

    -- KPI
    SUM(quantity) AS total_quantity,
    SUM(quantity * unit_cost) AS total_purchase_amount,

    SAFE_DIVIDE(
        SUM(CASE WHEN posted_to_inventory = 0 THEN quantity ELSE 0 END),
        SUM(quantity)
    ) * 100 AS taux_rupture_stock

from po_details po
join {{ ref('dim_products') }} p
    on po.product_id = p.product_id
left join {{ ref('dim_suppliers') }} s
    on po.supplier_id = s.supplier_id
left join {{ ref('dim_employees') }} e
    on po.created_by_employee_id = e.employee_id
left join {{ ref('dim_purchase_order_status') }} pos
    on po.purchase_order_status_id = pos.purchase_order_status_id

group by
    p.product_name,
    s.supplier_company,
    created_by_employee_name,
    purchase_order_status_name,
    creation_date,
    submitted_date,
    approved_date
