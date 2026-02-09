{{ config(materialized='incremental', unique_key='HK_VOYAGE') }}

with src as (
  select distinct
    hk_voyage,
    voyage_cd as voyage_cd_bk,
    coalesce(load_dts, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_NCL')            as rcsr
  from {{ ref('ob_vfm_ncl_sailing_master_without_straddle') }}
  where hk_voyage is not null
)

select * from src
{% if is_incremental() %}
where hk_voyage not in (select hk_voyage from {{ this }})
{% endif %}

