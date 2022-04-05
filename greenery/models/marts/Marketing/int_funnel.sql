{{
    config(
        materialized = 'table'
    )
}}

WITH temp as (
SELECT 
created_at,
COUNT(DISTINCT(CASE WHEN has_page_view OR has_add_to_cart OR has_page_view THEN session_id END)) AS funnel_1,
COUNT(DISTINCT(CASE WHEN has_add_to_cart OR has_checkout THEN session_id END)) AS funnel_2,
COUNT(DISTINCT(CASE WHEN has_checkout THEN session_id END)) AS funnel_3,
(COUNT(DISTINCT(CASE WHEN has_page_view OR has_add_to_cart OR has_page_view THEN session_id END)) -
    COUNT(DISTINCT(CASE WHEN has_add_to_cart OR has_checkout THEN session_id END))) * 100.0 / 
COUNT(DISTINCT(CASE WHEN has_page_view OR has_add_to_cart OR has_page_view THEN session_id END)) AS fall_level_1_2,
(COUNT(DISTINCT(CASE WHEN has_add_to_cart OR has_checkout THEN session_id END))-
    COUNT(DISTINCT(CASE WHEN has_checkout THEN session_id END))) * 100.0 /
COUNT(DISTINCT(CASE WHEN has_add_to_cart OR has_checkout THEN session_id END)) AS fall_level_2_3


FROM {{ref('fct_event')}}
GROUP BY created_at
)

SELECT
*
FROM temp