Class Custom.EHRInterop.DSP.DT.SDA3.Appointment Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Appointment, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.Appointment).%New()
	
	Set tAptDate = source.Get("APT_DAT")_"T00:00:00"

	Set target.Status = source.Get("APT_STA")
	Set target.Type = ..CodeTable("AppointmentType",source.Get("APT_TYP_COD"),source.Get("APT_TYP_DSC"),pCodingStandard)
	Set target.PlacerApptId = source.Get("APT_PK")
	Set target.FillerApptId = source.Get("APT_PK")
	Set target.EncounterNumber = source.Get("APT_ENC_FK")
	Set target.NoShow = source.Get("APT_NSH")
	Set target.OrderItem = ..CodeTable("Order",source.Get("APT_ITE_COD"),source.Get("APT_ITE_DSC"))
	Set target.CareProvider = ..CodeTableClinician("CareProvider",source.Get("APT_CLI_COD"),source.Get("APT_CLI_CONS_COD"),source.Get("APT_CLI_CONS_DSC"),source.Get("APT_CLI_NAM"),pCodingStandard)
	Set target.Location = ..CodeTable("HealthCareFacility",$ZSTRIP(source.Get("APT_LOC_COD"),"*C"),$ZSTRIP(source.Get("APT_LOC_DSC"),"*C"))
	Set target.FromTime = tAptDate
	Set target.ToTime = tAptDate
	Set target.EnteredOn = tAptDate
	Set target.EnteredBy = ..CodeTableClinician("User",source.Get("APT_CLI_COD"),source.Get("APT_CLI_CONS_COD"),source.Get("APT_CLI_CONS_DSC"),source.Get("APT_CLI_NAM"),pCodingStandard)
	Set target.Notes = source.Get("APT_TXT")
	
	Quit tSC
}

}
