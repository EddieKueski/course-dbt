{{
  config(
    materialized = 'table'
  )
}}

SELECT 
    {{ dbt_utils.star(from=ref('stg_postgre_users'), except=["created_at", "updated_at", "address_id"]) }},
    created_at as registered_at,
    {{ dbt_utils.star(from=ref('stg_postgre_addresses')) }}

FROM {{ref('stg_postgre_users')}}
LEFT JOIN {{ref('stg_postgre_addresses')}} USING(address_id)