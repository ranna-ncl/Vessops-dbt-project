{{ config(materialized='view') }}

with base as (
    select *
    from {{ source('vfm_rssc_stg', 'VFM_RSSC_FDR_REPORT') }}
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
