WITH
  dim_product__source AS (
  SELECT
    *
  FROM
    `vit-lam-data.wide_world_importers.warehouse__stock_items` ),
  dim_product__rename_column AS (
  SELECT
    stock_item_id AS product_key,
    stock_item_name AS product_name,
    brand AS brand_name,
    supplier_id as supplier_key 
  FROM
    dim_product__source ),
  dim_product_cast_type AS (
  SELECT
    CAST(product_key AS integer) AS product_key,
    CAST(product_name AS string) AS product_name,
    CAST(brand_name AS string) AS brand_name, 
    CAST(supplier_key as integer) as supplier_key
  FROM
    dim_product__rename_column )
SELECT
  dim_product.product_key,
  dim_product.product_name,
  dim_product.brand_name, 
  dim_product.supplier_key, 
  dim_supplier.supplier_name
FROM  dim_product_cast_type as dim_product
LEFT JOIN {{ref('dim_supplier')}} as dim_supplier
ON dim_product.supplier_key = dim_supplier.supplier_key