# Week 3
## Eddie Almada

## Part I
### What is our overall conversion rate?
```` sql
WITH checkout AS (
  SELECT 
  COUNT(DISTINCT session_id) AS checkout_sessions
  FROM dbt_eduardo_a.stg_postgre_events 
  WHERE event_type IN ('checkout')
),

total AS(
  SELECT COUNT(DISTINCT session_id) as total_sessions
  FROM dbt_eduardo_a.stg_postgre_events 
)

SELECT 
ROUND(a.checkout_sessions / b.total_sessions :: numeric * 100,2)
FROM checkout a , total b
````
> 62.46%
### What is our conversion rate by product?
```` sql
SELECT
product_name,
ROUND(
  COUNT(DISTINCT(CASE WHEN event_type = 'checkout' THEN session_id END)) * 1.0 /
  COUNT(DISTINCT(session_id)) * 100, 2) as conversion_rate
FROM dbt_eduardo_a.int_event_products_orders
GROUP BY product_name
ORDER BY 2 DESC
````

| product_name        | con_rate |
|---------------------|----------|
| String of pearls    | 60.94    |
| Arrow Head          | 55.56    |
| Cactus              | 54.55    |
| ZZ Plant            | 53.97    |
| Bamboo              | 53.73    |
| Rubber Plant        | 51.85    |
| Monstera            | 51.02    |
| Calathea Makoyana   | 50.94    |
| Fiddle Leaf Fig     | 50.00    |
| Majesty Palm        | 49.25    |
| Aloe Vera           | 49.23    |
| Devil's Ivy         | 48.89    |
| Philodendron        | 48.39    |
| Jade Plant          | 47.83    |
| Spider Plant        | 47.46    |
| Pilea Peperomioides | 47.46    |
| Dragon Tree         | 46.77    |
| Money Tree          | 46.43    |
| Orchid              | 45.33    |
| Bird of Paradise    | 45.00    |
| Ficus               | 42.65    |
| Birds Nest Fern     | 42.31    |
| Pink Anthurium      | 41.89    |
| Boston Fern         | 41.27    |
| Alocasia Polly      | 41.18    |
| Peace Lily          | 40.91    |
| Ponytail Palm       | 40.00    |
| Snake Plant         | 39.73    |
| Angel Wings Begonia | 39.34    |
| Pothos              | 34.43    |

## Part II
### Create a macro to simplify part of a model(s).

Two macros created #ratio# and #get_distinct_values#
#### Ratio
```` sql
{% macro ratio(column_name, column_name) %}

    ROUND((({{ column_name }} / {{ column_name }}) :: numeric) * 100 , 2)

{% endmacro %}
````
#### get_distinct_values
```` sql

{% macro get_distinct_values(model, column_name) %}

  {% set distinct_query %}
  select distinct
  {{column_name}}
  from {{model}}
  order by 1
  {% endset %}

{% set results = run_query(distinct_query) %}

  {% if execute %}
  {# Return the first column #}
  {% set results_list = results.columns[0].values() %}
  {% else %}
  {% set results_list = [] %}
  {% endif %}

{{ return(results_list) }}

{% endmacro %}
````

## Part III
### Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting 

Complete √
## Part IV
### Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

```` sql
packages:
  - package: dbt-labs/dbt_utils
    version: 0.8.2
  - package: MaterializeInc/materialize_dbt_utils
    version: 0.3.0
````

Used the ##star## function from dbt.util in in multiple dim_tables
Ej.
```` sql
SELECT
    {{ dbt_utils.star(from=ref('stg_postgre_promos'), except=["status"] )}},
    status as promo_status
FROM {{ref('stg_postgre_promos')}}
````
## Part V 
#### DAG

![DAG_W3](https://github.com/EddieKueski/course-dbt/blob/main/greenery/dbt-dag.png)
