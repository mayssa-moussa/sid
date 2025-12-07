select
    employee_id,
    privilege_id
from {{ ref('stg_employee_privileges') }}
