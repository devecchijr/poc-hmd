Class Custom.EHRInterop.DSP.View.FamilyHistory Extends %RegisteredObject
{

ClassMethod GetFamilyHistoriesByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL =	"SELECT "_
                    "FAM_PK, "_
                    "FAM_PAT_FK, "_
                    "FAM_ENC_FK, "_
                    "FAM_CLI_COD, "_
                    "FAM_CLI_CONS_COD, "_
                    "FAM_CLI_CONS_DSC, "_
                    "FAM_CLI_NAM, "_
                    "FAM_DAT, "_
                    "FAM_NOT, "_
                    "FAM_STA, "_
                    "CASE WHEN fam_kin_cod = '' then 'o' else fam_kin_cod end as FAM_KIN_COD, "_
                    "CASE WHEN fam_kin_dsc = '' then 'otros' else fam_kin_dsc end as FAM_KIN_DSC, "_
                    "(select enc_fac_cod from hs_encounter where enc_pk = fam_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = fam_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
                "FROM HS_FAMILY_HISTORY "_
				"WHERE FAM_PAT_FK = ? "
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND FAM_ENC_FK = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND FAM_PK = ? "
	
	Quit tSQL
}

ClassMethod TriggerFAMByDate() As %String
{
	Set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE "_
				"FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Family History */ "_
				"select "_
				"fam_pk ENTITY_ID, "_
				"fam_pat_fk PATIENT_ID, "_
				"fam_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,FAM' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(fam__tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(fam__tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(fam__tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_family_history "_
				"WHERE (1=0 "_
				"OR (fam__tr1_dat > TO_DATE(?) AND fam__tr1_dat <= CURRENT) "_
				"OR (fam__tr2_dat > TO_DATE(?) AND fam__tr2_dat <= CURRENT) "_
				"OR (fam__tr3_dat > TO_DATE(?) AND fam__tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	Quit tSQL
}

}
