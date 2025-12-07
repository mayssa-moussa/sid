select
    employee_id,
    company_name,
    employee_last_name,
    employee_first_name,
    employee_email,
    employee_job_title,
    business_phone,
    fax_number,
    address,
    city,
    state_province,
    zip_postal_code,
    country_region,
   
from {{ ref('stg_employees') }}
