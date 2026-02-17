

with all_acct as (
  select account, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_fuel_psft
  union all select account, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_crew_psft
  union all select account, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_oso_psft
  union all select account, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_port_psft
  union all select account, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_mr_psft
  union all select account, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_ntr_psft
  union all select account, hk_account, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_obr_psft
),
src as (
  select distinct
    hk_account,
    account as account_bk,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_OCI')            as rcsr
  from all_acct
  where hk_account is not null
)

select * from src

where hk_account not in (select hk_account from VESSOPS_D.L00_STG.hub_vfm_oci_account)
