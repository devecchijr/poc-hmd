Class Custom.EHRInterop.DSP.DT.SDA3.Medication Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Medication, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.Medication).%New()
    
	Set target.FillerId = source.Get("MED_PK")
	Set target.PlacerId = source.Get("MED_PK")
    Set target.Status = source.Get("MED_STA")
    Set target.DrugProduct = ..CodeTable("DrugProduct",source.Get("MED_COD"),source.Get("MED_DSC"),pCodingStandard)
    Set target.Route = ..CodeTable("Route",source.Get("MED_ROU_COD"),source.Get("MED_ROU_DSC"),pCodingStandard)
    Set target.Frequency = ..CodeTable("Frequency",source.Get("MED_FRQ_COD"),source.Get("MED_FRQ_DSC"),pCodingStandard)
    
    //Need to format correctly the Medication Date, from '2014-03-13-09:42:16' to '2014-03-13T09:42:16'
    Set tMedDat = $Extract(source.Get("MED_DAT"),1,10)_"T"_$Extract(source.Get("MED_DAT"),12,19)
    
    Set target.FromTime = tMedDat
    Set target.ToTime = tMedDat
    Set target.OrderedBy = ..CodeTableClinician("CareProvider",source.Get("MED_CLI_COD"),source.Get("MED_CLI_CONS_COD"),source.Get("MED_CLI_CONS_DSC"),source.Get("MED_CLI_NAM"),pCodingStandard)
    Set target.EncounterNumber = source.Get("MED_ENC_FK")
    Set target.PrescriptionNumber = source.Get("MED_PSC_COD")
    Set target.DoseQuantity = source.Get("MED_DOS_VAL")
    Set target.DoseUoM = ..CodeTable("UoM",source.Get("MED_UNI_COD"),source.Get("MED_UNI_DSC"),pCodingStandard)
    Set target.EnteredOn = tMedDat
    Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"), "*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"), "*C"),pCodingStandard)
    Set target.EnteredBy = ..CodeTableClinician("User",source.Get("MED_CLI_COD"),source.Get("MED_CLI_CONS_COD"),source.Get("MED_CLI_CONS_DSC"),source.Get("MED_CLI_NAM"),pCodingStandard)

	Quit tSC
}

}
