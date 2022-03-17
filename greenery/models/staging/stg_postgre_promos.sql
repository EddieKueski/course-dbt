{{
  config(
    materialized='table'
  )
}}

WITH promos AS(
SELECT *

FROM {{ source('postgre_source', 'promos') }}
)

SELECT 
    promo_id,
    discount,
    status

FROM promos