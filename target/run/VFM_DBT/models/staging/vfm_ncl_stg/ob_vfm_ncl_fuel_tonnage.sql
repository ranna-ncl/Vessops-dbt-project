
  create or replace   view VESSOPS_D.L00_STG.ob_vfm_ncl_fuel_tonnage
  
   as (
    

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_NCL_FUEL_TONNAGE
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

        -- add IMO
        m.vessel_imo,

        -- hub hashkeys (IMO instead of ship_cd)
        md5(upper(trim(coalesce(to_varchar(operating_unit), '∅')))) as hk_operating_unit,
        md5(upper(trim(coalesce(to_varchar(m.vessel_imo), '∅'))))   as hk_vessel,
        md5(upper(trim(coalesce(to_varchar(account_description), '∅')))) as hk_account,

        -- link hashkey OU + VESSEL + ACCOUNT
        md5(
            md5(upper(trim(coalesce(to_varchar(operating_unit), '∅')))) || '^' ||
            md5(upper(trim(coalesce(to_varchar(m.vessel_imo), '∅'))))   || '^' ||
            md5(upper(trim(coalesce(to_varchar(account_description), '∅'))))
        ) as hk_lnk_ou_vessel_account

    from base
    left join imo_map m
        on upper(trim(base.ship_cd)) = m.ship_cd_norm
),

hd as (
    select
        norm.*,

        -- Hashdiff = payload only (exclude keys + audit cols)
        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
                'OPERATING_UNIT',
                'SHIP_CD',
                'VESSEL_IMO',
                'ACCOUNT_DESCRIPTION',
                'FISCAL_YEAR_NBR',
                'ACCOUNTING_PERIOD_NBR'
            )
        ))) as hashdiff

    from norm
)

select * from hd
  );

