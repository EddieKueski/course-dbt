{{
  config(
    materialized='table'
  )
}}

SELECT
    promo_id
    , discount 
    , promo_status


FROM {{ref('fct_promos')}}

WHERE promo_status = 'active'