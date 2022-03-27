{{
    config(
        materialized = 'table'
    )
}}


SELECT
    {{ dbt_utils.star(from=ref('stg_postgre_products'), except=['name'] ) }},
    name as product_name
FROM {{ref('stg_postgre_products')}}