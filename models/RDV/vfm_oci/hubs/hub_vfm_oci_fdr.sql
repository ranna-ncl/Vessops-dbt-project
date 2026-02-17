{{ config(schema='L10_RDV', materialized='incremental', unique_key='HK_FDR') }}

select
  hk_fdr,
  fdr_bk,
  min(load_dts) as ldts,
  max(rec_src) as rec_src
from {{ ref('ob_vfm_oci_fdr_report') }}
where fdr_bk is not null
group by 1,2

{% if is_incremental() %}
  having hk_fdr not in (select hk_fdr from {{ this }})
{% endif %}
