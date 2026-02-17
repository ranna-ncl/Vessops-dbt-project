
  
    

        create or replace transient table VESSOPS_D.L00_STG.lnk_vfm_oci_voyage_vessel
         as
        (

with src as (
  select distinct
    md5(hk_voyage || '^' || hk_vessel) as hk_lnk_voyage_vessel,
    hk_voyage,
    hk_vessel,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_OCI')            as rcsr
  from VESSOPS_D.L00_STG.ob_vfm_oci_sailing_master_without_straddle
  where hk_voyage is not null and hk_vessel is not null
)

select
  hk_lnk_voyage_vessel as hk_lnk_voyage_vessel,
  hk_voyage,
  hk_vessel,
  ldts,
  rcsr
from src

        );
      
  