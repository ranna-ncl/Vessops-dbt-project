-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L00_STG.hub_vfm_oci_operating_unit as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.hub_vfm_oci_operating_unit__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_OPERATING_UNIT = DBT_INTERNAL_DEST.HK_OPERATING_UNIT))

    
    when matched then update set
        "HK_OPERATING_UNIT" = DBT_INTERNAL_SOURCE."HK_OPERATING_UNIT","OPERATING_UNIT_BK" = DBT_INTERNAL_SOURCE."OPERATING_UNIT_BK","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR"
    

    when not matched then insert
        ("HK_OPERATING_UNIT", "OPERATING_UNIT_BK", "LDTS", "RCSR")
    values
        ("HK_OPERATING_UNIT", "OPERATING_UNIT_BK", "LDTS", "RCSR")

;
    commit;