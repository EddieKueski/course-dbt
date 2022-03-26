# Week 3
## Eddie Almada

## Part I
### What is our overall conversion rate?
```
WITH checkout AS (
  SELECT 
  COUNT(DISTINCT session_id) AS checkout_sessions
  FROM dbt_eduardo_a.stg_postgre_events 
  WHERE event_type IN ('checkout')
),

total AS(
  SELECT COUNT(DISTINCT session_id) as total_sessions
  FROM dbt_eduardo_a.stg_postgre_events 
)

SELECT 
ROUND(a.checkout_sessions / b.total_sessions :: numeric * 100,2)
FROM checkout a , total b
```
> 62.46%
### What is our conversion rate by product?
```
WITH checkout AS (
  SELECT 
  session_id,
  MAX(product_id) As product_id
  FROM dbt_eduardo_a.stg_postgre_events 
  LEFT JOIN dbt_eduardo_a.stg_postgre_products USING (product_id)
  WHERE event_type = 'add_to_cart'
  GROUP BY session_id
),

total AS (
  SELECT 
  session_id,
  MAX(product_id) As product_id
  FROM dbt_eduardo_a.stg_postgre_events 
  WHERE product_id IS NOT NULL
  GROUP BY session_id
)

SELECT 
a.product_id,
ROUND(COUNT(DISTINCT a.session_id) / COUNT(DISTINCT b.session_id) :: NUMERIC * 100, 2)
FROM checkout a , total b
GROUP BY a.product_id
```
| product_id                           | rate |
|--------------------------------------|------|
| 05df0866-1a66-41d8-9ed7-e2bbcddd6a3d | 1.04 |
| 35550082-a52d-4301-8f06-05b30f6f3616 | 0.35 |
| 37e0062f-bd15-4c3e-b272-558a86d90598 | 0.69 |
| 4cda01b9-62e2-46c5-830f-b7f262a58fb1 | 1.21 |
| 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 | 1.21 |
| 579f4cd0-1f45-49d2-af55-9ab2b72c3b35 | 1.21 |
| 58b575f2-2192-4a53-9d21-df9a0c14fc25 | 1.73 |
| 5b50b820-1d0a-4231-9422-75e7f6b0cecf | 0.87 |
| 5ceddd13-cf00-481f-9285-8340ab95d06d | 1.73 |
| 615695d3-8ffd-4850-bcf7-944cf6d3685b | 2.25 |
| 64d39754-03e4-4fa0-b1ea-5f4293315f67 | 1.38 |
| 689fb64e-a4a2-45c5-b9f2-480c2155624d | 3.11 |
| 6f3a3072-a24d-4d11-9cef-25b0b5f8a4af | 2.25 |
| 74aeb414-e3dd-4e8a-beef-0fa45225214d | 2.60 |
| 80eda933-749d-4fc6-91d5-613d29eb126f | 1.73 |
| 843b6553-dc6a-4fc4-bceb-02cd39af0168 | 2.42 |
| a88a23ef-679c-4743-b151-dc7722040d8c | 2.08 |
| b66a7143-c18a-43bb-b5dc-06bb5d1d3160 | 3.29 |
| b86ae24b-6f59-47e8-8adc-b17d88cbd367 | 3.81 |
| bb19d194-e1bd-4358-819e-cd1f1b401c0c | 3.46 |
| be49171b-9f72-4fc9-bf7a-9a52e259836b | 2.60 |
| c17e63f7-0d28-4a95-8248-b01ea354840e | 2.25 |
| c7050c3b-a898-424d-8d98-ab0aaad7bef4 | 4.15 |
| d3e228db-8ca5-42ad-bb0a-2148e876cc59 | 2.60 |
| e18f33a6-b89a-4fbc-82ad-ccba5bb261cc | 3.63 |
| e2e78dfc-f25c-4fec-a002-8e280d61a2f2 | 4.50 |
| e5ee99b6-519f-4218-8b41-62f48f59f700 | 5.36 |
| e706ab70-b396-4d30-a6b2-a1ccf3625b52 | 4.33 |
| e8b6528e-a830-4d03-a027-473b411c7f02 | 5.36 |
| fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 | 7.61 |

## Part II
Create a macro to simplify part of a model(s).

## Part III
Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting 

## Part IV
Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

## Part V 
DAG