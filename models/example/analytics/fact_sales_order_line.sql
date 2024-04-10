WITH
  fact_sales_order_line__source AS (
  SELECT
    *
  FROM
    `vit-lam-data.wide_world_importers.sales__order_lines` ),
  fact_sales_order_line__rename_column AS (
  SELECT
    order_line_id AS sales_order_line_key,
    order_id AS sales_order_key,
    stock_item_id AS product_key,
    quantity,
    unit_price
  FROM
    fact_sales_order_line__source ),
  fact_sales_order_line__cast_type AS (
  SELECT
    CAST(sales_order_line_key AS integer) AS sales_order_line_key,
    CAST(sales_order_key AS integer) AS sales_order_key,
    CAST(product_key AS integer) AS product_key,
    CAST(quantity AS integer) AS quantity,
    CAST(unit_price AS numeric) AS unit_price,
    CAST(quantity AS integer) * CAST(unit_price AS numeric) AS gross_amount
  FROM
    fact_sales_order_line__rename_column )
SELECT
  sales_order_line_key,
  sales_order_key,
  product_key,
  quantity,
  unit_price,
  gross_amount
FROM
  fact_sales_order_line__cast_type