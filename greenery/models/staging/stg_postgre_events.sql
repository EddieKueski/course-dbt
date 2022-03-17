{{
  config(
    materialized='table'
  )
}}

WITH events AS(
SELECT *

FROM {{ source('postgre_source', 'events') }}
)

SELECT 
   event_id,
   session_id,
   user_id,
   event_type,
   page_url,
   created_at,
   date_trunc('hour', created_at) as created_at_hour,
   order_id,
   product_id

FROM events