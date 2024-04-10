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
    customer_category_id as customer_category_key, 
    buying_group_id as buying_group_key
  FROM
    dim_customer__source ),
  dim_customer__cast_type AS (
  SELECT
    CAST(customer_key AS integer) AS customer_key,
    CAST(customer_name AS string) AS customer_name, 
    CAST(customer_category_key as integer) as customer_category_key, 
    CAST(buying_group_key as integer) as buying_group_key
  FROM
    dim_customer__rename_column )
SELECT
  customer_key,
  customer_name, 
  customer_category_key, 
  buying_group_key
FROM
  dim_customer__cast_type