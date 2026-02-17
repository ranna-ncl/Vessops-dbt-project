

select
  hk_fdr,
  fdr_bk,
  min(load_dts) as ldts,
  max(rec_src) as rec_src
from VESSOPS_D.L00_STG.ob_vfm_rssc_fdr_report
where fdr_bk is not null
group by 1,2


  having hk_fdr not in (select hk_fdr from VESSOPS_D.L10_RDV.hub_vfm_rssc_fdr)
