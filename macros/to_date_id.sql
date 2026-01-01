{% macro to_date_id(date_col) %}
    cast(format_date('%Y%m%d', cast({{ date_col }} as date)) as int64)
{% endmacro %}