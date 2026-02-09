
  create or replace   view VESSOPS_D.L00_STG.ob_vfm_ncl_sailing_master_without_straddle
  
   as (
    

with base as (
  select *
  from VESSOPS_D.L00_STG.VFM_NCL_SAILING_MASTER_WITHOUT_STRADDLE
),
map as (
  select
        upper(trim(ship_cd)) as ship_cd_norm,
        vessel_imo
    from VESSOPS_D.L00_STG.IMO_SHIP_DETAILS
    where ship_cd is not null
),
enriched as (
  select
    b.*,
    m.vessel_imo,
    md5(upper(trim(coalesce(to_varchar(m.vessel_imo),'∅')))) as hk_vessel,

    md5(upper(trim(coalesce(to_varchar(b.voyage_cd),'∅')))) as hk_voyage
  from base b
  left join map m
    on upper(trim(b.ship_cd)) = m.ship_cd_norm
)
select
  enriched.*,
  md5(upper(to_json(
    object_delete(object_construct_keep_null(*),
      'VOYAGE_CD',
      'SHIP_CD',
      'VESSEL_IMO'
    )
  ))) as hashdiff
from enriched
  );

