select
    inventory_transaction_id,
    inventory_transaction_type_id,

    -- Date keys
    --Convertir les dates en date_id en format int AAAAMMJJ, ce qui permet de créer des relations avec Dim_Date
    {{ to_date_id('transaction_created_date ') }} as transaction_created_date_id ,
    {{ to_date_id('transaction_modified_date ') }} as transaction_modified_date_id,
    

    product_id,
    quantity
    
   
    

from {{ ref('stg_inventory_transactions') }}
