{{ config(materialized='view') }}

with base as (
    select *
    from {{ source('vfm_ncl_stg', 'VFM_NCL_SAILING_MASTER_WITHOUT_STRADDLE') }}
),
hd as (
    select
        base.*,
        md5(upper(trim(coalesce(to_varchar(voyage_cd), '∅')))) as hk_voyage,
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'VOYAGE_CD',
                'SOURCE_FILE_NAME','SOURCE_FILE_ROW','LOAD_DTS','REC_SRC'
            )
        ))) as hashdiff
    from base
)
select * from hd;
