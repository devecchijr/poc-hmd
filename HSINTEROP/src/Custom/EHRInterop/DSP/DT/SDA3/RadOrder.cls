Class Custom.EHRInterop.DSP.DT.SDA3.RadOrder Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.RadOrder, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.RadOrder).%New()
	
	Set target.PlacerId	= source.Get("RAD_PID")
    Set target.FillerId = source.Get("RAD_FID")
    Set target.OrderItem = ..CodeTable("Order",source.Get("RAD_COD"),source.Get("RAD_DSC"),pCodingStandard)
    Set target.Status  = source.Get("RAD_STA")
    Set target.OrderedBy = ..CodeTableClinician("CareProvider",source.Get("RAD_CLI_COD"),source.Get("RAD_CLI_CONS_COD"),source.Get("RAD_CLI_CONS_DSC"),source.Get("RAD_CLI_NAM"),pCodingStandard)
    Set target.SpecimenCollectedTime = source.Get("RAD_RES_DAT")
    Set target.EncounterNumber = source.Get("RAD_ENC_FK")
	Set target.EnteredOn = source.Get("RAD_ORD_DAT")
    Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
    Set target.EnteredBy = ..CodeTableClinician("User",source.Get("RAD_CLI_COD"),source.Get("RAD_CLI_CONS_COD"),source.Get("RAD_CLI_CONS_DSC"),source.Get("RAD_CLI_NAM"),pCodingStandard)
    Set target.FromTime = source.Get("RAD_ORD_DAT")
    Set target.ToTime = source.Get("RAD_ORD_DAT")
    
    If (source.Get("RAD_RES_BOD") '= "")
	{
		Set tSDA3RadResult = ##class(HS.SDA3.Result).%New()
	
		Set tSDA3RadResult.FileType = source.Get("RAD_RES_BDT")
		
    	Set tRadResBod = $Replace(source.Get("RAD_RES_BOD"), "xmlns=", "xmlns:aa=")
	    Do tSDA3RadResult.Stream.Write(tRadResBod)
	    	
	    Set tSDA3RadResult.EncounterNumber = source.Get("RAD_ENC_FK")
		Set tSDA3RadResult.ResultTime = source.Get("RAD_RES_DAT")
	    Set tSDA3RadResult.ResultStatus = "F"
		Set tSDA3RadResult.DocumentName = source.Get("RAD_RES_NAM")
	    Set tSDA3RadResult.EnteredOn = source.Get("RAD_RES_DAT")
	    Set tSDA3RadResult.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
	    Set tSDA3RadResult.EnteredBy = ..CodeTableClinician("User",source.Get("RAD_CLI_COD"),source.Get("RAD_CLI_CONS_COD"),source.Get("RAD_CLI_CONS_DSC"),source.Get("RAD_CLI_NAM"),pCodingStandard)
	    
	    Set target.Result = tSDA3RadResult 
	}
	
	Quit tSC
}

}
