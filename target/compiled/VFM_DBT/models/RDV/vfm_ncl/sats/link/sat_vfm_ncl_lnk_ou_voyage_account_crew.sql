

with src as (
  select
    hk_lnk_ou_voyage_account, hashdiff,
    load_dts as ldts, rec_src as rcsr,
    fiscal_year_number, accounting_period, business_unit_combined_description,
    operating_unit_description, ship_cd, m0_m1, voyage_id, account,
    journal_monetary_amount_adj
  from VESSOPS_D.L00_STG.ob_vfm_ncl_crew_psft
  where hk_lnk_ou_voyage_account is not null
),
dedup as (
  select * from src
  qualify row_number() over (partition by hk_lnk_ou_voyage_account, hashdiff order by ldts desc) = 1
)

select * from dedup

where not exists (
  select 1 from VESSOPS_D.L00_STG.sat_vfm_ncl_lnk_ou_voyage_account_crew t
  where t.hk_lnk_ou_voyage_account = dedup.hk_lnk_ou_voyage_account
    and t.hashdiff = dedup.hashdiff
)
