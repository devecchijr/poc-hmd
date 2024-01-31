Class Custom.EHRInterop.DSP.DT.SDA3.LabOrder Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.LabOrder, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.LabOrder).%New()
	
	Set target.PlacerId = source.Get("LAB_PID")
    Set target.FillerId = source.Get("LAB_FID")
    Set target.OrderItem = ..CodeTable("Order",source.Get("LAB_COD"),source.Get("LAB_DSC"),pCodingStandard)
    Set target.Status = source.Get("LAB_STA")
    Set target.OrderedBy = ..CodeTableClinician("CareProvider",source.Get("LAB_CLI_COD"),source.Get("LAB_CLI_CONS_COD"),source.Get("LAB_CLI_CONS_DSC"),source.Get("LAB_CLI_NAM"),pCodingStandard)
    Set target.EnteringOrganization = ..CodeTable("HealthCareFacility",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"))
    Set target.SpecimenCollectedTime = source.Get("LAB_ORD_DAT")
    ;Set target.SpecimenReceivedTime = source.Get("LAB_ORD_DAT")
    ;Set target.AuthorizationTime = source.Get("LAB_ORD_DAT")
    ;Set target.ReassessmentTime = source.Get("LAB_ORD_DAT")
    Set target.EncounterNumber = source.Get("LAB_ENC_FK")
	Set target.EnteredOn = source.Get("LAB_ORD_DAT")
    Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
    Set target.EnteredBy = ..CodeTableClinician("User",source.Get("LAB_CLI_COD"),source.Get("LAB_CLI_CONS_COD"),source.Get("LAB_CLI_CONS_DSC"),source.Get("LAB_CLI_NAM"),pCodingStandard)
    Set target.FromTime = source.Get("LAB_ORD_DAT")
    Set target.ToTime = source.Get("LAB_ORD_DAT")
    
    If (source.Get("LAB_RES_BOD") '= "")
	{
		Set tSDA3LabResult = ##class(HS.SDA3.Result).%New()
	
		Set tSDA3LabResult.FileType = source.Get("LAB_RES_BDT")
		
		Set tLabResBod = source.Get("LAB_RES_BOD")
	    Set tLabResBod = $Replace(tLabResBod, "xmlns=", "xmlns:aa=")
	    Set tLabResBod = $Replace(tLabResBod, "<![CDATA[<?xml version=""1.0""?>", "")
	    Set tLabResBod = $Replace(tLabResBod, "]]>", "")
		
		Do tSDA3LabResult.Stream.Write(tLabResBod)
	    	
	    Set tSDA3LabResult.EncounterNumber = source.Get("LAB_ENC_FK")
		Set tSDA3LabResult.ResultTime = source.Get("LAB_RES_DAT")
	    Set tSDA3LabResult.ResultStatus = "F"
		Set tSDA3LabResult.DocumentName = source.Get("LAB_RES_NAM")
	    Set tSDA3LabResult.EnteredOn = source.Get("LAB_RES_DAT")
	    Set tSDA3LabResult.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
	    
	    Set target.Result = tSDA3LabResult
	} ElseIf (source.Get("LAB_RES_DAT") '= "") {
		Set tSDA3LabResult = ##class(HS.SDA3.Result).%New()
	    Set tSDA3LabResult.ResultType = "AT"
	    Set tSDA3LabResult.EncounterNumber = source.Get("LAB_ENC_FK")
		Set tSDA3LabResult.ResultTime = source.Get("LAB_RES_DAT")
	    Set tSDA3LabResult.ResultStatus = "F"
	    Set tSDA3LabResult.EnteredOn = source.Get("LAB_RES_DAT")
	    Set tSDA3LabResult.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)

	    Set target.Result = tSDA3LabResult
	}
	
	Quit tSC
}

}
