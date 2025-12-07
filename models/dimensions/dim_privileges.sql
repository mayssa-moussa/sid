select
    privilege_id,
    privilege_name
from {{ ref('stg_privileges') }}
