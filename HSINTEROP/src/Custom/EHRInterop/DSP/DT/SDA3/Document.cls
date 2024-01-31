Class Custom.EHRInterop.DSP.DT.SDA3.Document Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Document, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.Document).%New()
	
	Set tDocId = source.Get("DOC_TYP_COD")_"_"_source.Get("DOC_PK")
	Set target.ExternalId = tDocId
	Set target.DocumentNumber = tDocId
	
	Set target.EncounterNumber = source.Get("DOC_ENC_FK")
    Set target.DocumentTime = source.Get("DOC_DAT")
    Set target.Clinician = ..CodeTableClinician("CareProvider",source.Get("DOC_CLI_COD"),source.Get("DOC_CLI_CONS_COD"),source.Get("DOC_CLI_CONS_DSC"),source.Get("DOC_CLI_NAM"),pCodingStandard)
    Set target.DocumentType = ..CodeTable("DocumentType",source.Get("DOC_TYP_COD"),source.Get("DOC_TYP_DSC"),"LOCALDOCTYPE")
    Set target.DocumentName = source.Get("DOC_NAM")
    
    Set target.FileType = source.Get("DOC_BDT")
    Set tDocBod = source.Get("DOC_BOD")
    Set tDocBod = $Replace(tDocBod, "xmlns=", "xmlns:aa=")
    Set tDocBod = $Replace(tDocBod, "<![CDATA[<?xml version=""1.0""?>", "")
    Set tDocBod = $Replace(tDocBod, "]]>", "")
    
    Do target.Stream.Write(tDocBod)
    
    Set target.Status = ..CodeTable("DocumentStatus",source.Get("DOC_STA"),source.Get("DOC_STA"),pCodingStandard)
    Set target.EnteredOn = source.Get("DOC_DAT")
    Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
    Set target.EnteredBy = ..CodeTableClinician("User",source.Get("DOC_CLI_COD"),source.Get("DOC_CLI_CONS_COD"),source.Get("DOC_CLI_CONS_DSC"),source.Get("DOC_CLI_NAM"),pCodingStandard)
   
	Quit tSC
}

}
