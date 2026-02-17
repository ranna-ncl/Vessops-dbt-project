{{ config(schema='L10_RDV', materialized='incremental', unique_key='HK_LNK_OU_VESSEL_ACCOUNT') }}

select
  hk_lnk_ou_vessel_account,
  hk_operating_unit,
  hk_vessel,
  hk_account,
  min(load_dts) as ldts,
  max(rec_src) as rec_src
from {{ ref('ob_vfm_oci_fuel_tonnage') }}
where hk_vessel is not null
group by 1,2,3,4

{% if is_incremental() %}
  having hk_lnk_ou_vessel_account not in (select hk_lnk_ou_vessel_account from {{ this }})
{% endif %}
