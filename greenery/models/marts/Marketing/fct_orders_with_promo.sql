{{
  config(
    materialized='table'
  )
}}

SELECT
    order_id
    , promo_id
    , order_cost + shipping_cost AS gross_amount
    , order_total As net_amount



FROM {{ref('stg_postgre_orders')}}
LEFT JOIN {{ref('int_active_promos')}} USING (promo_id)
