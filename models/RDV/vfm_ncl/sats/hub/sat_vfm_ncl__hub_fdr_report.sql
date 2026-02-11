{{ config(schema='L10_RDV', materialized='incremental', unique_key=['HK_FDR','LDTS']) }}

select
  hk_fdr,
  hashdiff,
  load_dts as ldts,
  rec_src,

  -- payload
  voyage_by_sailing,
  prorated_sail_year_nbr,
  prorated_sail_month_nbr,
  -- add all remaining FDR fields you want historized
  * exclude (hk_fdr, hashdiff, load_dts, rec_src, source_file_name, source_file_row, fdr_bk)

from {{ ref('ob_vfm_ncl_fdr_report') }}

{% if is_incremental() %}
where not exists (
  select 1
  from {{ this }} t
  where t.hk_fdr = {{ ref('ob_vfm_ncl_fdr_report') }}.hk_fdr
    and t.hashdiff = {{ ref('ob_vfm_ncl_fdr_report') }}.hashdiff
)
{% endif %}
