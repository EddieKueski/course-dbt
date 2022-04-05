# Aswers to week4 questions

## Part 1. dbt Snapshots

#### Were you able to add snapshots against the orders data? Did you see any data change?

Some order_id's changed in their status


code:
```` sql
{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='check',
      check_cols=['status'],
    )
  }}

  SELECT * FROM {{ source('postgre_source','orders') }}

{% endsnapshot %}

````

## Part 2. Modeling challenge

#### How are our users moving through the product funnel?

| level_1        | level_2        | level_3        | fall_level_1_2      | fall_level_2_3      |
|----------------|----------------|----------------|---------------------|---------------------|
| 578            | 467            | 361            | 19.20               | 22.70               |

#### Which steps in the funnel have largest drop off points?
- From funnel step 2 to funnel step 3

Models created:
- int_funnel

## Part 3. Reflection questions -- please answer 3A or 3B, or both!

### 3A. dbt next steps for you 
**Reflecting on your learning in this class...**

**How would you pitch the value of dbt/analytics engineering to a decision maker at your organization?**
- Explaning how by changing from ETL to ELT and also using dbt to transform the data we can feed our BI tools more efficiently.

**What skills have you picked that give you the most confidence in pursuing this next step?**
- Using git for colaborating, and dbt in order to improve the governance of the models