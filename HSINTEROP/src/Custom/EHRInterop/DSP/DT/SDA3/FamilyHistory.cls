Class Custom.EHRInterop.DSP.DT.SDA3.FamilyHistory Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.FamilyHistory, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.FamilyHistory).%New()
    
	Set target.ExternalId = source.Get("FAM_PK")
    Set target.FamilyMember = ..CodeTable("FamilyMember",source.Get("FAM_KIN_COD"),source.Get("FAM_KIN_DSC"))
	Set target.NoteText = $ZSTRIP(source.Get("FAM_NOT"), "*C")
	Set target.Status = $ZSTRIP(source.Get("FAM_STA"), "*C")
	Set target.EnteredOn = source.Get("FAM_DAT")
    Set target.FromTime = source.Get("FAM_DAT")
    Set target.ToTime = source.Get("FAM_DAT")
    Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
    Set target.EnteredBy = ..CodeTableClinician("User",source.Get("FAM_CLI_COD"),source.Get("FAM_CLI_CONS_COD"),source.Get("FAM_CLI_CONS_DSC"),source.Get("FAM_CLI_NAM"),pCodingStandard)
    Set target.EncounterNumber = source.Get("FAM_ENC_FK")
	
	Quit tSC
}

}
