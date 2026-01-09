with source as (
    select * from {{ ref('inventory_transactions') }}
),
renamed as (
    select
        id as inventory_transaction_id,
        transaction_type as inventory_transaction_type_id,
        --Convertir une date stockée sous forme de texte  en un vrai type DATE dans BigQuery.
        {{ parse_datetime_to_date('transaction_created_date') }} as transaction_created_date,
        {{ parse_datetime_to_date('transaction_modified_date') }} as transaction_modified_date,
        product_id,
        quantity,
        comments
    from source
)
select * from renamed
