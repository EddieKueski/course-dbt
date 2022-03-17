{{
  config(
    materialized='table'
  )
}}

WITH order_items AS(
SELECT *

FROM {{ source('postgre_source', 'order_items') }}
)

SELECT 
    order_id,
    product_id,
    quantity

FROM order_items