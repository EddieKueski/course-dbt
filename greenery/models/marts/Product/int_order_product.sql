
{{
    config(
        materialized = 'table'
    )
}}

SELECT
    order_id,
    product_id,
    user_id,
    created_at as ordered_at,
    dim_product.price,
    dim_product.product_name,
    quantity

FROM {{ref('fct_orders')}}
LEFT JOIN {{ref('fct_order_items')}} USING(order_id)
LEFT JOIN {{ref('dim_product')}} USING(product_id)