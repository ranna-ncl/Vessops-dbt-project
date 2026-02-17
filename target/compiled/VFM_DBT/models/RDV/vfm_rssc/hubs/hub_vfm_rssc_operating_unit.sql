

with all_ou as (
  select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_rssc_fuel_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_rssc_crew_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_rssc_oso_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_rssc_port_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_rssc_mr_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_rssc_ntr_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_rssc_obr_psft
),
src as (
  select distinct
    hk_operating_unit,
    operating_unit_description as operating_unit_bk,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_RSSC')            as rcsr
  from all_ou
  where hk_operating_unit is not null
)

select * from src

where hk_operating_unit not in (select hk_operating_unit from VESSOPS_D.L00_STG.hub_vfm_rssc_operating_unit)
