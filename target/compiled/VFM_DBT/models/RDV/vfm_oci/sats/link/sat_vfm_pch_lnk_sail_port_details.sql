

with src as (
  select
    hk_sail_port,
    hashdiff,
    load_dts as ldts,
    rec_src as rcsr,

    ship_cd,
    sail_dat,
    sail_id,
    offset_day_nbr,
    port_cd,
    arrival_tim,
    departure_tim,
    arrival_tim_txt,
    departure_tim_txt,
    operational_cd,
    activity_txt,
    activity_cd,
    fake_cd,
    active_cd

  from VESSOPS_D.L00_STG.ob_vfm_pch_itinerary
  where hk_sail_port is not null
),
dedup as (
  select *
  from src
  qualify row_number() over (partition by hk_sail_port, hashdiff order by ldts desc) = 1
)

select * from dedup

where not exists (
  select 1
  from VESSOPS_D.L00_STG.sat_vfm_pch_lnk_sail_port_details t
  where t.hk_sail_port = dedup.hk_sail_port
    and t.hashdiff     = dedup.hashdiff
)
