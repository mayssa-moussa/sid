select
    -- extraires les noms des clients ,des employés et des produits à partir de leurs dimensions
    CONCAT(e.employee_last_name, ' ', e.employee_first_name) 
        AS employee_name,

    os.status_name AS status_name,
    ods.status AS status,

    -- converssion des dates_id en dates lisibles
    PARSE_DATE('%Y%m%d', CAST(fo.order_date_id AS STRING))   AS order_date,
    PARSE_DATE('%Y%m%d', CAST(fo.shipped_date_id AS STRING)) AS shipped_date,

    -- KPI
    DATE_DIFF(
        PARSE_DATE('%Y%m%d', CAST(fo.shipped_date_id AS STRING)),
        PARSE_DATE('%Y%m%d', CAST(fo.order_date_id AS STRING)),
        DAY
    ) AS processing_time_days

from {{ ref('fact_orders') }} fo
join {{ ref('fact_order_details') }} fod
    on fo.order_id = fod.order_id

left join {{ ref('dim_employees') }} e
    on fo.employee_id = e.employee_id
left join {{ ref('dim_order_status') }} os
    on fo.orders_status_id = os.orders_status_id
left join {{ ref('dim_order_details_status') }} ods
    on fod.order_details_status_id = ods.order_details_status_id
