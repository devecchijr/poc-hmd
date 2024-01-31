Class Custom.EHRInterop.Core.DT.SDA3.PatientNumber Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.PatientNumber, pCampo As %String, pTipo As %String, pCodigoOrganizacao As %String, pOrganizacao As %String) As %Status
{
	Set tSC = $$$OK
	
	If (source.Get(pCampo) '="")
	{
		Set target = ##class(HS.SDA3.PatientNumber).%New()
		
		Set target.Number       = source.Get(pCampo)
		Set target.Organization = ..CodeTable("Organization",pCodigoOrganizacao,pOrganizacao)
		Set target.NumberType   = pTipo
	}
   
	Quit tSC
}

}
