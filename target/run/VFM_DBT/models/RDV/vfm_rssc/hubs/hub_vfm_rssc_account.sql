-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L00_STG.hub_vfm_rssc_account as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.hub_vfm_rssc_account__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_ACCOUNT = DBT_INTERNAL_DEST.HK_ACCOUNT))

    
    when matched then update set
        "HK_ACCOUNT" = DBT_INTERNAL_SOURCE."HK_ACCOUNT","ACCOUNT_BK" = DBT_INTERNAL_SOURCE."ACCOUNT_BK","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR"
    

    when not matched then insert
        ("HK_ACCOUNT", "ACCOUNT_BK", "LDTS", "RCSR")
    values
        ("HK_ACCOUNT", "ACCOUNT_BK", "LDTS", "RCSR")

;
    commit;