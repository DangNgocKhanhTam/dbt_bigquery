with fact_sales_order_line__source as (
  select * 
  from `vit-lam-data.wide_world_importers.sales__order_lines`
)
, fact_sales_order_line__rename_column as (
  select 
  order_line_id as sales_order_line_key, 
  stock_item_id as product_key,
  quantity,
  unit_price
  from fact_sales_order_line__source
)
SELECT 
  cast(sales_order_line_key as integer)  as sales_order_line_key, 
  cast(product_key as integer) as product_key,
  cast(quantity as integer) as quantity, 
  cast(unit_price as numeric) as unit_price , 
  cast(quantity as integer) * cast(unit_price as numeric) as gross_amount
FROM fact_sales_order_line__rename_column