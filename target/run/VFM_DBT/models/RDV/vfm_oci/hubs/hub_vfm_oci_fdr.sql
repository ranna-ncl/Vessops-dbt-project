
  
    

        create or replace transient table VESSOPS_D.L10_RDV.hub_vfm_oci_fdr
         as
        (

select
  hk_fdr,
  fdr_bk,
  min(load_dts) as ldts,
  max(rec_src) as rec_src
from VESSOPS_D.L00_STG.ob_vfm_oci_fdr_report
where fdr_bk is not null
group by 1,2


        );
      
  