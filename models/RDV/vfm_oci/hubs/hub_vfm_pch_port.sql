{{ config(materialized='incremental', unique_key='HK_PORT') }}

with src as (
  select distinct
    md5(upper(trim(coalesce(to_varchar(port_cd),'∅')))) as hk_port,
    port_cd as port_cd_bk,
    coalesce(LOAD_DTS, current_timestamp()) as ldts,
    coalesce(rec_src, 'VFM_PCH')            as rcsr
  from {{ ref('ob_vfm_pch_itinerary') }}
  where port_cd is not null
)

select * from src
{% if is_incremental() %}
where hk_port not in (select hk_port from {{ this }})
{% endif %}

