{{
  config(
    materialized='table'
  )
}}

SELECT 
user_id,
first_name || ' ' || last_name AS full_name,
created_at,
phone_number,
email,
address_id


FROM {{ref('stg_postgre_users')}}