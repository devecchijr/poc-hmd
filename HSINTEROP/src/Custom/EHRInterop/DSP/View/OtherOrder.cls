Class Custom.EHRInterop.DSP.View.OtherOrder Extends %RegisteredObject
{

ClassMethod GetOtherOrdersByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
	//TODO: Remplazar los subselects por JOIN cuando los indexes estuvieren OK
    Set tSQL =	"SELECT "_
					"OTH_PK, "_
					"OTH_PID, "_
					"OTH_FID, "_
                    "OTH_PAT_FK, "_
                    "OTH_ENC_FK, "_
                    "OTH_ORD_DAT, "_
                    "OTH_COD, "_
                    "OTH_DSC, "_
                    "OTH_RES_NAM, "_
                    "case oth_sta when 'CA-CANCELADO' then 'CA' when 'TE-RECIBIDO/TERMINADO' then 'CM' else oth_sta end as OTH_STA, "_
                    "OTH_CLI_COD as OTH_CLI_COD, "_
                    "OTH_CLI_CONS_COD, "_
                    "OTH_CLI_CONS_DSC, "_
                    "OTH_CLI_NAM, "_
                    "OTH_RES_BDT, "_
                    "(select enc_fac_cod from hs_encounter where enc_pk = oth_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = oth_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM HS_OTHER_ORDER "_
				"WHERE OTH_PAT_FK = ? "
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND OTH_ENC_FK = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND OTH_PK = ? "

	Quit tSQL
}

ClassMethod TriggerOTHByDate() As %String
{
	Set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Other Order */ "_
				"select "_
				"oth_pk ENTITY_ID, "_
				"oth_pat_fk PATIENT_ID, "_
				"oth_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,OTH' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST("_
				"TO_DATE('1900-01-01 00:00:00'), "_
				"NVL(oth_tr1_dat, TO_DATE('1900-01-01 00:00:00')) "_
				;"/*NVL(oth_tr2_dat, TO_DATE('1900-01-01 00:00:00'))*/ "_
				")) ENTITY_DATE "_
				"FROM hs_other_order "_
				"WHERE (1=0 "_
				"OR (oth_tr1_dat > TO_DATE(?) AND oth_tr1_dat <= CURRENT) "_
				;"/*OR (oth_tr2_dat > TO_DATE(?) AND oth_tr2_dat <= CURRENT)*/ "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	Quit tSQL
}

}
