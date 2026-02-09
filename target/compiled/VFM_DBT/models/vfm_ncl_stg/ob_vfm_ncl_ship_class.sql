

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_NCL_SHIP_CLASS
),
imo_map as (
    select
        upper(trim(ship_cd)) as ship_cd_norm,
        vessel_imo
    from VESSOPS_D.L00_STG.IMO_SHIP_DETAILS
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
        md5(upper(trim(coalesce(to_varchar(VESSEL_IMO), '∅')))) as hk_vessel,
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'SHIP_NAME','SHIP_CD',
                'VESSEL_IMO',
                'SOURCE_FILE_NAME','SOURCE_FILE_ROW','LOAD_DTS','REC_SRC'
            )
        ))) as hashdiff
    from norm
)
select * from hd