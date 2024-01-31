Class Custom.EHRInterop.Service.SOAP.Response.SaveSDAResponse Extends Ens.Response
{

Property Success As %Boolean [ InitialExpression = 1 ];

Property ErrorList As list Of %String;

Property ProcessingTransationID As %String;

Storage Default
{
<Data name="SaveSDAResponseDefaultData">
<Subscript>"SaveSDAResponse"</Subscript>
<Value name="1">
<Value>Success</Value>
</Value>
<Value name="2">
<Value>ErrorList</Value>
</Value>
<Value name="3">
<Value>ProcessingTransationID</Value>
</Value>
</Data>
<DefaultData>SaveSDAResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
