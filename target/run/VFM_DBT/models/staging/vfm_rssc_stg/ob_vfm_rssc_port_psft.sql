
  create or replace   view VESSOPS_D.L00_STG.ob_vfm_rssc_port_psft
  
   as (
    

with base as (
    select *
    from VESSOPS_D.L00_STG.VFM_RSSC_PORT_PSFT
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
                'FISCAL_YEAR_NUMBER', 'ACCOUNTING_PERIOD', 'BUSINESS_UNIT_COMBINED_DESCRIPTION', 'OPERATING_UNIT_DESCRIPTION', 'SHIP_CD', 'M0_M1', 'VOYAGE_ID', 'ACCOUNT'
            )
        ))) as hashdiff
    from base
)
select * from hd
  );

