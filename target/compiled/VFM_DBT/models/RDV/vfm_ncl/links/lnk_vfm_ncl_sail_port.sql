

with src as (
  select distinct
    hk_sail_port as hk_sail_port,
    md5(upper(trim(coalesce(to_varchar(sail_id),'∅')))) as hk_sailing,
    md5(upper(trim(coalesce(to_varchar(port_cd),'∅')))) as hk_port,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_NCL')            as rcsr
  from VESSOPS_D.L00_STG.ob_vfm_ncl_itinerary
  where hk_sail_port is not null
)

select * from src

where hk_sail_port not in (select hk_sail_port from VESSOPS_D.L00_STG.lnk_vfm_ncl_sail_port)
