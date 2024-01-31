Class Custom.EHRInterop.DSP.View.SocialHistory Extends %RegisteredObject
{

ClassMethod GetSocialHistoriesByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL =	"SELECT "_
                    "SOC_PK, "_
                    "SOC_PAT_FK, "_
                    "SOC_ENC_FK, "_
                    "SOC_DAT, "_
                    "SOC_CLI_COD, "_
                    "SOC_CLI_CONS_COD, "_
                    "SOC_CLI_CONS_DSC, "_
                    "SOC_CLI_NAM, "_
                    "SOC_COD, "_
                    "SOC_DSC, "_
                    "SOC_NOT, "_
                    "(select enc_fac_cod from hs_encounter where enc_pk = soc_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = soc_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
                "FROM HS_SOCIAL_HISTORY "_
				"WHERE SOC_PAT_FK = ? "
    
    Set:pIncludeWhereByEnc tSQL = tSQL_"AND SOC_ENC_FK = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND SOC_PK = ? "
	
	Quit tSQL
}

ClassMethod TriggerSOCByDate() As %String
{
	Set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Social History */ "_
				"select "_
				"soc_pk ENTITY_ID, "_
				"soc_pat_fk PATIENT_ID, "_
				"soc_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,SOC' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(soc_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(soc_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(soc_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_social_history "_
				"WHERE (1=0 "_
				"OR (soc_tr1_dat > TO_DATE(?) AND soc_tr1_dat <= CURRENT) "_
				"OR (soc_tr2_dat > TO_DATE(?) AND soc_tr2_dat <= CURRENT) "_
				"OR (soc_tr3_dat > TO_DATE(?) AND soc_tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	Quit tSQL
}

}
