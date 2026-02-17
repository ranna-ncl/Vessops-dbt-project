

with src as (
    select
        -- parent key
        hk_fdr,

        -- dv2 metadata
        hashdiff,
        load_dts as ldts,
        rec_src as rcsr,


        -- Business key columns (ok to store in SAT; hashdiff already excludes them in OB view)
        cruise_code,
        prtd_year,
        prtd_month,

        -- Other columns from the new file
        period,
        ports,
        market,
        total_voyage_days,
        prorated_days,
        pax_day_capacity,
        rev_pax_days,
        rev_occ_pct,
        cruise_revenue,
        air_cost,
        air_rev,
        included_hotel,
        dilutions,
        included_costs,
        commissions,
        comm_overrides,
        tactical,
        credit_card_fees,
        net_transfers,
        effective_revenue,
        effective_pricing,
        net_ticket_revenue,
        npd,
        class,
        ship,
        quarter,
        fcst_pax_day_cap,
        fcst_rev_pax_days,
        fcst_capped_cabin_days,
        fcst_rev_occ_pct,
        fcst_eff_rev,
        fcst_eff_pricing,
        fcst_ntr,
        ntpd_to_go,
        cabins_booked_w_alt_and_nr,
        cabins_to_go,
        pax_day_inv,
        inventory_amount,
        rem_to_sell,
        air_part_pct,
        charter,
        board_markets,
        capped_cabin_days,
        cabin_capacity,
        sta_pax_capacity,
        sta_cabin_capacity,
        variable_pax_capacity,
        variable_cabin_capacity,
        fcst_cabin_capacity,
        fcst_ntpd,
        single_pds_booked,
        double_pds_booked,
        single_pax_capacity,
        double_pax_capacity,
        single_pax_rem_inv,
        double_pax_rem_inv

    from VESSOPS_D.L00_STG.ob_vfm_oci_fdr_report
    where hk_fdr is not null
),

dedup as (
    select *
    from src
    qualify row_number() over (partition by hk_fdr, hashdiff order by ldts desc) = 1
)

select *
from dedup


where not exists (
    select 1
    from VESSOPS_D.L10_RDV.sat_vfm_oci_hub_fdr_report t
    where t.hk_fdr   = dedup.hk_fdr
      and t.hashdiff = dedup.hashdiff
)
