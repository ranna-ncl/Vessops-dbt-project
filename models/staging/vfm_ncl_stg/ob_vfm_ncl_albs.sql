{{ config(materialized='view') }}

with base as (
    select *
    from {{ source('vfm_ncl_stg', 'VFM_NCL_ALBS') }}
),
imo_map as (
    select
        upper(trim(ship_cd)) as ship_cd_norm,
        vessel_imo
    from {{ source('vfm_ncl_stg', 'IMO_SHIP_DETAILS') }}
    where ship_cd is not null
),
norm as (
    select
        base.*,
        m.vessel_imo
    from base
    left join imo_map m
        on upper(trim(base.ship_cd)) = m.ship_cd_norm
),
hd as (
    select
        norm.*,
        md5(upper(trim(coalesce(to_varchar(vessel_imo), '∅')))) as hk_vessel,
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'SHIP_NAME','SHIP_CD','BRAND',
                'VESSEL_IMO'
            )
        ))) as hashdiff
    from norm
)
select * from hd
