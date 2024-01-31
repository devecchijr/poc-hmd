Class Custom.EHRInterop.Service.SOAP.Service Extends EnsLib.SOAP.Service
{

Parameter SERVICENAME = "SDASOAPService";

Parameter NAMESPACE = "http://www.intersystems.com/hs/custom/sda";

/// Destination for any SDA requests we service
Property ProcessingTarget As Ens.DataType.ConfigName [ InitialExpression = "HS.Gateway.SDA3.InboundProcess" ];

Parameter SETTINGS As %String = "ProcessingTarget";

/// Hide Internal methods from WSDL generation
Parameter SOAPINTERNALWSDL = 0;

/// Location needs to be overridden to add /services to path
Parameter LOCATION = "./services";

/// Ping method (for testing)
Method Ping(pInput As %String) As %String [ WebMethod ]
{
	Set tOutput = pInput_" Pong "_$ZDATETIME($H)
	
	Quit tOutput
}

/// SaveSDA in ECR, with Alert/Warning/Error information to the sender
Method SaveSDA(pRequest As Custom.EHRInterop.Service.SOAP.Request.SaveSDARequest) As Custom.EHRInterop.Service.SOAP.Response.SaveSDAResponse [ WebMethod ]
{
	Set tSC = $$$OK
	
	Set tInfoID = "(empty)"
	If pRequest.InfoID '= "" Set tInfoID = pRequest.InfoID
	
	Set tTransactionID = "(empty)"
	If pRequest.TransactionID '= "" Set tTransactionID = pRequest.TransactionID
	
	//Sending SDA request
    set tRequest=##class(HS.Message.ECRUpdateRequest).%New()
    Set tSC=tRequest.ContentStream.CopyFrom(pRequest.ContentStream)
	Set tRequest.StreamContentType="SDA3"
	Set tSC = ..SendRequestSync(..ProcessingTarget,tRequest,.tResponse)
	
	//Building SOAP Output
	Set tOutput = ##class(Custom.EHRInterop.Service.SOAP.Response.SaveSDAResponse).%New()
	Set tOutput.Success = '$$$ISERR(tSC)
	
	//Binding SessionID to result
	Set tSessionId = ..%SessionId
	Set tOutput.ProcessingTransationID = tSessionId
	
	//Getting all errors/warnings from Session (Error=2, Warning=3, Alert=6)
	&sql(DECLARE C1 CURSOR FOR 
	   SELECT Text into :tText FROM Ens_Util.Log
	   WHERE SessionId = :tSessionId AND Type IN (2, 3, 6))
	&sql(OPEN C1)
	  QUIT:(SQLCODE'=0)
	&sql(FETCH C1)
	WHILE (SQLCODE = 0)
	{
		Set tOutput.Success = 0
		Do tOutput.ErrorList.Insert($ZStrip($Translate(tText, "<>", ""), "*C"))
		&sql(FETCH C1)
	}
	&sql(CLOSE C1)
	
	//Logging Info (input + output)
	Set tInfo = "SaveSDA > Input: InfoID "_tInfoID
	Set tInfo = tInfo_", TransactionID "_tTransactionID
	Set tInfo = tInfo_". Output: Success "_tOutput.Success
	Set tInfo = tInfo_", ErrorList.Count "_tOutput.ErrorList.Count()
	$$$LOGINFO(tInfo)
	
    Quit tOutput
}

}
