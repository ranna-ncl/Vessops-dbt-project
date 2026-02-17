
  create or replace   view VESSOPS_D.L00_STG.ob_vfm_oci_fdr_report
  
   as (
    

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_OCI_FDR_REPORT
),

norm as (
    select
        base.*,

        /* Composite business key (NEW FORMAT)
           BK = CRUISE_CODE + PRTD_YEAR + PRTD_MONTH */
        trim(coalesce(to_varchar(cruise_code), '∅')) || '^' ||
        trim(coalesce(to_varchar(prtd_year),   '∅')) || '^' ||
        trim(coalesce(to_varchar(prtd_month),  '∅')) as fdr_bk

    from base
),

hd as (
    select
        norm.*,

        /* Hub hashkey */
        md5(upper(trim(coalesce(to_varchar(fdr_bk), '∅')))) as hk_fdr,

        /* Hashdiff = payload only
           - exclude BK columns + derived BK/HK + audit cols */
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),

                -- BK cols
                'CRUISE_CODE',
                'PRTD_YEAR',
                'PRTD_MONTH'
            )
        ))) as hashdiff

    from norm
)

select * from hd
  );

