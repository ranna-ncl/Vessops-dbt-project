

select
  hk_lnk_ou_voyage_account,
  hashdiff,
  load_dts as ldts,
  rec_src,

  -- payload
  fiscal_year_number,
  accounting_period,
  business_unit_combined_description,
  operating_unit_description,
  m0_m1,
  voyage_id,
  account,
  journal_monetary_amount_adj

from VESSOPS_D.L00_STG.ob_vfm_rssc_fuel_psft


where not exists (
  select 1
  from VESSOPS_D.L10_RDV.sat_vfm_rssc_lnk_ou_voyage_account_fuel_psft t
  where t.hk_lnk_ou_voyage_account = VESSOPS_D.L00_STG.ob_vfm_rssc_fuel_psft.hk_lnk_ou_voyage_account
    and t.hashdiff = VESSOPS_D.L00_STG.ob_vfm_rssc_fuel_psft.hashdiff
)
