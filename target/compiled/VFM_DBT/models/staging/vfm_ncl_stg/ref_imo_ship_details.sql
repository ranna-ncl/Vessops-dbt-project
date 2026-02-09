

select
    upper(trim(ship_cd))                as ship_cd_norm,
    brand,
    ship_name,
    ship_class,
    vesselid,
    vessel_imo::number(38,0)            as vessel_imo
from VESSOPS_D.L00_STG.IMO_SHIP_DETAILS
where ship_cd is not null