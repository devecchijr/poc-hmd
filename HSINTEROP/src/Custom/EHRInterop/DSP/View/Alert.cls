Class Custom.EHRInterop.DSP.View.Alert Extends %RegisteredObject
{

ClassMethod GetAlertsByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL = "SELECT "_
						"AL_PK as ALT_PK, "_
						"ALT_PAT_FK, "_
						"ALT_ENC_FK, "_
						"ALT_TYP_COD, "_
						"ALT_TYP_DSC, "_
						"ALT_COD, "_
						"ALT_DSC, "_
						"ALT_STA, "_
						"ALT_DAT, "_
						"ALT_CLI_COD, "_
						"ALT_CLI_CONS_COD, "_
						"ALT_CLI_CONS_DSC, "_
						"ALT_CLI_NAM, "_
                    "(select enc_fac_cod from hs_encounter where enc_pk = alt_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = alt_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM hs_alert "_
				"WHERE alt_pat_fk = ? "
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND alt_enc_fk = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND al_pk = ? "
  	
  	Quit tSQL
}

ClassMethod TriggerALTByDate() As %String
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
				"/* Alert */ "_
				"select "_
				"al_pk ENTITY_ID, "_
				"alt_pat_fk PATIENT_ID, "_
				"alt_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,ALT' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				;"/*NVL(alt_tr1_dat, TO_DATE('1900-01-01 00:00:00')),*/ "_
				"NVL(alt_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(alt_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_alert "_
				"WHERE (1=0 "_
				;"/*OR (alt_tr1_dat > TO_DATE(?) AND alt_tr1_dat <= CURRENT)*/ "_
				"OR (alt_tr2_dat > TO_DATE(?) AND alt_tr2_dat <= CURRENT) "_
				"OR (alt_tr3_dat > TO_DATE(?) AND alt_tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	Quit tSQL
}

}
