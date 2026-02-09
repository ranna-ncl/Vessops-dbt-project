-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L00_STG.hub_vfm_ncl_port as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.hub_vfm_ncl_port__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_PORT = DBT_INTERNAL_DEST.HK_PORT))

    
    when matched then update set
        "HK_PORT" = DBT_INTERNAL_SOURCE."HK_PORT","PORT_CD_BK" = DBT_INTERNAL_SOURCE."PORT_CD_BK","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR"
    

    when not matched then insert
        ("HK_PORT", "PORT_CD_BK", "LDTS", "RCSR")
    values
        ("HK_PORT", "PORT_CD_BK", "LDTS", "RCSR")

;
    commit;