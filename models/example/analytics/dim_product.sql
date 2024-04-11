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
    is_chiller_stock as is_chiller_stock_boolean,
    supplier_id as supplier_key 
  FROM
    dim_product__source ),
  dim_product_cast_type AS (
  SELECT
    CAST(product_key AS integer) AS product_key,
    CAST(product_name AS string) AS product_name,
    CAST(brand_name AS string) AS brand_name, 
    CAST(is_chiller_stock_boolean as boolean) as is_chiller_stock_boolean,
    CAST(supplier_key as integer) as supplier_key
  FROM
    dim_product__rename_column ),
 dim_product__convert_boolean as (
    SELECT
    *,
    CASE WHEN is_chiller_stock_boolean is True THEN "Chiller Stock" 
         WHEN is_chiller_stock_boolean is False THEN "Not Chiller Stock" 
         WHEN is_chiller_stock_boolean is NULL THEN "Unfined"
         ELSE 'Invalid' end is_chiller_stock, 
    FROM dim_product_cast_type
    )
SELECT
  dim_product.product_key,
  dim_product.product_name,
  coalesce(dim_product.brand_name,"Undefined")  brand_name, 
  dim_product.is_chiller_stock,
  dim_product.supplier_key, 
  coalesce(dim_supplier.supplier_name, 'Undefined') supplier_name
FROM  dim_product__convert_boolean as dim_product
LEFT JOIN {{ref('dim_supplier')}} as dim_supplier
ON dim_product.supplier_key = dim_supplier.supplier_key