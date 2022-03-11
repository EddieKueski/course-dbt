# Week 1
## Eddie Almada

### How many users do we have?
    ```
    SELECT
    COUNT(DISTINCT user_id) AS users
    FROM dbt_eduardo_a.stg_users
    LIMIT 1
    ```

    130 users

### On average, how many orders do we receive per hour?
    ```
    WITH order_hour AS(
    SELECT
    created_at_hour,
    COUNT(DISTINCT order_id) AS total_orders
    FROM dbt_eduardo_a.stg_orders
    GROUP BY created_at_hour
    )
    SELECT 
    ROUND(AVG(total_orders),2) AS avg_orders
    FROM order_hour
    LIMIT 10
    ```

    7.52 orders/hour ~ 8 orders/hour

### On average, how long does an order take from being placed to being delivered?
    ```
    SELECT 
    AVG(delivered_at - created_at) AS avg_time
    FROM dbt_eduardo_a.stg_orders
    WHERE status = 'delivered'
    LIMIT 10
    ```

    3 days 21:24:11.803279

### How many users have only made one purchase? Two purchases? Three+ purchases?
    ```
    WITH temp_table AS (
        SELECT
        COUNT(DISTINCT order_id) AS orders_per_user,
        user_id
        FROM dbt_eduardo_a.stg_orders
        GROUP BY (user_id)
    )
    SELECT 
    orders_per_user,
    COUNT(DISTINCT user_id) AS n_users
    FROM temp_table
    GROUP BY orders_per_user
    ORDER BY orders_per_user ASC
    ```

    | orders_per_user | total_users |
    |-----------------|-------------|
    | 1               | 25          |
    | 2               | 28          |
    | 3               | 34          |
    | 4               | 20          |
    | 5               | 10          |
    | 6               | 2           |
    | 7               | 4           |
    | 8               | 1           |

### On average, how many unique sessions do we have per hour?
    ```
    WITH session_hour AS (
        SELECT
        created_at_hour,
        COUNT(DISTINCT session_id) AS n_sessions
        FROM dbt_eduardo_a.stg_events
        GROUP BY (created_at_hour)
    )
    SELECT 
    ROUND(AVG(n_sessions),2) AS avg_sessions
    FROM session_hour
    ```
    
    16.33  sessions/hour ~ 17 sessions/hour