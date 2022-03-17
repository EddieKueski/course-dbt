{{
  config(
    materialized='table'
  )
}}

SELECT
    user_id
    , COUNT( DISTINCT session_id) AS num_sessions
    , COUNT( DISTINCT order_id) AS num_orders
    , MAX(created_at) AS lastest_event_date
    , MAX(page_url) AS lastest_page_url
    , MAX(event_type) AS lastest_event


FROM {{ref('stg_postgre_events')}}

GROUP BY user_id