Class Custom.EHRInterop.DSP.View.Vaccination Extends %RegisteredObject
{

ClassMethod GetVaccinationsByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL =	"SELECT "_
					"VAC_PK, "_
                    "VAC_PAT_FK, "_
                    "VAC_ENC_FK, "_
                    "VAC_PSC_COD, "_
                    "VAC_COD, "_
                    "VAC_DSC, "_
                    "VAC_ROU_COD, "_
                    "VAC_ROU_DSC, "_
                    "VAC_DOS_VAL, "_
                    "VAC_UNI_COD, "_
                    "VAC_UNI_DSC, "_
                    "VAC_cat_cod as COD_CATEGORIA_VAC_PRESCR, "_
                    "VAC_cat_dsc as CATEGORIA_VAC_PRESCR, "_
                    "VAC_FRQ_COD, "_
                    "VAC_FRQ_DSC, "_
                    "VAC_apr_cod, "_
                    "VAC_apr_dsc, "_
                    "VAC_DAT, "_
                    "VAC_beg_dat as DATA_VAC_PRESCR_INICIO, "_
                    "VAC_end_dat as DATA_VAC_PRESCR_FIM, "_
                    "VAC_dur_val as DURACAO, "_
                    "VAC_CLI_COD, "_
                    "VAC_CLI_CONS_COD, "_
                    "VAC_CLI_CONS_DSC, "_
                    "VAC_CLI_NAM, "_
                    "VAC_STA, "_
                    "VAC_sta as STATUS_VAC_PRESCR, "_
                    "VAC_dat as DATA_REGISTRO, "_
                    "VAC_dat as DATA_REGISTRO_ATUALIZ, "_
                    "VAC_dat as DATA_REGISTRO_LIB, "_
                    "VAC_dat as DATA_REGISTRO_SUSPENSAO, "_
                    "(select enc_fac_cod from hs_encounter where enc_pk = VAC_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = VAC_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM HS_VACCINATION "_
				"WHERE VAC_PAT_FK = ? "
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND VAC_ENC_FK = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND VAC_PK = ? "

	Quit tSQL
}

ClassMethod TriggerMEDByDate() As %String
{
	set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Medication */ "_
				"select "_
				"VAC_pk ENTITY_ID, "_
				"VAC_pat_fk PATIENT_ID, "_
				"VAC_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,MED' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(VAC_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(VAC_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(VAC_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM ( "_
				"SELECT * FROM hs_medication WHERE VAC_tr1_dat > TO_DATE(?) AND VAC_tr1_dat <= CURRENT "_
				"UNION "_
				"SELECT * FROM hs_medication WHERE VAC_tr2_dat > TO_DATE(?) AND VAC_tr2_dat <= CURRENT "_
				"UNION "_
				"SELECT * FROM hs_medication WHERE VAC_tr3_dat > TO_DATE(?) AND VAC_tr3_dat <= CURRENT "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	/*set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				;" Medication "_
				"select "_
				"VAC_pk ENTITY_ID, "_
				"VAC_pat_fk PATIENT_ID, "_
				"VAC_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,MED' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(VAC_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(VAC_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(VAC_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_medication "_
				"WHERE (1=0 "_
				"OR (VAC_tr1_dat > TO_DATE(?) AND VAC_tr1_dat <= CURRENT) "_
				"OR (VAC_tr2_dat > TO_DATE(?) AND VAC_tr2_dat <= CURRENT) "_
				"OR (VAC_tr3_dat > TO_DATE(?) AND VAC_tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "*/
				
	Quit tSQL
}

}
