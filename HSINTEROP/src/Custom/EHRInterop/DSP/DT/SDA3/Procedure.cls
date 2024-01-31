Class Custom.EHRInterop.DSP.DT.SDA3.Procedure Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Procedure, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.Procedure).%New()

	Set target.ExternalId = source.Get("PRC_PK")
    Set target.EncounterNumber = source.Get("PRC_ENC_FK")
    Set target.Procedure = ..CodeTable("Procedure",source.Get("PRC_COD"),source.Get("PRC_DSC"),pCodingStandard)
    Set target.Clinician = ..CodeTableClinician("CareProvider",source.Get("PRC_CLI_COD"),source.Get("PRC_CLI_CONS_COD"),source.Get("PRC_CLI_CONS_DSC"),source.Get("PRC_CLI_NAM"),pCodingStandard)
    Set target.ProcedureTime = source.Get("PRC_DAT")
    Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"),"*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"),"*C"),pCodingStandard)
	Set target.EnteredOn = source.Get("PRC_DAT")
	Set target.EnteredBy = ..CodeTableClinician("User",source.Get("PRC_CLI_COD"),source.Get("PRC_CLI_CONS_COD"),source.Get("PRC_CLI_CONS_DSC"),source.Get("PRC_CLI_NAM"),pCodingStandard)

	Quit tSC
}

}
