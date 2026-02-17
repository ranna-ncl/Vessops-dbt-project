

select
  hk_lnk_ou_vessel_account,
  hk_operating_unit,
  hk_vessel,
  hk_account,
  min(load_dts) as ldts,
  max(rec_src) as rec_src
from VESSOPS_D.L00_STG.ob_vfm_rssc_fuel_tonnage
where hk_vessel is not null
group by 1,2,3,4


  having hk_lnk_ou_vessel_account not in (select hk_lnk_ou_vessel_account from VESSOPS_D.L10_RDV.lnk_vfm_rssc_ou_vessel_account)
