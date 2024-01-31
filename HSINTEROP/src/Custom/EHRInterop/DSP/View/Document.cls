Class Custom.EHRInterop.DSP.View.Document Extends %RegisteredObject
{

ClassMethod GetDocumentsByPat(pIncludeWhereByEnc As %Boolean, pIncludeWhereByPK As %Boolean) As %String
{
    Set tSQL =	"SELECT "_
					"DOC_PK, "_
					"DOC_PAT_FK, "_
					"DOC_ENC_FK, "_
					"DOC_TYP_COD, "_
					"DOC_TYP_COD AS DOC_TYP_DSC, "_
					"DOC_NAM, "_
					"DOC_DAT, "_
					"DOC_CLI_COD, "_
					"DOC_CLI_CONS_COD, "_
					"DOC_CLI_CONS_DSC, "_
					"DOC_CLI_NAM, "_
					"DOC_BDT, "_
					"DOC_BOD, "_
					"DOC_STA, "_
					"(select enc_fac_cod from hs_encounter where enc_pk = doc_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_COD, "_
					"(select enc_fac_dsc from hs_encounter where enc_pk = doc_enc_fk and length(enc_fac_dsc) > 0) as ENC_FAC_DSC "_
				"FROM HS_DOCUMENT "_
				"WHERE DOC_PAT_FK = ? "
				
	Set:pIncludeWhereByEnc tSQL = tSQL_"AND DOC_ENC_FK = ? "
	Set:pIncludeWhereByPK tSQL = tSQL_"AND DOC_PK = ? "
	
	Quit tSQL
}

ClassMethod TriggerDOCByDate() As %String
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
				"/* Document */ "_
				"select "_
				"doc_pk ENTITY_ID, "_
				"doc_pat_fk PATIENT_ID, "_
				"doc_enc_fk ENCOUNTER_ID, "_
				"'PAT,ENC,DOC' ENTITY_TYPE, "_
				"LEAST(CURRENT, GREATEST( "_
				"NVL(doc_tr1_dat, TO_DATE('1900-01-01 00:00:00')), "_
				"NVL(doc_tr2_dat, TO_DATE('1900-01-01 00:00:00')) "_
				;"/*NVL(doc_tr3_dat, TO_DATE('1900-01-01 00:00:00'))*/ "_
				")) ENTITY_DATE "_
				"FROM hs_document "_
				"WHERE (1=0 "_
				"OR (doc_tr1_dat > TO_DATE(?) AND doc_tr1_dat <= CURRENT) "_
				"OR (doc_tr2_dat > TO_DATE(?) AND doc_tr2_dat <= CURRENT) "_
				;"/*OR (doc_tr3_dat > TO_DATE(?) AND doc_tr3_dat <= CURRENT)*/ "_
				") "_
				") "_
				"ORDER BY ENTITY_DATE "_
				") "
				
	Quit tSQL
}

}
