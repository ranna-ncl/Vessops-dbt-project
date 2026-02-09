-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L00_STG.hub_vfm_ncl_voyage as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.hub_vfm_ncl_voyage__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_VOYAGE = DBT_INTERNAL_DEST.HK_VOYAGE))

    
    when matched then update set
        "HK_VOYAGE" = DBT_INTERNAL_SOURCE."HK_VOYAGE","VOYAGE_CD_BK" = DBT_INTERNAL_SOURCE."VOYAGE_CD_BK","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR"
    

    when not matched then insert
        ("HK_VOYAGE", "VOYAGE_CD_BK", "LDTS", "RCSR")
    values
        ("HK_VOYAGE", "VOYAGE_CD_BK", "LDTS", "RCSR")

;
    commit;