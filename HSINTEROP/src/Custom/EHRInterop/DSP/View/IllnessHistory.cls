Class Custom.EHRInterop.DSP.View.IllnessHistory Extends %RegisteredObject
{

ClassMethod GetIllnessHistoriesByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
	//TODO: Remplazar los subselects por JOIN cuando los indexes estuvieren OK
    Set tSQL =	"SELECT "_
                    "ILL_PK, "_
                    "ILL_PAT_FK, "_
                    "ILL_ENC_FK, "_
                    "ILL_CLI_COD, "_
                    "ILL_CLI_CONS_COD, "_
                    "ILL_CLI_CONS_DSC, "_
                    "ILL_CLI_NAM, "_
                    "ILL_COD, "_
                    "ILL_DSC, "_
                    "ILL_NOT, "_
                    "ILL_STA, "_
                    "ILL_DAT, "_
                    "(select enc_fac_cod from hs_encounter where enc_pk = ill_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = ill_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
                "FROM HS_ILLNESS_HISTORY "_
				"WHERE ILL_PAT_FK = ? "
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND ILL_ENC_FK = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND ILL_PK = ? "
	
	Quit tSQL
}

ClassMethod TriggerILLByDate() As %String
{
	Set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Illness History */ "_
				"select "_
				"ill_pk ENTITY_ID, "_
				"ill_pat_fk PATIENT_ID, "_
				"ill_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,ILL' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(ill_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(ill_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(ill_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_illness_history "_
				"WHERE (1=0 "_
				"OR (ill_tr1_dat > TO_DATE(?) AND ill_tr1_dat <= CURRENT) "_
				"OR (ill_tr2_dat > TO_DATE(?) AND ill_tr2_dat <= CURRENT) "_
				"OR (ill_tr3_dat > TO_DATE(?) AND ill_tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
	Quit tSQL
}

}
