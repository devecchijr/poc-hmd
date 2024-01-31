Class Custom.EHRInterop.DSP.DT.SDA3.IllnessHistory Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.IllnessHistory, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.IllnessHistory).%New()
    
	Set target.ExternalId = source.Get("ILL_PK")
	Set target.NoteText = source.Get("ILL_NOT")
	Set target.Condition = ..CodeTable("PastHistoryCondition",source.Get("ILL_COD"),source.Get("ILL_DSC"))
    Set target.Clinician = ..CodeTableClinician("CareProvider",source.Get("ILL_CLI_COD"),source.Get("ILL_CLI_CONS_COD"),source.Get("ILL_CLI_CONS_DSC"),source.Get("ILL_CLI_NAM"),pCodingStandard)
    Set target.ActionCode = source.Get("ILL_STA")
    Set target.FromTime = source.Get("ILL_DAT")
	Set target.EnteredOn = source.Get("ILL_DAT")
    Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
    Set target.EnteredBy = ..CodeTableClinician("User",source.Get("ILL_CLI_COD"),source.Get("ILL_CLI_CONS_COD"),source.Get("ILL_CLI_CONS_DSC"),source.Get("ILL_CLI_NAM"),pCodingStandard)
    Set target.EncounterNumber = source.Get("ILL_ENC_FK")
    
	Quit tSC
}

}
