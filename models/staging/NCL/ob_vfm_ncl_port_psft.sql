{{ config(materialized='view') }}

with base as (
    select *
    from {{ source('vfm_ncl_stg', 'VFM_NCL_PORT_PSFT') }}
),
hd as (
    select
        base.*,
        md5(upper(trim(coalesce(to_varchar(operating_unit_description), '∅')))) as hk_operating_unit,
        md5(upper(trim(coalesce(to_varchar(voyage_id), '∅'))))                 as hk_voyage,
        md5(upper(trim(coalesce(to_varchar(account), '∅'))))                   as hk_account,
        md5(hk_operating_unit || '^' || hk_voyage || '^' || hk_account)        as hk_lnk_ou_voyage_account,
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'OPERATING_UNIT_DESCRIPTION','VOYAGE_ID','ACCOUNT',
                'SOURCE_FILE_NAME','SOURCE_FILE_ROW','LOAD_DTS','REC_SRC'
            )
        ))) as hashdiff
    from base
)
select * from hd;
