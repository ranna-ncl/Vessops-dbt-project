

with src as (
  select
    hk_voyage,
    hashdiff,
    load_dts as ldts,
    rec_src  as rcsr,

    -- descriptive payload columns (PCH Sailing Master)
    company_cd,
    cruise_segment_cd,
    ship_cd,
    vessel_imo,
    sail_dat,
    return_dat,
    sail_time,
    return_time,
    sail_day_qty,
    embark_port_cd,
    disembark_port_cd,
    charter_ind,
    segment_market_name,
    segment_super_market_desc,
    guest_capacity_qty,
    cabin_capacity_qty,
    week_num,
    month_num,
    year_num

  from VESSOPS_D.L00_STG.OB_VFM_PCH_SAILING_MASTER
  where hk_voyage is not null
),

dedup as (
  select *
  from src
  qualify row_number() over (
    partition by hk_voyage, hashdiff
    order by ldts desc
  ) = 1
)

select * from dedup

