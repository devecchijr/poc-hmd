Class Custom.EHRInterop.Operation.SOAP.Operation.Request.SaveSDARequest Extends Ens.Request [ ProcedureBlock ]
{

Parameter RESPONSECLASSNAME = "Custom.EHRInterop.Operation.SOAP.Operation.Response.SaveSDAResponse";

Property pRequest As Custom.EHRInterop.Operation.SOAP.Client.s0.SaveSDARequest;

Storage Default
{
<Data name="SaveSDARequestDefaultData">
<Subscript>"SaveSDARequest"</Subscript>
<Value name="1">
<Value>pRequest</Value>
</Value>
</Data>
<DefaultData>SaveSDARequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
