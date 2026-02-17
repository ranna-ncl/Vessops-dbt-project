
  
    

        create or replace transient table VESSOPS_D.L00_STG.hub_vfm_ncl_account
         as
        (

with all_acct as (

    select
        account,
        hk_account,
        load_dts,
        rec_src
    from VESSOPS_D.L00_STG.ob_vfm_ncl_fuel_psft

    union all
    select account, hk_account, load_dts, rec_src
    from VESSOPS_D.L00_STG.ob_vfm_ncl_crew_psft

    union all
    select account, hk_account, load_dts, rec_src
    from VESSOPS_D.L00_STG.ob_vfm_ncl_food_psft

    union all
    select account, hk_account, load_dts, rec_src
    from VESSOPS_D.L00_STG.ob_vfm_ncl_oso_psft

    union all
    select account, hk_account, load_dts, rec_src
    from VESSOPS_D.L00_STG.ob_vfm_ncl_port_psft

    union all
    select account, hk_account, load_dts, rec_src
    from VESSOPS_D.L00_STG.ob_vfm_ncl_mr_psft

    union all
    select account, hk_account, load_dts, rec_src
    from VESSOPS_D.L00_STG.ob_vfm_ncl_ntr_psft

    union all
    select account, hk_account, load_dts, rec_src
    from VESSOPS_D.L00_STG.ob_vfm_ncl_obr_psft
),

src as (
    select
        hk_account,
        account as account_bk,
        min(coalesce(load_dts, current_timestamp())) as ldts,
        max(coalesce(rec_src, 'VFM_NCL'))            as rcsr
    from all_acct
    where hk_account is not null
      and account is not null
    group by hk_account, account
)

select *
from src


        );
      
  