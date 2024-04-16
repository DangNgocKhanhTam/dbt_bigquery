with dim_buying_group__source as (
    SELECT *
    FROM `wide_world_importers.sales__buying_groups`
)
, dim_buying_group__rename_column as (
    select 
    buying_group_id as buying_group_key,
    buying_group_name
    from dim_buying_group__source
), dim_buying_group__cast_type as (
    select 
    CAST(buying_group_key as integer) buying_group_key, 
    CAST(buying_group_name as string ) buying_group_name
    from dim_buying_group__rename_column
), dim_buying_group__add_undefined_record as (
    SELECT
    buying_group_key,
    buying_group_name
    FROM dim_buying_group__cast_type
    UNION ALL
    SELECT
    0 as buying_group_key,
    'Undefined' buying_group_name
    UNION ALL
    SELECT
    -1 as buying_group_key,
    'Invalid' buying_group_name
)
select 
    buying_group_key, 
    buying_group_name
from dim_buying_group__add_undefined_record