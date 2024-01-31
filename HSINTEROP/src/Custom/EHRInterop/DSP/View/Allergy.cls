Class Custom.EHRInterop.DSP.View.Allergy Extends %RegisteredObject
{

ClassMethod GetAllergyByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL = "SELECT "_
						"ALG_PK as ALG_PK, "_
						"ALG_PAT_FK, "_
						"ALG_ENC_FK, "_
						"ALG_TYP_COD, "_
						"ALG_TYP_DSC, "_
						"ALG_REA_COD, "_
						"ALG_REA_DSC, "_
						"ALG_SEV_COD, "_
						"ALG_SEV_DSC, "_
						"ALG_CER_COD, "_
						"ALG_CER_DSC, "_
						"ALG_COD, "_
						"ALG_DSC, "_
						"ALG_DAT, "_
						"ALG_TXT, "_
						"ALG_OBS, "_
						"ALG_CLI_COD, "_
						"ALG_CLI_CONS_COD, "_
						"ALG_CLI_CONS_DSC, "_
						"ALG_BEG_DAT, "_
						"ALG_END_DAT, "_
						"ALG_LST_DAT, "_
						"ALG_INA_DAT, "_
						"ALG_CLI_NAM, "_
                    "(select enc_fac_cod from hs_encounter where enc_pk = alg_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = alg_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM hs_allergy "_
				"WHERE alg_pat_fk = ? "
				
	//Set:pIncludeWhereByEnc tSQL = tSQL_"AND alg_enc_fk = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND alg_pk = ? "
  	
  	Quit tSQL
}

ClassMethod TriggerALGByDate() As %String
{
	set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE "_
				"FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Allergy */ "_
				"select "_
				"alg_pk ENTITY_ID, "_
				"alg_pat_fk PATIENT_ID, "_
				"alg_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,ALG' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				;"/*NVL(ALG_tr1_dat, TO_DATE('1900-01-01 00:00:00')),*/ "_
				"NVL(ALG_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(ALG_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_allergy "_
				"WHERE (1=0 "_
				;"/*OR (alg_tr1_dat > TO_DATE(?) AND alg_tr1_dat <= CURRENT)*/ "_
				"OR (alg_tr2_dat > TO_DATE(?) AND alg_tr2_dat <= CURRENT) "_
				"OR (alg_tr3_dat > TO_DATE(?) AND alg_tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	Quit tSQL
}

}
