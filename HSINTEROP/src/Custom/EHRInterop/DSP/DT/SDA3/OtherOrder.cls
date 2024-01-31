Class Custom.EHRInterop.DSP.DT.SDA3.OtherOrder Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.OtherOrder, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.OtherOrder).%New()
	
	Set target.PlacerId	= source.Get("OTH_PID")
    Set target.FillerId = source.Get("OTH_FID")
    Set target.OrderItem = ..CodeTable("Order",source.Get("OTH_COD"),source.Get("OTH_DSC"),pCodingStandard)
    Set target.Status  = source.Get("OTH_STA")
    Set target.OrderedBy = ..CodeTableClinician("CareProvider",source.Get("OTH_CLI_COD"),source.Get("OTH_CLI_CONS_COD"),source.Get("OTH_CLI_CONS_DSC"),source.Get("OTH_CLI_NAM"),pCodingStandard)
    Set target.SpecimenCollectedTime = source.Get("OTH_ORD_DAT")
    Set target.EncounterNumber = source.Get("OTH_ENC_FK")
	Set target.EnteredOn = source.Get("OTH_ORD_DAT")
    Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
    Set target.EnteredBy = ..CodeTableClinician("User",source.Get("OTH_CLI_COD"),source.Get("OTH_CLI_CONS_COD"),source.Get("OTH_CLI_CONS_DSC"),source.Get("OTH_CLI_NAM"),pCodingStandard)
    Set target.FromTime = source.Get("OTH_ORD_DAT")
    Set target.ToTime = source.Get("OTH_ORD_DAT")
    
	Quit tSC
}

}
