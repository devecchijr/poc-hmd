Class Custom.EHRInterop.Service.SOAP.Request.SaveSDARequest Extends Ens.Request
{

/// Some ID to identificate the SDA in source
Property InfoID As %String(MAXLEN = "", XMLNAME = "InfoID");

/// Some ID to identificate the transaction (for instance, SessionId) in source
Property TransactionID As %String(MAXLEN = "", XMLNAME = "TransactionID");

/// XML SDA Content Stream
Property ContentStream As %Stream.TmpCharacter;

Storage Default
{
<Data name="SaveSDARequestDefaultData">
<Subscript>"SaveSDARequest"</Subscript>
<Value name="1">
<Value>InfoID</Value>
</Value>
<Value name="2">
<Value>TransactionID</Value>
</Value>
<Value name="3">
<Value>ContentStream</Value>
</Value>
</Data>
<DefaultData>SaveSDARequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
