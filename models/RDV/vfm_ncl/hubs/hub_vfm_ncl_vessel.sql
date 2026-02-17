{{ config(materialized='incremental', unique_key='HK_VESSEL') }}

with src as (
  select distinct
    md5(upper(trim(coalesce(to_varchar(vessel_imo),'∅')))) as hk_vessel,
    vessel_imo::number(38,0)                               as vessel_imo,
    current_timestamp()                                     as ldts,
    'VFM_NCL'                                               as rcsr
  from {{ source('vfm_ncl_stg','IMO_SHIP_DETAILS') }}
  where vessel_imo is not null
)

select * from src
{% if is_incremental() %}
where hk_vessel not in (select hk_vessel from {{ this }})
{% endif %}