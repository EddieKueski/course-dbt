{{
    config(
        materialized = 'table'
    )
}}

SELECT
    order_id,
    product_id,
    quantity
FROM {{ref('stg_postgre_order_items')}}