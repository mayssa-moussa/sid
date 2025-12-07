select
    shipper_id,
    shipper_company,
    shipper_address,
    shipper_city,
    shipper_state_province,
    shipper_zip_postal_code,
    shipper_country_region
from {{ ref('stg_shippers') }}
