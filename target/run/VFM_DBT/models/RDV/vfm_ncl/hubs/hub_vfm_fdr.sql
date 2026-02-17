-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L00_STG_L10_RDV.hub_vfm_fdr as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG_L10_RDV.hub_vfm_fdr__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_FDR = DBT_INTERNAL_DEST.HK_FDR))

    
    when matched then update set
        "HK_FDR" = DBT_INTERNAL_SOURCE."HK_FDR","FDR_BK" = DBT_INTERNAL_SOURCE."FDR_BK","LDTS" = DBT_INTERNAL_SOURCE."LDTS","REC_SRC" = DBT_INTERNAL_SOURCE."REC_SRC"
    

    when not matched then insert
        ("HK_FDR", "FDR_BK", "LDTS", "REC_SRC")
    values
        ("HK_FDR", "FDR_BK", "LDTS", "REC_SRC")

;
    commit;