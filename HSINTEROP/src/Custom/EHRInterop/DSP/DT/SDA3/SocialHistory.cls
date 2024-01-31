Class Custom.EHRInterop.DSP.DT.SDA3.SocialHistory Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.SocialHistory, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.SocialHistory).%New()
    
	Set target.ExternalId = source.Get("SOC_PK")
	Set target.SocialHabit = ..CodeTable("SocialHabit",source.Get("SOC_COD"),source.Get("SOC_DSC"),pCodingStandard)
	Set target.SocialHabitComments  = source.Get("SOC_NOT")
    Set target.EnteredOn = source.Get("SOC_DAT")
    Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
    Set target.EnteredBy = ..CodeTableClinician("User",source.Get("SOC_CLI_COD"),source.Get("SOC_CLI_CONS_COD"),source.Get("SOC_CLI_CONS_DSC"),source.Get("SOC_CLI_NAM"),pCodingStandard)
    Set target.EncounterNumber = source.Get("SOC_ENC_FK")

	Quit tSC
}

}
