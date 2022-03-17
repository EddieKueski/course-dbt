{{
  config(
    materialized='table'
  )
}}

SELECT
    order_id
    , delivered_at - estimated_delivery_at AS delivery_delay_days
    , status
    , shipping_service
    , user_id

FROM {{ref('stg_postgre_orders')}}

WHERE delivered_at > estimated_delivery_at