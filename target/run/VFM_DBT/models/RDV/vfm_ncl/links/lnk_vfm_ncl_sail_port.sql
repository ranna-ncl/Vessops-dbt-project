-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L00_STG.lnk_vfm_ncl_sail_port as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.lnk_vfm_ncl_sail_port__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_SAIL_PORT = DBT_INTERNAL_DEST.HK_SAIL_PORT))

    
    when matched then update set
        "HK_SAIL_PORT" = DBT_INTERNAL_SOURCE."HK_SAIL_PORT","HK_SAILING" = DBT_INTERNAL_SOURCE."HK_SAILING","HK_PORT" = DBT_INTERNAL_SOURCE."HK_PORT","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR"
    

    when not matched then insert
        ("HK_SAIL_PORT", "HK_SAILING", "HK_PORT", "LDTS", "RCSR")
    values
        ("HK_SAIL_PORT", "HK_SAILING", "HK_PORT", "LDTS", "RCSR")

;
    commit;