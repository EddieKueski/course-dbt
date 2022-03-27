
   
{{
    config(
        materialized = 'table'
    )
}}

SELECT
    {{ dbt_utils.star(from=ref('stg_postgre_promos'), except=["status"] )}},
    status as promo_status
FROM {{ref('stg_postgre_promos')}}