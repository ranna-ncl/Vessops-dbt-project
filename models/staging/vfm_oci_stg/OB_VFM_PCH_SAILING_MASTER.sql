{{ config(materialized='view') }}

with base as (
  select *
  from {{ source('vfm_oci_stg', 'VFM_PCH_SAILING_MASTER') }}
),
map as (
  select
    upper(trim(ship_cd)) as ship_cd_norm,
    vessel_imo
  from {{ source('vfm_ncl_stg', 'IMO_SHIP_DETAILS') }}
  where ship_cd is not null
),
enriched as (
  select
    b.*,
    m.vessel_imo,
    md5(upper(trim(coalesce(to_varchar(m.vessel_imo),'∅')))) as hk_vessel,

    -- ✅ PCH voyage key = CRUISE_SEGMENT_CD (not VOYAGE_CD)
    md5(upper(trim(coalesce(to_varchar(b.cruise_segment_cd),'∅')))) as hk_voyage

  from base b
  left join map m
    on upper(trim(b.ship_cd)) = m.ship_cd_norm
)

select
  enriched.*,

  md5(upper(to_json(
    object_delete(
      object_construct_keep_null(*),

      -- exclude BKs from hashdiff
      'CRUISE_SEGMENT_CD',
      'SHIP_CD',
      'VESSEL_IMO'


    )
  ))) as hashdiff

from enriched
