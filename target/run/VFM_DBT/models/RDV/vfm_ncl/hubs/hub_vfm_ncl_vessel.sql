-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L00_STG.hub_vfm_ncl_vessel as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.hub_vfm_ncl_vessel__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_VESSEL = DBT_INTERNAL_DEST.HK_VESSEL))

    
    when matched then update set
        "HK_VESSEL" = DBT_INTERNAL_SOURCE."HK_VESSEL","VESSEL_IMO" = DBT_INTERNAL_SOURCE."VESSEL_IMO","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR"
    

    when not matched then insert
        ("HK_VESSEL", "VESSEL_IMO", "LDTS", "RCSR")
    values
        ("HK_VESSEL", "VESSEL_IMO", "LDTS", "RCSR")

;
    commit;