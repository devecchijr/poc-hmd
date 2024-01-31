Class Custom.EHRInterop.DSP.DT.SDA3.Observation Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Observation, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set tObsEncFk = ..StrippedValue(source.Get("OBS_ENC_FK"))
	Set tObsCod = ..StrippedValue(source.Get("OBS_COD"))
	Set tObsDsc = ..StrippedValue(source.Get("OBS_DSC"))
	Set tObsUntCod = ..StrippedValue(source.Get("OBS_UNT_COD"))
	Set tObsUntDsc = ..StrippedValue(source.Get("OBS_UNT_DSC"))
	Set tObsVal = ..StrippedValue(source.Get("OBS_VAL"))
	Set tObsDat = ..StrippedValue(source.Get("OBS_DAT"))
	Set tObsCliCod = ..StrippedValue(source.Get("OBS_CLI_COD"))
	Set tObsCliConsCod = ..StrippedValue(source.Get("OBS_CLI_CONS_COD"))
	Set tObsCliConsDsc = ..StrippedValue(source.Get("OBS_CLI_CONS_DSC"))
	Set tObsCliNam = ..StrippedValue(source.Get("OBS_CLI_NAM"))
	Set tEncFacCod = ..StrippedValue(source.Get("ENC_FAC_COD"))
	Set tEncFacDsc = ..StrippedValue(source.Get("ENC_FAC_DSC"))
	
    Set target = ##class(HS.SDA3.Observation).%New()
    
    Set target.EncounterNumber = tObsEncFk
	
	Set target.ObservationCode = ..CodeTable("Observation",tObsCod,tObsDsc,pCodingStandard)
	Set target.ObservationCode.ObservationValueUnits = ..CodeTable("UoM",tObsUntCod,tObsUntDsc,pCodingStandard)
    Set target.ObservationValue = tObsVal
    
    Set target.ObservationTime = tObsDat
    Set target.FromTime	= tObsDat
	Set target.ToTime = tObsDat
	Set target.EnteredOn = tObsDat
	
	Set target.EnteredAt = ..CodeTable("Organization",tEncFacCod,tEncFacDsc,pCodingStandard)
	
	Set target.Clinician = ..CodeTableClinician("CareProvider",tObsCliCod,tObsCliConsCod,tObsCliConsDsc,tObsCliNam,pCodingStandard)
	Set target.EnteredBy = ..CodeTableClinician("User",tObsCliCod,tObsCliConsCod,tObsCliConsDsc,tObsCliNam,pCodingStandard)

	Quit tSC
}

}
