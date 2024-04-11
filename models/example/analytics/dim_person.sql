WITH
  dim_person__source AS (
  SELECT
    *
  FROM
    `vit-lam-data.wide_world_importers.application__people` ),
  dim_person__rename_column AS (
  SELECT
    person_id AS person_key,
    full_name
  FROM
    dim_person__source ),
  dim_person__cast_type AS (
  SELECT
    CAST(person_key AS integer) AS person_key,
    CAST(full_name AS string) AS full_name
  FROM
    dim_person__rename_column )
SELECT
  dim_person.person_key,
  dim_person.full_name
FROM   dim_person__cast_type dim_person