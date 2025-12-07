select
    supplier_id,
    supplier_company,
    supplier_last_name,
    supplier_first_name,
    supplier_email,
    supplier_job_title
from {{ ref('stg_suppliers') }}
