Class Custom.EHRInterop.DSP.View.Observation Extends %RegisteredObject
{

ClassMethod GetObservationsByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL =	"SELECT "_
					"OBS_PK, "_
					"OBS_PAT_FK, "_
					"OBS_ENC_FK, "_
					"OBS_CLI_COD, "_
					"OBS_CLI_CONS_COD, "_
					"OBS_CLI_CONS_DSC, "_
					"OBS_CLI_NAM, "_
					"OBS_COD, "_
					"replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(OBS_DSC,'á','a'),'Á','A'),'é','e'),'É','E'),'í','i'),'Í','I'),'ó','o'),'Ó','O'),'ú','u'),'Ú','U') OBS_DSC, "_
					"OBS_VAL, "_
					"OBS_UNT_COD, "_
					"OBS_UNT_DSC, "_
					"OBS_STA, "_
					"OBS_DAT, "_
					"(select enc_fac_cod from hs_encounter where enc_pk = obs_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = obs_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM HS_OBSERVATION "_
				"WHERE OBS_PAT_FK = ? "
				
				
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND OBS_ENC_FK = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND OBS_PK = ? "

	Quit tSQL
}

ClassMethod TriggerOBSByDate() As %String
{
	set tSQL = "SELECT "_
				"TRIM(PATIENT_ID || '_' || ENTITY_TYPE || '_' || ENTITY_ID || '_' || TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S')) INFO_ID, "_
				"ENTITY_ID, "_
				"PATIENT_ID, "_
				"ENCOUNTER_ID, "_
				"ENTITY_TYPE, "_
				"TO_CHAR(ENTITY_DATE, '%Y-%m-%d %H:%M:%S') ENTITY_DATE FROM ( "_
				"SELECT first ? * FROM ( "_
				"/* Observation */ "_
				"select "_
				"obs_pk ENTITY_ID, "_
				"obs_pat_fk PATIENT_ID, "_
				"obs_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,OBS' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(obs_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(obs_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(obs_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM ( "_
				"SELECT * FROM hs_observation WHERE obs_tr1_dat > TO_DATE(?) AND obs_tr1_dat <= CURRENT "_
				"UNION "_
				"SELECT * FROM hs_observation WHERE obs_tr2_dat > TO_DATE(?) AND obs_tr2_dat <= CURRENT "_
				"UNION "_
				"SELECT * FROM hs_observation WHERE obs_tr3_dat > TO_DATE(?) AND obs_tr3_dat <= CURRENT "_
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
				;" Observation "_
				"select "_
				"obs_pk ENTITY_ID, "_
				"obs_pat_fk PATIENT_ID, "_
				"obs_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,OBS' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(obs_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(obs_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(obs_tr3_dat, TO_DATE('1900-01-01 00:00:00')) "_
				")) ENTITY_DATE "_
				"FROM hs_observation "_
				"WHERE (1=0 "_
				"OR (obs_tr1_dat > TO_DATE(?) AND obs_tr1_dat <= CURRENT) "_
				"OR (obs_tr2_dat > TO_DATE(?) AND obs_tr2_dat <= CURRENT) "_
				"OR (obs_tr3_dat > TO_DATE(?) AND obs_tr3_dat <= CURRENT) "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "*/
				
	Quit tSQL
}

}
