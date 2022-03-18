# Week 2
## Eddie Almada

### What is our user repeat rate?
    ```
        WITH temp_table AS (
        SELECT
        COUNT(DISTINCT order_id) AS orders_per_user,
        user_id
        FROM dbt_eduardo_a.stg_postgre_orders
        GROUP BY (user_id)
    ),
    
    two_purchases AS (
      SELECT 
      orders_per_user,
      COUNT(DISTINCT user_id) AS n_users
      FROM temp_table
      WHERE orders_per_user > 1
      GROUP BY orders_per_user
    )
    
    SELECT 
    ROUND((SELECT SUM(n_users) FROM two_purchases)
    /
    COUNT(DISTINCT user_id),4) AS repeat_rate
    
    FROM temp_table

    ```

    > 0.7984

### What are good indicators of a user who will likely purchase again? 
 
    > User's event frequency 
    > Number of past purchases

### What about indicators of users who are likely NOT to purchase again? 
 
    > Promos inactive (promo hunter user's)
    > Shipping delays

### If you had more data, what features would you want to look into to answer this question?
 
    > Electronic device used to place the order (ej, PC, mobile)
    > Payment Method
    > User's gender

### What assumptions are you making about each model? (i.e. why are you adding each test?)
    > Marts 
        - Core
            - Two dimension tables for basic information about the users and products
            - One intermidate table with USA only addresses
        - Mkt
            - One dimension table with all the users whom recieved their product with at least one day of delay
            - One fact table with the orders that used a promo effectively
            - Two intermidate tables to build the tables above
        - Product
            - Two fct tables with basic information about the events and orders 
            
   ![alt text](https://github.com/EddieKueski/course-dbt/blob/main/greenery/W2_DAG.png)   

    >  Within the schema.yml from the staging directory, I added almost a test per table. 
        - stg_postgre_users
            - Checking for user_id duplicity
            - Every row should containg a user_id
        - stg_postgre_addresses
            - Testing all zipcodes for a lenght of 5 characters or nulls
                - Single test within the test directory
        - stg_postgre_events
            - Every row should have an event_id
        - stg_postgre_order_items
            - Every row should a product_id
        - stg_postgre_orders
            - Status can only take a values from this list 
            ```['shipped', 'preparing', 'delivered']```
        - stg_postgre_promos
            - Discount should be positive

### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
    > I did not find any bad data, however I had to cast the zipcode as a Varchart since the staging phase as
    I wanted to create a single test to verify if every zipcode contained only 5 digits.
    
