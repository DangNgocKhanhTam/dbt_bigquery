SELECT 
  stock_item_id as product_id, 
  coalesce(brand, 'Undefined') as brand_name, 
  product.supplier_id, 
  supplier.supplier_name
FROM `vit-lam-data.wide_world_importers.warehouse__stock_items` as product 
JOIN `learn-dbt2.test2.supplier` as supplier
ON product.supplier_id = supplier.supplier_id