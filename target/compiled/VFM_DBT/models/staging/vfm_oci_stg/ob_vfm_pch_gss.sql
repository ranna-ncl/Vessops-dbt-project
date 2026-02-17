

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_PCH_GSS
),
norm as (
    select
        base.*
    from base
),
hd as (
    select
        norm.*,
        md5(upper(trim(coalesce(to_varchar(voyage_CD), '∅')))) as hk_voyage,
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'VOYAGE_CD'
            )
        ))) as hashdiff
    from norm
)
select * from hd