Class Custom.EHRInterop.DSP.DT.SDA3.Encounter Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Encounter, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.Encounter).%New()
	
	Set tAdmissionType = $ZSTRIP(source.Get("ENC_TYP"),"*CW")
	Set tCodFacility = $ZSTRIP(source.Get("ENC_FAC_COD"),"*C")
	Set tFacility = $ZSTRIP(source.Get("ENC_FAC_DSC"),"*C")

    Set target.EncounterNumber = source.Get("ENC_PK")
    Set target.AdmissionType = ..CodeTable("AdmissionType",tAdmissionType,tAdmissionType,pCodingStandard)
    Set target.EncounterType = tAdmissionType
    Set target.AdmittingClinician = ..CodeTableClinician("CareProvider",$ZSTRIP(source.Get("ENC_CLI_COD"),"*C"),$ZSTRIP(source.Get("ENC_CLI_CONS_COD"),"*C"),$ZSTRIP(source.Get("ENC_CLI_CONS_DSC"),"*C"),$ZSTRIP(source.Get("ENC_CLI_NAM"),"*C"),pCodingStandard)
    Set target.AdmitReason = ..CodeTable("AdmitReason",tAdmissionType,tAdmissionType,pCodingStandard)
    Set target.HealthCareFacility = ..CodeTable("HealthCareFacility",tCodFacility,tFacility,pCodingStandard)
    Set target.AssignedWard = source.Get("ENC_WRD")
    Set target.AssignedBed = source.Get("ENC_BED")
    
    /*If (source.Get("COD_CONVENIO")'= "") 
    {
        Set tHF = ##class(HS.SDA3.HealthFund).%New()
        
        Set tHF.HealthFund              = ..CodeTable("HealthFund", source.Get("COD_CONVENIO"), source.Get("CONVENIO"),pCodingStandard)
        Set tHF.MembershipNumber        = source.Get("CARTEIRINHA")
        
        Do target.HealthFunds.Insert(tHF)
    }*/
    
    If (source.Get("ENC_SPE_COD")'="")
    {
    	Do target.Specialties.Insert(..CodeTable("CareProviderType",source.Get("ENC_SPE_COD"),source.Get("ENC_SPE_DSC"),pCodingStandard))
    }
    Set target.UpdatedOn = source.Get("ENC_ADM_DAT")
    Set target.FromTime = source.Get("ENC_ADM_DAT")
    Set target.ToTime = source.Get("ENC_DIS_DAT")
    Set target.EnteredAt = ..CodeTable("Organization",tCodFacility,tFacility,pCodingStandard)
    Set target.EnteredBy = ..CodeTableClinician("User",$ZSTRIP(source.Get("ENC_CLI_COD"),"*C"),$ZSTRIP(source.Get("ENC_CLI_CONS_COD"),"*C"),$ZSTRIP(source.Get("ENC_CLI_CONS_DSC"),"*C"),$ZSTRIP(source.Get("ENC_CLI_NAM"),"*C"),pCodingStandard)
    
	Quit tSC
}

}
