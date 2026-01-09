select
    customer_id,
    company_name,
    last_name,
    first_name,
    job_title,
    business_phone,
    fax_number,
    address,
    city,
    state_province,
    zip_postal_code,
    country_region
from {{ ref('stg_customer') }}
