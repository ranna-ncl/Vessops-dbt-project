

with src as (
  select distinct
    hk_voyage,
    voyage_cd as voyage_cd_bk,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_OCI')            as rcsr
  from VESSOPS_D.L00_STG.ob_vfm_rssc_sailing_master_without_straddle
  where hk_voyage is not null
)

select * from src
