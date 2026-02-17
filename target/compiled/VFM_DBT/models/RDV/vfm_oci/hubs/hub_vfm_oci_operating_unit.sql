

with all_ou as (
  select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_fuel_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_crew_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_oso_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_port_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_mr_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_ntr_psft
  union all select operating_unit_description, hk_operating_unit, load_dts, rec_src from VESSOPS_D.L00_STG.ob_vfm_oci_obr_psft
),
src as (
  select distinct
    hk_operating_unit,
    operating_unit_description as operating_unit_bk,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_OCI')            as rcsr
  from all_ou
  where hk_operating_unit is not null
)

select * from src

where hk_operating_unit not in (select hk_operating_unit from VESSOPS_D.L00_STG.hub_vfm_oci_operating_unit)
