Class Custom.Test.Stream Extends %RegisteredObject
{

ClassMethod FindNonPrintableChars(pRequestId As %Integer) As %Status
{
	Set tReq = ##class(Custom.EHRInterop.Core.Operation.SOAP.Operation.Request.SaveSDARequest).%OpenId(pRequestId)
	
	Set tStrm = tReq.pRequest.ContentStream
	Set tDebugStr = ""
	While ('tStrm.AtEnd)
	{
		Set tChar = tStrm.Read(1)
		Set tDebugStr = $Extract(tDebugStr_tChar,*-100,*)
		Set tStrippedChar = $ZStrip(tChar,"*C")
		If (tChar '= tStrippedChar)
		{
			w !, "Problem at...'"_tDebugStr_"<--': CHAR("_$ASCII(tChar)_")"
		}
	}
	
	Quit $$$OK
}

}
