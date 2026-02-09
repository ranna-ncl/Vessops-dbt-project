{{ config(materialized='incremental', unique_key='HK_ACCOUNT') }}

with all_acct as (
  select account, hk_account, load_dts, rec_src from {{ ref('ob_vfm_ncl_fuel_psft') }}
  union all select account, hk_account, load_dts, rec_src from {{ ref('ob_vfm_ncl_crew_psft') }}
  union all select account, hk_account, load_dts, rec_src from {{ ref('ob_vfm_ncl_food_psft') }}
  union all select account, hk_account, load_dts, rec_src from {{ ref('ob_vfm_ncl_oso_psft') }}
  union all select account, hk_account, load_dts, rec_src from {{ ref('ob_vfm_ncl_port_psft') }}
  union all select account, hk_account, load_dts, rec_src from {{ ref('ob_vfm_ncl_mr_psft') }}
  union all select account, hk_account, load_dts, rec_src from {{ ref('ob_vfm_ncl_ntr_psft') }}
  union all select account, hk_account, load_dts, rec_src from {{ ref('ob_vfm_ncl_obr_psft') }}
),
src as (
  select distinct
    hk_account,
    account as account_bk,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_NCL')            as rcsr
  from all_acct
  where hk_account is not null
)

select * from src
{% if is_incremental() %}
where hk_account not in (select hk_account from {{ this }})
{% endif %}

