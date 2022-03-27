{% macro ratio(column_name, column_name) %}

    ROUND((({{ column_name }} / {{ column_name }}) :: numeric) * 100 , 2)

{% endmacro %}