{{
  config(
    materialized='table'
  )
}}

SELECT 
product_id,
price 


FROM {{ref('stg_postgre_products')}}