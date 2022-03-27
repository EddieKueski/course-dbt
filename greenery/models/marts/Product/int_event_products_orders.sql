
{{
    config(
        materialized = 'table'
    )
}}

SELECT
    session_id,
    order_id,
    event_type,
    COALESCE(eve.product_id,ord.product_id) as product_id,
    prod.product_name

FROM {{ref('stg_postgre_events')}} eve
LEFT JOIN {{ref('int_order_product')}} ord using(order_id)
LEFT JOIN {{ref('dim_product')}} prod on COALESCE(eve.product_id, ord.product_id) = prod.product_id