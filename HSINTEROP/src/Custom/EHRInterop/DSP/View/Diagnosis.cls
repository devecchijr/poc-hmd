Class Custom.EHRInterop.DSP.View.Diagnosis Extends %RegisteredObject
{

ClassMethod GetDiagnosesByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL =	"SELECT "_
					"DXG_PK, "_
					"DXG_ENC_FK, "_
					"DXG_PAT_FK, "_
					"DXG_TYP, "_
					"DXG_COD, "_
					"DXG_DSC, "_
					"DXG_DAT, "_
					"DXG_CLI_COD, "_
					"DXG_CLI_CONS_COD, "_
					"DXG_CLI_CONS_DSC, "_
					"DXG_CLI_NAM, "_
					"DXG_DAT, "_
					"DXG_STA, "_
					"DXG_TYP_COD, "_
					"DXG_TYP_DSC, "_
					"DXG_PRI, "_
					"CASE DXG_ADM WHEN 'TRUE' THEN 1 ELSE 0 END as DXG_ADM, "_
					"CASE DXG_DCH WHEN 'TRUE' THEN 1 ELSE 0 END as DXG_DCH, "_
					"(select enc_fac_cod from hs_encounter where enc_pk = dxg_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = dxg_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM hs_diagnosis "_
				"WHERE dxg_pat_fk = ? "
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND dxg_enc_fk = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND dxg_pk = ? "
						
	Quit tSQL
}

ClassMethod TriggerDXGByDate() As %String
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
				"/* Diagnosis */ "_
				"select "_
				"dxg_pk ENTITY_ID, "_
				"dxg_pat_fk PATIENT_ID, "_
				"dxg_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,DXG' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(dxg_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(dxg_tr2_dat, TO_DATE('1900-01-01 00:00:00')), "_
				;"/*NVL(dxg_tr3_dat, TO_DATE('1900-01-01 00:00:00'))*/ "_
				")) ENTITY_DATE "_
				"FROM hs_diagnosis "_
				"WHERE (1=0 "_
				"OR (dxg_tr1_dat > TO_DATE(?) AND dxg_tr1_dat <= CURRENT) "_
				"OR (dxg_tr2_dat > TO_DATE(?) AND dxg_tr2_dat <= CURRENT) "_
				;"/*OR (dxg_tr3_dat > TO_DATE(?) AND dxg_tr3_dat <= CURRENT)*/ "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	Quit tSQL
}

}
