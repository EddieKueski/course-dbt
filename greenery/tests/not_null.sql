{% test null_test(model, column_name) %}


   select *
   from {{ model }}
   where {{ column_name }} IS NULL


{% endtest %}