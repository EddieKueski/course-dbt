{{
  config(
    materialized='table'
  )
}}

SELECT 
address_id
, state
, country
, zipcode

FROM {{ref('stg_postgre_addresses')}}

WHERE state in ('United States')