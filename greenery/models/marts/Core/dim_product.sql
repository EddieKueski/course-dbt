{{
    config(
        materialized = 'table'
    )
}}


SELECT
    product_id,
    name as product_name,
    price,
    inventory

FROM {{ref('stg_postgre_products')}}