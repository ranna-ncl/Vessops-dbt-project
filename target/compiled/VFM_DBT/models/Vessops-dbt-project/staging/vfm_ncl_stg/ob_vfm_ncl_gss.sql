

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_NCL_GSS
),
norm as (
    select
        base.*,
        coalesce(try_to_varchar(voyage_id), try_to_varchar(voyage_code)) as voyage_bk
    from base
),
hd as (
    select
        norm.*,
        md5(upper(trim(coalesce(to_varchar(voyage_bk), '∅')))) as hk_voyage,
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'VOYAGE_ID','VOYAGE_CODE','VOYAGE_BK',
                'SOURCE_FILE_NAME','SOURCE_FILE_ROW','LOAD_DTS','REC_SRC'
            )
        ))) as hashdiff
    from norm
)
select * from hd;