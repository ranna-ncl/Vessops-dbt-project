

with unioned as (
  select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_ncl_fuel_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_ncl_crew_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_ncl_food_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_ncl_oso_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_ncl_port_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_ncl_mr_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_ncl_ntr_psft
  union all select hk_lnk_ou_voyage_account, hk_operating_unit, hk_voyage, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_ncl_obr_psft
),
src as (
  select distinct
    hk_lnk_ou_voyage_account,
    hk_operating_unit,
    hk_voyage,
    hk_account,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_NCL')            as rcsr
  from unioned
  where hk_lnk_ou_voyage_account is not null
)

select * from src

where hk_lnk_ou_voyage_account not in (select hk_lnk_ou_voyage_account from VESSOPS_D.L00_STG.lnk_vfm_ncl_ou_voyage_account)
