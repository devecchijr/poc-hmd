Class HSINTEROPPKG.FoundationProduction Extends Ens.Production [ Not ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="HSINTEROPPKG.FoundationProduction" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="JGService" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Port">44446</Setting>
  </Item>
  <Item Name="BuildSDAHC" Category="" ClassName="Custom.EHRInterop.DSP.Operation.BuildSDAOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">INTEROP</Setting>
    <Setting Target="Adapter" Name="Credentials">INTEROP</Setting>
    <Setting Target="Adapter" Name="JGService">JGService</Setting>
    <Setting Target="Host" Name="CodingStandard">INTEROP</Setting>
    <Setting Target="Host" Name="SendingFacility">INTEROP</Setting>
    <Setting Target="Host" Name="SOAPHost">SendSDAToEdgeHC</Setting>
    <Setting Target="Host" Name="TraceOperations"></Setting>
  </Item>
  <Item Name="SendSDAToEdgeHC" Category="" ClassName="Custom.EHRInterop.Core.Operation.SOAP.Operation.SDASOAPServiceSoap" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials"></Setting>
    <Setting Target="Adapter" Name="SOAPCredentials">HS_Services</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Adapter" Name="ResponseTimeout">120</Setting>
    <Setting Target="Adapter" Name="WebServiceURL">http://localhost:52773/csp/healthshare/hsedge1/services/Custom.EHRInterop.Service.SOAP.Service.cls</Setting>
  </Item>
</Production>
}

}
