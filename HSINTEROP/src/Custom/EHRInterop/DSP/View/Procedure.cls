Class Custom.EHRInterop.DSP.View.Procedure Extends %RegisteredObject
{

ClassMethod GetProceduresByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL =	"SELECT "_
					"PRC_PK, "_
					"PRC_ENC_FK, "_
					"PRC_PAT_FK, "_
					"PRC_COD, "_
					"PRC_DSC, "_
					"PRC_TYP_COD, "_
					"PRC_TYP_DSC, "_
					"PRC_DAT, "_
					"PRC_CLI_COD, "_
					"PRC_CLI_CONS_COD, "_
					"PRC_CLI_CONS_DSC, "_
					"PRC_CLI_NAM, "_
					"(select enc_fac_cod from hs_encounter where enc_pk = prc_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = prc_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM HS_PROCEDURE "_
				"WHERE PRC_PAT_FK = ? "
	
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND PRC_ENC_FK = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND PRC_PK = ? "
						
	Quit tSQL
}

ClassMethod TriggerPRCByDate() As %String
{
	set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Procedure */ "_
				"select "_
				"prc_pk ENTITY_ID, "_
				"prc_pat_fk PATIENT_ID, "_
				"prc_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,PRC' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(prc_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(prc_tr2_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM ( "_
				"SELECT * FROM hs_procedure WHERE prc_tr1_dat > TO_DATE(?) AND prc_tr1_dat <= CURRENT "_
				"UNION "_
				"SELECT * FROM hs_procedure WHERE prc_tr2_dat > TO_DATE(?) AND prc_tr2_dat <= CURRENT "_
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
				;" Procedure  "_
				"select "_
				"prc_pk ENTITY_ID, "_
				"prc_pat_fk PATIENT_ID, "_
				"prc_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,PRC' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(prc_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(prc_tr2_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_procedure "_
				"WHERE (1=0 "_
				"OR (prc_tr1_dat > TO_DATE(?) AND prc_tr1_dat <= CURRENT) "_
				"OR (prc_tr2_dat > TO_DATE(?) AND prc_tr2_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "*/
				
	Quit tSQL
}

}
