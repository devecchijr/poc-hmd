Class Custom.EHRInterop.DSP.View.RadOrder Extends %RegisteredObject
{

ClassMethod GetRadOrdersByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
	Set tSQL =	"SELECT "_
					"RAD_PK, "_
					"RAD_PID, "_
					"RAD_FID, "_
                    "RAD_PAT_FK, "_
                    "RAD_ENC_FK, "_
                    "RAD_ORD_DAT, "_
                    "RAD_COD, "_
                    "RAD_DSC, "_
                    "case rad_sta when 'CA-CANCELADO' then 'CA' when 'TE-RECIBIDO/TERMINADO' then 'CM' else rad_sta end as RAD_STA, "_
                    "RAD_CLI_COD, "_
                    "RAD_CLI_CONS_COD, "_
                    "RAD_CLI_CONS_DSC, "_
                    "RAD_CLI_NAM, "_
                    "RAD_RES_BDT, "_
                    "RAD_RES_BOD, "_
                    "RAD_RES_NAM, "_
                    "RAD_RES_DAT, "_
                    "(select enc_fac_cod from hs_encounter where enc_pk = rad_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = rad_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM HS_RAD_ORDER "_
				"WHERE RAD_PAT_FK = ? "
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND RAD_ENC_FK = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND RAD_PK = ? "

	Quit tSQL
}

ClassMethod TriggerRADByDate() As %String
{
	Set tSQL = "SELECT TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Rad Order */ "_
				"select "_
				"rad_pk ENTITY_ID, "_
				"rad_pat_fk PATIENT_ID, "_
				"rad_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,RAD' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(rad_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(rad_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(rad_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM ( "_
				"SELECT rad_pk, rad_pat_fk, rad_enc_fk, rad_tr1_dat, rad_tr2_dat, rad_tr3_dat FROM hs_rad_order WHERE rad_tr1_dat > TO_DATE(?) AND rad_tr1_dat <= CURRENT "_
				"UNION "_
				"SELECT rad_pk, rad_pat_fk, rad_enc_fk, rad_tr1_dat, rad_tr2_dat, rad_tr3_dat FROM hs_rad_order WHERE rad_tr2_dat > TO_DATE(?) AND rad_tr2_dat <= CURRENT "_
				"UNION "_
				"SELECT rad_pk, rad_pat_fk, rad_enc_fk, rad_tr1_dat, rad_tr2_dat, rad_tr3_dat FROM hs_rad_order WHERE rad_tr3_dat > TO_DATE(?) AND rad_tr3_dat <= CURRENT "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	/*Set tSQL = "SELECT TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				" Rad Order "_
				"select "_
				"rad_pk ENTITY_ID, "_
				"rad_pat_fk PATIENT_ID, "_
				"rad_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,RAD' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(rad_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(rad_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(rad_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_rad_order "_
				"WHERE (1=0 "_
				"OR (rad_tr1_dat > TO_DATE(?) AND rad_tr1_dat <= CURRENT) "_
				"OR (rad_tr2_dat > TO_DATE(?) AND rad_tr2_dat <= CURRENT) "_
				"OR (rad_tr3_dat > TO_DATE(?) AND rad_tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "*/
				
	Quit tSQL
}

}
