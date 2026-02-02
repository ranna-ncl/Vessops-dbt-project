{{ config(materialized='view') }}

with base as (
    select *
    from {{ source('vfm_ncl_stg', 'VFM_NCL_ITINERARY') }}
),
hd as (
    select
        base.*,

        md5(upper(
            trim(coalesce(to_varchar(sail_id), '∅')) || '^' ||
            trim(coalesce(to_varchar(port_cd), '∅'))
        )) as hk_sail_port,

        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'SAIL_ID','PORT_CD',
                'SOURCE_FILE_NAME','SOURCE_FILE_ROW','LOAD_DTS','REC_SRC'
            )
        ))) as hashdiff
    from base
)
select * from hd;
