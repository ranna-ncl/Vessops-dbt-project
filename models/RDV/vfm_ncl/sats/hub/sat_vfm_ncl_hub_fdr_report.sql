{{ config(
    schema='L10_RDV',
    materialized='incremental',
    unique_key=['HK_FDR','LDTS']
) }}

with src as (
    select
        -- parent key
        hk_fdr,

        -- dv2 metadata
        hashdiff,
        load_dts as ldts,
        rec_src,
        -- payload (ALL business columns exactly once)
        report_year,
        report_wk,
        prorated_sail_year_nbr,
        prorated_sail_month_nbr,
        voyage_by_sailing,
        month,
        charter,
        sum_bk_operational_ntr,
        sum_pax_days,
        do_cap_days,
        cap_cabin_days,
        bk_cabin_days,
        booked_capacity,
        bk_cabins,
        proration,
        length,
        market,
        ntr_build,
        pds_build,
        nclh_ship,
        quarter,
        period,
        cabins,
        ship

    from {{ ref('ob_vfm_ncl_fdr_report') }}
)

select *
from src

{% if is_incremental() %}
where not exists (
    select 1
    from {{ this }} t
    where t.hk_fdr = src.hk_fdr
      and t.hashdiff = src.hashdiff
)
{% endif %}
