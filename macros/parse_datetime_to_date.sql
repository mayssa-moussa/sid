{% macro parse_datetime_to_date(column_name, format='%m/%d/%Y %H:%M:%S') %}
    cast(
        parse_datetime(
            '{{ format }}',
            cast({{ column_name }} as string)
        ) as date
    )
{% endmacro %}

