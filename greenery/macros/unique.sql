{% test unique(model, column_name) %}

    SELECT 
    {{ column_name }}
    , count(*)
    FROM {{ model }}
    GROUP BY 1
    HAVING count(*) > 1

{% endtest %}