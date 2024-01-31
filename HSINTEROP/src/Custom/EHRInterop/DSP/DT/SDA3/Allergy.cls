Class Custom.EHRInterop.DSP.DT.SDA3.Allergy Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Allergy, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK

	Set target = ##class(HS.SDA3.Allergy).%New()

	//Need to format correctly the Allergy Date, from '2014-03-13-09:42:16' to '2014-03-13T09:42:16'
	Set tAltDat = $Extract(source.Get("ALG_DAT"),1,10)_"T"_$Extract(source.Get("ALG_DAT"),12,19)

	Set target = ##class(HS.SDA3.Allergy).%New()
	Set target.Status = "A"
	Set target.ExternalId = source.Get("ALG_PK")
	Set target.Allergy             = ..CodeTable("Allergy",source.Get("ALG_COD"),source.Get("ALG_DSC"),pCodingStandard_"_"_source.Get("ALG_TYP_COD"))
	Set target.AllergyCategory     = ..CodeTable("AllergyCategory",source.Get("ALG_TYP_COD"),source.Get("ALG_TYP_DSC"),pCodingStandard)        
	Set target.Severity         = ..CodeTable("Severity",source.Get("ALG_SEV_COD"),source.Get("ALG_SEV_DSC"),pCodingStandard)
	Set target.Reaction         = ..CodeTable("Reaction",source.Get("ALG_REA_COD"),source.Get("ALG_REA_DSC"),pCodingStandard)
	Set target.Certainty         = ..CodeTable("Certainty",source.Get("ALG_CER_COD"),source.Get("ALG_CER_DSC"),pCodingStandard)
	Set target.FreeTextAllergy     = source.Get("ALG_TXT")
	Set target.Comments         = source.Get("ALG_OBS")
	Set:(source.Get("ALG_LST_DAT")'="") target.ConfirmedTime = $Extract(source.Get("ALG_LST_DAT"),1,10)_"T"_$Extract(source.Get("ALG_LST_DAT"),12,19)
	Set:(source.Get("ALG_BEG_DAT")'="") target.FromTime = $Extract(source.Get("ALG_BEG_DAT"),1,10)_"T00:00:00"
	Set:(source.Get("ALG_BEG_DAT")'="") target.DiscoveryTime = $Extract(source.Get("ALG_BEG_DAT"),1,10)_"T00:00:00"
	Set:(source.Get("ALG_END_DAT")'="") target.ToTime = $Extract(source.Get("ALG_END_DAT"),1,10)_"T00:00:00"
	Set:(source.Get("ALG_INA_DAT")'="") target.InactiveTime = $Extract(source.Get("ALG_INA_DAT"),1,10)_"T"_$Extract(source.Get("ALG_INA_DAT"),12,19)
	Set target.Clinician = ..CodeTableClinician("CareProvider",source.Get("ALG_CLI_COD"),source.Get("ALG_CLI_CONS_COD"),source.Get("ALG_CLI_CONS_DSC"),source.Get("ALG_CLI_NAM"),pCodingStandard)
	Set target.EnteredOn = tAltDat
	Set target.EnteredAt = ..CodeTable("Organization",$ZSTRIP(source.Get("ENC_FAC_COD"),"*C"),$ZSTRIP(source.Get("ENC_FAC_DSC"),"*C"),pCodingStandard)
	Set target.EnteredBy = ..CodeTableClinician("User",source.Get("ALG_CLI_COD"),source.Get("ALG_CLI_CONS_COD"),source.Get("ALG_CLI_CONS_DSC"),source.Get("ALG_CLI_NAM"),pCodingStandard)
	
	Quit tSC
}

}
