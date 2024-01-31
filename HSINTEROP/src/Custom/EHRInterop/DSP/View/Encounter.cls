Class Custom.EHRInterop.DSP.View.Encounter Extends %RegisteredObject
{

ClassMethod GetEncountersByPat(pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL =	"SELECT "_
					"enc_pk, "_
					"enc_pat_fk, "_
					"enc_adm_dat, "_
					"trim(enc_typ) as enc_typ, "_
					"trim(enc_fac_cod) as enc_fac_cod, "_
					"trim(enc_fac_dsc) as enc_fac_dsc, "_
					"trim(enc_ins_cod) as enc_ins_cod, "_
					"trim(enc_ins_dsc) as enc_ins_dsc, "_
					"trim(enc_spe_cod) as enc_spe_cod, "_
					"trim(enc_spe_dsc) as enc_spe_dsc, "_
					"enc_dis_dat, "_
					"trim(enc_wrd) as enc_wrd, "_
					"trim(enc_bed) as enc_bed, "_
					"enc_cli_cod, "_
					"enc_cli_cons_cod, "_
					"enc_cli_cons_dsc, "_
					"enc_cli_nam "_
				"FROM hs_encounter "_
				"WHERE enc_pat_fk = ? "
				
	Set:pIncludeWhereByPK tSQL = tSQL_"AND enc_pk = ? "
	
	Quit tSQL
}

ClassMethod TriggerENCByDate() As %String
{
	set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Encounter */ "_
				"select "_
				"enc_pk ENTITY_ID, "_
				"enc_pat_fk PATIENT_ID, "_
				"enc_pk ENCOUNTER_ID, "_
				"'PAT,ENC' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(enc_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(enc_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(enc_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_encounter "_
				"WHERE (1=0 "_
				"OR (enc_tr1_dat > TO_DATE(?) AND enc_tr1_dat <= CURRENT) "_
				"OR (enc_tr2_dat > TO_DATE(?) AND enc_tr2_dat <= CURRENT) "_
				"OR (enc_tr3_dat > TO_DATE(?) AND enc_tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "

	Quit tSQL
}

}
