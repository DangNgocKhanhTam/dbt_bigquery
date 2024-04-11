with dim_customer_category__source as (
    SELECT *
    FROM `vit-lam-data.wide_world_importers.sales__customer_categories`
)
, dim_customer_category__rename_column as (
    select 
    customer_category_id as customer_category_key,
    customer_category_name
    from dim_customer_category__source
), dim_customer_category__cast_type as (
    select 
    CAST(customer_category_key as integer) customer_category_key, 
    CAST(customer_category_name as string ) customer_category_name
    from dim_customer_category__rename_column
), dim_customer_category__add_undefined_record as (
    SELECT
    customer_category_key,
    customer_category_name
    FROM dim_customer_category__cast_type
    UNION ALL
    SELECT
    0 as customer_category_key,
    'Undefined' customer_category_name
    UNION ALL
    SELECT
    -1 as customer_category_key,
    'Invalid' customer_category_name
)
select 
    customer_category_key, 
    customer_category_name
from dim_customer_category__add_undefined_record