Class Custom.EHRInterop.DSP.DT.SDA3.LabResultItem Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.LabResultItem, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	Set target = ##class(HS.SDA3.LabResultItem).%New()
    Set target.TestItemCode = ..CodeTable("LabTestItem",source.Get("LRI_COD"),source.Get("LRI_DSC"),pCodingStandard)
    Set target.TestItemCode.IsNumeric = 0
    Set target.ObservationValueType = "ST"    
    Set:($E(source.Get("LRI_TYP"),1,1)="N") target.TestItemCode.IsNumeric = 1
    Set:($E(source.Get("LRI_TYP"),1,1)="N") target.ObservationValueType = "NM"
    Set target.ResultValue = source.Get("LRI_VAL")
    Set target.ResultValueUnits = source.Get("LRI_UNT")
    Set:(source.Get("LRI_REF")'="") target.ResultNormalRange = source.Get("LRI_REF")
    Set target.TestItemStatus = "F"
    Set:(source.Get("LRI_STA")'="") target.TestItemStatus = source.Get("LRI_STA")
    Set target.ObservationTime = source.Get("LRI_DAT")    
	Quit tSC
}

}
