{{
  config(
    materialized='table'
  )
}}

WITH products AS(
SELECT *

FROM {{ source('postgre_source', 'products') }}
)

SELECT 
    product_id,
    name,
    price,
    inventory

FROM products