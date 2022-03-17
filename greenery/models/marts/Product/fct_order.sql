{{
  config(
    materialized='table'
  )
}}

SELECT
    user_id
    , COUNT( DISTINCT order_id) AS num_orders
    , MIN(created_at) AS first_order_date
    , MAX(created_at) AS last_activity_date
    , SUM(order_cost) AS order_cost
    , SUM(shipping_cost) AS shipping_cost
    , SUM(order_total) AS total_amount_per_user

FROM {{ref('stg_postgre_orders')}}

GROUP BY user_id