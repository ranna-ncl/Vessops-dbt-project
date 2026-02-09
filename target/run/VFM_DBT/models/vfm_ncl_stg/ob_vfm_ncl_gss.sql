
  create or replace   view VESSOPS_D.L00_STG.ob_vfm_ncl_gss
  
   as (
    

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_NCL_GSS
),
norm as (
    select
        base.*,
        VOYAGE_CD as voyage_bk
    from base
),
hd as (
    select
        norm.*,
        md5(upper(trim(coalesce(to_varchar(voyage_CD), '∅')))) as hk_voyage,
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'VOYAGE_CD','VOYAGE_BK',
                'SOURCE_FILE_NAME','SOURCE_FILE_ROW','LOAD_DTS','REC_SRC'
            )
        ))) as hashdiff
    from norm
)
select * from hd
  );

