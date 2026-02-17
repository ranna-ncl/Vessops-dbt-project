-- back compat for old kwarg name
  
  begin;
    
        
            
                
                
            
                
                
            
                
                
            
        
    

    

    merge into VESSOPS_D.L00_STG.sat_vfm_hub_vessel_details as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.sat_vfm_hub_vessel_details__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                    DBT_INTERNAL_SOURCE.HK_VESSEL = DBT_INTERNAL_DEST.HK_VESSEL
                ) and (
                    DBT_INTERNAL_SOURCE.HASHDIFF = DBT_INTERNAL_DEST.HASHDIFF
                ) and (
                    DBT_INTERNAL_SOURCE.LDTS = DBT_INTERNAL_DEST.LDTS
                )

    
    when matched then update set
        "HK_VESSEL" = DBT_INTERNAL_SOURCE."HK_VESSEL","HASHDIFF" = DBT_INTERNAL_SOURCE."HASHDIFF","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR","BRAND" = DBT_INTERNAL_SOURCE."BRAND","SHIP_NAME" = DBT_INTERNAL_SOURCE."SHIP_NAME","SHIP_CLASS" = DBT_INTERNAL_SOURCE."SHIP_CLASS","SHIP_CD" = DBT_INTERNAL_SOURCE."SHIP_CD","VESSELID" = DBT_INTERNAL_SOURCE."VESSELID"
    

    when not matched then insert
        ("HK_VESSEL", "HASHDIFF", "LDTS", "RCSR", "BRAND", "SHIP_NAME", "SHIP_CLASS", "SHIP_CD", "VESSELID")
    values
        ("HK_VESSEL", "HASHDIFF", "LDTS", "RCSR", "BRAND", "SHIP_NAME", "SHIP_CLASS", "SHIP_CD", "VESSELID")

;
    commit;