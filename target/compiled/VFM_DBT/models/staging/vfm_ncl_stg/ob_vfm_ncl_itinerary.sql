

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_NCL_ITINERARY
),
imo_map as (
    select
        upper(trim(ship_cd)) as ship_cd_norm,
        vessel_imo
    from VESSOPS_D.L00_STG.IMO_SHIP_DETAILS
    where ship_cd is not null
),
enriched as (
    select
        b.*,
        m.vessel_imo
    from base b
    left join imo_map m
        on upper(trim(b.ship_cd)) = m.ship_cd_norm
),
hd as (
    select
        enriched.*,

        md5(upper(
            trim(coalesce(to_varchar(sail_id), '∅')) || '^' ||
            trim(coalesce(to_varchar(port_cd), '∅'))
        )) as hk_sail_port,

        md5(upper(trim(coalesce(to_varchar(vessel_imo), '∅')))) as hk_vessel,

        md5(upper(to_json(
            object_delete(
                object_construct_keep_null(*),
'SHIP_CD', 'SAIL_DAT', 'SAIL_ID', 'FAKE_CD', 'ACTIVE_CD', 'OFFSET_DAY_NBR', 'PORT_CD', 'ARRIVAL_TIM', 'DEPARTURE_TIM', 'ARRIVAL_TIM_TXT', 'DEPARTURE_TIM_TXT', 'OPERATIONAL_CD', 'ACTIVITY_TXT', 'ACTIVITY_CD','VESSEL_IMO'

            )
        ))) as hashdiff
    from enriched
)
select * from hd