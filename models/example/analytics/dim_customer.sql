WITH
  dim_customer__source AS (
  SELECT
    *
  FROM
    `vit-lam-data.wide_world_importers.sales__customers` ),
  dim_customer__rename_column AS (
  SELECT
    customer_id AS customer_key,
    customer_name, 
    is_on_credit_hold as is_on_credit_hold_boolean,
    customer_category_id as customer_category_key, 
    buying_group_id as buying_group_key
  FROM
    dim_customer__source ),
  dim_customer__cast_type AS (
  SELECT
    CAST(customer_key AS integer) AS customer_key,
    CAST(customer_name AS string) AS customer_name, 
    CAST(is_on_credit_hold_boolean as boolean) is_on_credit_hold_boolean,
    CAST(customer_category_key as integer) as customer_category_key, 
    CAST(buying_group_key as integer) as buying_group_key
  FROM
    dim_customer__rename_column 
  ),  dim_customer__convert_booolean as (
    select 
    *, 
    CASE WHEN is_on_credit_hold_boolean is TRUE THEN 'On Creadit Hold' 
         WHEN is_on_credit_hold_boolean is FALSE THEN 'Not On Creadit Hold'
         WHEN is_on_credit_hold_boolean is NULL THEN 'Undefined'
         ELSE 'Invalid' END is_on_credit_hold
    from dim_customer__cast_type
  ), dim_customer__add_undefined_record as (
    SELECT
    customer_key,
    customer_name,
    is_on_credit_hold,
    customer_category_key,
    buying_group_key
    FROM dim_customer__convert_booolean
    UNION ALL
    SELECT
    0 as customer_key,
    'Undefined' as customer_name,
    'Undefined' as is_on_credit_hold,
    0 as customer_category_key,
    0 as buying_group_key
    UNION ALL 
   SELECT
    -1 as customer_key,
    'Invalid' as customer_name,
    'Invalid' as is_on_credit_hold,
    -1 as customer_category_key,
    -1 as buying_group_key
  )
SELECT
  dim_customer.customer_key,
  dim_customer.customer_name, 
  dim_customer.customer_category_key, 
  dim_customer_category.customer_category_name,
  dim_customer.buying_group_key, 
  dim_customer.is_on_credit_hold,
  dim_buying_group.buying_group_name
FROM   dim_customer__add_undefined_record dim_customer
LEFT JOIN {{ ref ('stg_dim_customer_category') }} as dim_customer_category 
ON dim_customer.customer_category_key = dim_customer_category.customer_category_key
LEFT JOIN {{ ref ('stg_dim_buying_group') }} as dim_buying_group
ON dim_buying_group.buying_group_key = dim_customer.buying_group_key