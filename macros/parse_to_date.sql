{% macro parse_to_date(column_name, format) %}
    parse_date('{{ format }}', cast({{ column_name }} as string))
{% endmacro %}
