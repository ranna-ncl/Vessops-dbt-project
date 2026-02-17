

with src as (
  select
    hk_voyage,
    hashdiff,
    load_dts as ldts,
    rec_src as rcsr,

    voyage_cd,
    gss_satisfied

  from VESSOPS_D.L00_STG.ob_vfm_pch_gss
  where hk_voyage is not null
),
dedup as (
  select *
  from src
  qualify row_number() over (partition by hk_voyage, hashdiff order by ldts desc) = 1
)

select * from dedup

where not exists (
  select 1
  from VESSOPS_D.L00_STG.sat_vfm_pch_hub_voyage_gss t
  where t.hk_voyage = dedup.hk_voyage
    and t.hashdiff  = dedup.hashdiff
)
