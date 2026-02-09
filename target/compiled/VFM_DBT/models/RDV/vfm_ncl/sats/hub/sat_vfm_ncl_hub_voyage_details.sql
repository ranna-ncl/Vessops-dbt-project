

with src as (
  select
    hk_voyage,
    hashdiff,
    load_dts as ldts,
    rec_src as rcsr,

    -- include all non-key descriptive columns you want:
    sail_id,
    ship_cd,
    vessel_imo,
    sail_dat,
    return_dat,
    sail_day_qty,
    embark_port_cd,
    disembark_port_cd,
    main_voyage_cd,
    sail_status_cd,
    charter_cd,
    product_cd,
    product_desc,
    rm_rollup_product_cd,
    rm_rollup_product_desc,
    brochure_rollup_product_cd,
    brochure_rollup_product_desc,
    season_cd,
    geog_area_cd,
    operational_week_nbr,
    operational_month_nbr,
    operational_year_nbr,
    ticket_week_nbr,
    ticket_month_nbr,
    ticket_year_nbr,
    on_sale_dat,
    itinerary_cd,
    itinerary_changed_dat,
    is_holiday_cd,
    is_extraordinary_cd,
    voyage_exception_desc

  from VESSOPS_D.L00_STG.ob_vfm_ncl_sailing_master_without_straddle
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
  from VESSOPS_D.L00_STG.sat_vfm_ncl_hub_voyage_details t
  where t.hk_voyage = dedup.hk_voyage
    and t.hashdiff  = dedup.hashdiff
)
