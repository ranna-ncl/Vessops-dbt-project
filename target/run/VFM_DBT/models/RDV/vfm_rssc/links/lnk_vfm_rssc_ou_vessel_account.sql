-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L10_RDV.lnk_vfm_rssc_ou_vessel_account as DBT_INTERNAL_DEST
        using VESSOPS_D.L10_RDV.lnk_vfm_rssc_ou_vessel_account__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_LNK_OU_VESSEL_ACCOUNT = DBT_INTERNAL_DEST.HK_LNK_OU_VESSEL_ACCOUNT))

    
    when matched then update set
        "HK_LNK_OU_VESSEL_ACCOUNT" = DBT_INTERNAL_SOURCE."HK_LNK_OU_VESSEL_ACCOUNT","HK_OPERATING_UNIT" = DBT_INTERNAL_SOURCE."HK_OPERATING_UNIT","HK_VESSEL" = DBT_INTERNAL_SOURCE."HK_VESSEL","HK_ACCOUNT" = DBT_INTERNAL_SOURCE."HK_ACCOUNT","LDTS" = DBT_INTERNAL_SOURCE."LDTS","REC_SRC" = DBT_INTERNAL_SOURCE."REC_SRC"
    

    when not matched then insert
        ("HK_LNK_OU_VESSEL_ACCOUNT", "HK_OPERATING_UNIT", "HK_VESSEL", "HK_ACCOUNT", "LDTS", "REC_SRC")
    values
        ("HK_LNK_OU_VESSEL_ACCOUNT", "HK_OPERATING_UNIT", "HK_VESSEL", "HK_ACCOUNT", "LDTS", "REC_SRC")

;
    commit;