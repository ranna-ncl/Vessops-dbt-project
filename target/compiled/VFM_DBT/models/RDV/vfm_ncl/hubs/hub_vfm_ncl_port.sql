

with src as (
  select distinct
    md5(upper(trim(coalesce(to_varchar(port_cd),'∅')))) as hk_port,
    port_cd as port_cd_bk,
    coalesce(LOAD_DTS, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_NCL')            as rcsr
  from VESSOPS_D.L00_STG.ob_vfm_ncl_itinerary
  where port_cd is not null
)

select * from src

where hk_port not in (select hk_port from VESSOPS_D.L00_STG.hub_vfm_ncl_port)
