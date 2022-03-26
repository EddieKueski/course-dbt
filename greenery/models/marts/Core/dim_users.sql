{{
  config(
    materialized = 'table'
  )
}}

SELECT 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at as registered_at,
    address,
    address_id,
    zipcode,
    state,
    country
FROM {{ref('stg_postgre_users')}}
LEFT JOIN {{ref('stg_postgre_addresses')}} USING(address_id)