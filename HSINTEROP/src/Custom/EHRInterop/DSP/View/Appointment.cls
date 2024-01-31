Class Custom.EHRInterop.DSP.View.Appointment Extends %RegisteredObject
{

ClassMethod GetAppointmentsByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL = "SELECT "_
						"APT_PK, "_
						"APT_PAT_FK, "_
						"APT_ENC_FK, "_
						"APT_CLI_COD, "_
						"APT_CLI_CONS_COD, "_
						"APT_CLI_CONS_DSC, "_
						"APT_CLI_NAM, "_
						"(case when length(APT_LOC_DSC) > 0 then APT_LOC_COD else '' end) APT_LOC_COD, "_
						"APT_LOC_DSC, "_
						"APT_DAT, "_
						"APT_NSH, "_
						"APT_STA, "_
						"APT_TYP_COD, "_
						"APT_TYP_DSC, "_
						"APT_ITE_COD, "_
						"APT_ITE_DSC, "_
						"APT_TXT, "_
                    "(select enc_fac_cod from hs_encounter where enc_pk = apt_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = apt_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM hs_appointment "_
				"WHERE apt_pat_fk = ? "
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND apt_enc_fk = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND apt_pk = ? "
  	
  	Quit tSQL
}

ClassMethod TriggerAPTByDate() As %String
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
				"/* Appointment */ "_
				"select "_
				"apt_pk ENTITY_ID, "_
				"apt_pat_fk PATIENT_ID, "_
				"apt_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,APT' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				;"/*NVL(apt_tr1_dat, TO_DATE('1900-01-01 00:00:00')),*/ "_
				"NVL(apt_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(apt_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_appointment "_
				"WHERE (1=0 "_
				;"/*OR (apt_tr1_dat > TO_DATE(?) AND apt_tr1_dat <= CURRENT)*/ "_
				"OR (apt_tr2_dat > TO_DATE(?) AND apt_tr2_dat <= CURRENT) "_
				"OR (apt_tr3_dat > TO_DATE(?) AND apt_tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	Quit tSQL
}

}
