WITH
  dim_suppliers__source AS (
  SELECT
    *
  FROM
    `wide_world_importers.purchasing__suppliers` ),
  dim_supplier__rename_column AS (
  SELECT
    supplier_id AS supplier_key,
    supplier_name
  FROM
    dim_suppliers__source ),
  dim_supplier__cast_type AS (
  SELECT
    CAST(supplier_key AS integer) AS supplier_key,
    CAST(supplier_name AS string) AS supplier_name
  FROM
    dim_supplier__rename_column )
SELECT
  supplier_key,
  supplier_name
FROM
  dim_supplier__cast_type