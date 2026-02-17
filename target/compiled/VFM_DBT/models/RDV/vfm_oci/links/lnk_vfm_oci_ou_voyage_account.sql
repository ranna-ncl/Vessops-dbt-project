

with unioned as (
  select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_fuel_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_crew_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_oso_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_port_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_mr_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_ntr_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_obr_psft
),
src as (
  select distinct
    hk_lnk_ou_voyage_account,
    hk_operating_unit,
    hk_voyage,
    hk_account,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_OCI')            as rcsr
  from unioned
  where hk_lnk_ou_voyage_account is not null
)

select * from src

where hk_lnk_ou_voyage_account not in (select hk_lnk_ou_voyage_account from VESSOPS_D.L00_STG.lnk_vfm_oci_ou_voyage_account)
