-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into VESSOPS_D.L00_STG.lnk_vfm_oci_ou_voyage_account as DBT_INTERNAL_DEST
        using VESSOPS_D.L00_STG.lnk_vfm_oci_ou_voyage_account__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.HK_LNK_OU_VOYAGE_ACCOUNT = DBT_INTERNAL_DEST.HK_LNK_OU_VOYAGE_ACCOUNT))

    
    when matched then update set
        "HK_LNK_OU_VOYAGE_ACCOUNT" = DBT_INTERNAL_SOURCE."HK_LNK_OU_VOYAGE_ACCOUNT","HK_OPERATING_UNIT" = DBT_INTERNAL_SOURCE."HK_OPERATING_UNIT","HK_VOYAGE" = DBT_INTERNAL_SOURCE."HK_VOYAGE","HK_ACCOUNT" = DBT_INTERNAL_SOURCE."HK_ACCOUNT","LDTS" = DBT_INTERNAL_SOURCE."LDTS","RCSR" = DBT_INTERNAL_SOURCE."RCSR"
    

    when not matched then insert
        ("HK_LNK_OU_VOYAGE_ACCOUNT", "HK_OPERATING_UNIT", "HK_VOYAGE", "HK_ACCOUNT", "LDTS", "RCSR")
    values
        ("HK_LNK_OU_VOYAGE_ACCOUNT", "HK_OPERATING_UNIT", "HK_VOYAGE", "HK_ACCOUNT", "LDTS", "RCSR")

;
    commit;