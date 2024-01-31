Class Custom.EHRInterop.Core.DT.SDA3.ContactInformation Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.ContactInfo) As %Status
{
	Set tSC = $$$OK
	
	Set target = ##class(HS.SDA3.ContactInfo).%New()
	
	Set target.HomePhoneNumber = $ZStrip(source.Get("PAT_TEL_RES"),"*C")
	Set target.WorkPhoneNumber = $ZStrip(source.Get("PAT_TEL_COM"),"*C")
	Set target.MobilePhoneNumber = $ZStrip(source.Get("PAT_TEL_MOB"),"*C")
	Set target.EmailAddress = $ZStrip(source.Get("PAT_EMA"),"*C")
   
	Quit tSC
}

}
