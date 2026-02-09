{{ config(materialized='incremental', unique_key=['HK_VESSEL','HASHDIFF','LDTS']) }}

with src as (
  select
    md5(upper(trim(coalesce(to_varchar(vessel_imo),'∅')))) as hk_vessel,
    md5(upper(to_json(object_construct_keep_null(
      'brand', brand,
      'ship_name', ship_name,
      'ship_class', ship_class,
      'ship_cd', ship_cd,
      'vesselid', vesselid
    )))) as hashdiff,
    current_timestamp() as ldts,
    'VFM_NCL' as rcsr,
    brand, ship_name, ship_class, ship_cd, vesselid
  from {{ source('vfm_ncl_stg','IMO_SHIP_DETAILS') }}
  where vessel_imo is not null
),
dedup as (
  select *
  from src
  qualify row_number() over (partition by hk_vessel, hashdiff order by ldts desc) = 1
)

select * from dedup
{% if is_incremental() %}
where not exists (
  select 1 from {{ this }} t
  where t.hk_vessel = dedup.hk_vessel
    and t.hashdiff  = dedup.hashdiff
)
{% endif %}

