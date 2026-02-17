

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_NCL_FDR_REPORT
),

norm as (
    select
        base.*,

        -- Composite business key
        trim(coalesce(to_varchar(voyage_by_sailing), '∅')) || '^' ||
        trim(coalesce(to_varchar(prorated_sail_year_nbr), '∅')) || '^' ||
        trim(coalesce(to_varchar(prorated_sail_month_nbr), '∅')) as fdr_bk

    from base
),

hd as (
    select
        norm.*,

        -- Hub hashkey for composite BK
        md5(upper(trim(coalesce(to_varchar(fdr_bk), '∅')))) as hk_fdr,

        -- Hashdiff = payload only (exclude BK + audit cols)
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'VOYAGE_BY_SAILING',
                'PRORATED_SAIL_YEAR_NBR',
                'PRORATED_SAIL_MONTH_NBR'
            )
        ))) as hashdiff

    from norm
)

select * from hd