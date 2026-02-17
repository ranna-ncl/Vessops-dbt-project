{{ config(schema='L10_RDV', materialized='incremental', unique_key=['HK_LNK_OU_VOYAGE_ACCOUNT','LDTS','JOURNAL_MONETARY_AMOUNT_ADJ']) }}

select
  hk_lnk_ou_voyage_account,
  hashdiff,
  load_dts as ldts,
  rec_src,

  -- payload
  fiscal_year_number,
  accounting_period,
  business_unit_combined_description,
  operating_unit_description,
  m0_m1,
  voyage_id,
  account,
  journal_monetary_amount_adj

from {{ ref('ob_vfm_oci_fuel_psft') }}

{% if is_incremental() %}
where not exists (
  select 1
  from {{ this }} t
  where t.hk_lnk_ou_voyage_account = {{ ref('ob_vfm_oci_fuel_psft') }}.hk_lnk_ou_voyage_account
    and t.hashdiff = {{ ref('ob_vfm_oci_fuel_psft') }}.hashdiff
)
{% endif %}
