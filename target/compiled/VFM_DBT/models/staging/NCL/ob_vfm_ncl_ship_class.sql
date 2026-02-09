

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_NCL_SHIP_CLASS
),
norm as (
    select
        base.*,
        coalesce(try_to_varchar(ship_code), try_to_varchar(ship_cd)) as ship_bk
    from base
),
hd as (
    select
        norm.*,
        md5(upper(trim(coalesce(to_varchar(ship_bk), '∅')))) as hk_ship,
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'SHIP_CODE','SHIP_CD','SHIP_BK',
                'SOURCE_FILE_NAME','SOURCE_FILE_ROW','LOAD_DTS','REC_SRC'
            )
        ))) as hashdiff
    from norm
)
select * from hd;