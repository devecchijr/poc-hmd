Class Custom.EHRInterop.DSP.DT.SDA3.Alert Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Alert, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.Alert).%New()

	//Need to format correctly the Alert Date, from '2014-03-13-09:42:16' to '2014-03-13T09:42:16'
    Set tAltDat = $Extract(source.Get("ALT_DAT"),1,10)_"T"_$Extract(source.Get("ALT_DAT"),12,19)
    
    Set target.ExternalId = source.Get("ALT_PK")
	Set target.AlertType = ..CodeTable("AlertType",source.Get("ALT_TYP_COD"),source.Get("ALT_TYP_DSC"),pCodingStandard)
	Set target.Alert = ..CodeTable("Alert",source.Get("ALT_COD"),source.Get("ALT_DSC"),pCodingStandard)
	Set target.Status = "A"
	Set target.FromTime = tAltDat
	Set target.ToTime = tAltDat
	Set target.EnteredOn = tAltDat
	Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"),"*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"),"*C"),pCodingStandard)
	Set target.EnteredBy = ..CodeTableClinician("User",source.Get("ALT_CLI_COD"),source.Get("ALT_CLI_CONS_COD"),source.Get("ALT_CLI_CONS_DSC"),source.Get("ALT_CLI_NAM"),pCodingStandard)
	
	Quit tSC
}

}
