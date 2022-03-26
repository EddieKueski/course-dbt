{{
  config(
    materialized='table'
  )
}}

SELECT
    DISTINCT user
    , delivery_delay_days
    , int_usa_addresses.zipcode
    , shipping_service



FROM {{ref('dim_users')}}
LEFT JOIN {{ref('int_late_orders')}} USING (user_id)
LEFT JOIN {{ref('int_usa_addresses')}} USING (address_id)

WHERE delivery_delay_days IS NOT NULL