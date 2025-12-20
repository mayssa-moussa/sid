select
    -- extraire les noms des produits et les types de transactions
    p.product_name,
    itt.inventory_transaction_type_name,

    --convertir les dates_id au format date
    PARSE_DATE('%Y%m%d', CAST(fit.created_date_id AS STRING))  AS created_date,
    PARSE_DATE('%Y%m%d', CAST(fit.modified_date_id AS STRING)) AS modified_date,

    -- KPI Inventaire
    COUNT(*) AS total_transactions,
    SUM(fit.quantity) AS transaction_volume

from {{ ref('fact_inventory_transactions') }} fit
left join {{ ref('dim_products') }} p
    on fit.product_id = p.product_id
left join {{ ref('dim_inventory_transaction_types') }} itt
    on fit.inventory_transaction_type_id = itt.inventory_transaction_type_id

group by
    p.product_name,
    itt.inventory_transaction_type_name,
    created_date,
    modified_date
