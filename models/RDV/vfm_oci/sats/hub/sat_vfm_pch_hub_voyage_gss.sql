{{ config(materialized='incremental', unique_key=['HK_VOYAGE','HASHDIFF','LDTS']) }}

with src as (
  select
    hk_voyage,
    hashdiff,
    load_dts as ldts,
    rec_src as rcsr,

    voyage_cd,
    gss_satisfied

  from {{ ref('ob_vfm_pch_gss') }}
  where hk_voyage is not null
),
dedup as (
  select *
  from src
  qualify row_number() over (partition by hk_voyage, hashdiff order by ldts desc) = 1
)

select * from dedup
{% if is_incremental() %}
where not exists (
  select 1
  from {{ this }} t
  where t.hk_voyage = dedup.hk_voyage
    and t.hashdiff  = dedup.hashdiff
)
{% endif %}
