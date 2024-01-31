Class Custom.EHRInterop.DSP.DT.SDA3.Diagnosis Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Diagnosis, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.Diagnosis).%New()
	
	Set target.ExternalId = source.Get("DXG_PK")
	Set target.EncounterNumber = source.Get("DXG_ENC_FK")
	Set target.IdentificationTime = source.Get("DXG_DAT")
	Set target.DiagnosingClinician = ..CodeTableClinician("CareProvider",source.Get("DXG_CLI_COD"),source.Get("DXG_CLI_CONS_COD"),source.Get("DXG_CLI_CONS_DSC"),source.Get("DXG_CLI_NAM"),pCodingStandard)
	Set target.Diagnosis = ..CodeTable("Diagnosis",source.Get("DXG_COD"), source.Get("DXG_DSC"), source.Get("DXG_TYP"))
	Set target.Status = ..CodeTable("DiagnosisStatus",source.Get("DXG_STA"),source.Get("DXG_STA"))
	Set target.EnteredOn = source.Get("DXG_DAT")
	Set target.DiagnosisType = ..CodeTable("DiagnosisType",source.Get("DXG_TYP_COD"),source.Get("DXG_TYP_DSC"),pCodingStandard)
	
	Set target.EnteredBy = ..CodeTableClinician("User",source.Get("DXG_CLI_COD"),source.Get("DXG_CLI_CONS_COD"),source.Get("DXG_CLI_CONS_DSC"),source.Get("DXG_CLI_NAM"),pCodingStandard)
	Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"),"*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"),"*C"),pCodingStandard)
	
	//Diagnosis Priority
	Set tDiagnPriority = 2
	If (source.Get("DXG_PRI")="t") {
		Set tDiagnPriority = 1
	}
	Set target.DiagnosisPriority = tDiagnPriority
	
	//Present on Admission/Discharge
	Set tPresentOnCod = ""
	Set tPresentOnDsc = ""
	If (source.Get("DXG_ADM")="t") { //Present on Admission?
		Set tPresentOnCod = "A"
		Set tPresentOnDsc = "Admission"
	}
	If (source.Get("DXG_DCH")="t") { //Present on Discharge?
		Set tPresentOnCod = "D"
		Set tPresentOnDsc = "Discharge"
	}
	If (source.Get("DXG_ADM")="t") && (source.Get("DXG_DCH")="t") { //Present on Admission AND Discharge (is it possible?)
		Set tPresentOnCod = "AD"
		Set tPresentOnDsc = "Admission and Discharge"
	}
	Set target.PresentOnAdmission = ..CodeTable("PresentOnAdmission",tPresentOnCod,tPresentOnDsc,pCodingStandard)
	
	
	Quit tSC
}

}
