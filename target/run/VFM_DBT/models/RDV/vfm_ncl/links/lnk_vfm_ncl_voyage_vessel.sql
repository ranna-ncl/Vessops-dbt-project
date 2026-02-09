-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L00_STG.lnk_vfm_ncl_voyage_vessel as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.lnk_vfm_ncl_voyage_vessel__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_LNK_VOYAGE_VESSEL = DBT_INTERNAL_DEST.HK_LNK_VOYAGE_VESSEL))

    
    when matched then update set
        "HK_LNK_VOYAGE_VESSEL" = DBT_INTERNAL_SOURCE."HK_LNK_VOYAGE_VESSEL","HK_VOYAGE" = DBT_INTERNAL_SOURCE."HK_VOYAGE","HK_VESSEL" = DBT_INTERNAL_SOURCE."HK_VESSEL","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR"
    

    when not matched then insert
        ("HK_LNK_VOYAGE_VESSEL", "HK_VOYAGE", "HK_VESSEL", "LDTS", "RCSR")
    values
        ("HK_LNK_VOYAGE_VESSEL", "HK_VOYAGE", "HK_VESSEL", "LDTS", "RCSR")

;
    commit;