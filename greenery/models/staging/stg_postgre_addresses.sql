{{
  config(
    materialized='table'
  )
}}

WITH addresses AS(
SELECT *

FROM {{ source('postgre_source', 'addresses') }}
)

SELECT 
    address_id,
    address,
    CAST (zipcode as VARCHAR) AS zipcode,
    state,
    country
    
FROM addresses