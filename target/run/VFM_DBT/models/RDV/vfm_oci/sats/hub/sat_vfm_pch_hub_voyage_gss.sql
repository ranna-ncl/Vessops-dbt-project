-- back compat for old kwarg name
  
  begin;
    
        
            
                
                
            
                
                
            
                
                
            
        
    

    

    merge into VESSOPS_D.L00_STG.sat_vfm_pch_hub_voyage_gss as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.sat_vfm_pch_hub_voyage_gss__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                    DBT_INTERNAL_SOURCE.HK_VOYAGE = DBT_INTERNAL_DEST.HK_VOYAGE
                ) and (
                    DBT_INTERNAL_SOURCE.HASHDIFF = DBT_INTERNAL_DEST.HASHDIFF
                ) and (
                    DBT_INTERNAL_SOURCE.LDTS = DBT_INTERNAL_DEST.LDTS
                )

    
    when matched then update set
        "HK_VOYAGE" = DBT_INTERNAL_SOURCE."HK_VOYAGE","HASHDIFF" = DBT_INTERNAL_SOURCE."HASHDIFF","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR","VOYAGE_CD" = DBT_INTERNAL_SOURCE."VOYAGE_CD","GSS_SATISFIED" = DBT_INTERNAL_SOURCE."GSS_SATISFIED"
    

    when not matched then insert
        ("HK_VOYAGE", "HASHDIFF", "LDTS", "RCSR", "VOYAGE_CD", "GSS_SATISFIED")
    values
        ("HK_VOYAGE", "HASHDIFF", "LDTS", "RCSR", "VOYAGE_CD", "GSS_SATISFIED")

;
    commit;