Include HS.Common

/// A sample production for an Edge Gateway using an HL7 File service
Class HSEDGE1PKG.EdgeGatewayProduction Extends HS.Util.AbstractEdgeProduction [ ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="HSEDGE1PKG.EdgeGatewayProduction" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description>An example production showing a simple file based HL7 v2.x Edge Gateway configuration</Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Setting Target="Production" Name="ShutdownTimeout">10</Setting>
  <Setting Target="Production" Name="FeedAnalytics">1</Setting>
  <Item Name="HS.Gateway.HL7.InboundProcess" Category="" ClassName="HS.Gateway.HL7.InboundProcess" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="KeepDuplicateOBXIdentifiers">1</Setting>
  </Item>
  <Item Name="HS.Gateway.ECR.Manager" Category="" ClassName="HS.Gateway.ECR.Manager" PoolSize="2" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="EnsLib.HL7.Service.FileService" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">HS.Gateway.HL7.InboundProcess</Setting>
    <Setting Target="Host" Name="AckMode">Never</Setting>
    <Setting Target="Host" Name="MessageSchemaCategory">2.5</Setting>
    <Setting Target="Adapter" Name="FilePath">../../Data/HSEDGE1/HL7In</Setting>
  </Item>
  <Item Name="HUB" Category="" ClassName="HS.Hub.HSWS.RemoteOperations" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="ServiceName">HSREGISTRY</Setting>
    <Setting Target="Adapter" Name="ResponseTimeout">2592000</Setting>
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
    <Setting Target="Host" Name="Retry">1</Setting>
    <Setting Target="Host" Name="RetryInterval">120</Setting>
  </Item>
  <Item Name="HS.Gateway.HSWS.WebServices" Category="" ClassName="HS.Gateway.HSWS.WebServices" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="ECRTarget">HS.Gateway.ECR.Manager</Setting>
    <Setting Target="Host" Name="PushRepMgr">HS.Gateway.ECR.Push.RepositoryManager</Setting>
    <Setting Target="Host" Name="ECRProcess">HS.Gateway.ECR.Process</Setting>
    <Setting Target="Host" Name="ResourceRequired">%HS_WebServices</Setting>
    <Setting Target="Host" Name="AlternatePort">44480</Setting>
    <Setting Target="Host" Name="ForceSSL">1</Setting>
    <Setting Target="Host" Name="GatewayName">BRMBP15CDEVECC.local:HSEDGE1</Setting>
    <Setting Target="Host" Name="AnalyticsNotificationTargets">AnalyticsSubscriptionHandler</Setting>
  </Item>
  <Item Name="MPIUpdateManager" Category="" ClassName="HS.Gateway.ECR.MPIUpdateManager" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="DoPush">1</Setting>
  </Item>
  <Item Name="HS.Util.MaintenanceService" Category="" ClassName="HS.Util.MaintenanceService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Adapter" Name="CallInterval">60</Setting>
  </Item>
  <Item Name="GATEWAY" Category="" ClassName="HS.Gateway.Access.RemoteOperations" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Adapter" Name="SOAPCredentials">HSACCESS</Setting>
  </Item>
  <Item Name="AGGREGATOR" Category="" ClassName="HS.Gateway.Access.RemoteOperations" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Adapter" Name="SOAPCredentials">HSACCESS</Setting>
  </Item>
  <Item Name="HS.Gateway.ECR.Push.RepositoryManager" Category="" ClassName="HS.Gateway.ECR.Push.RepositoryManager" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="MPIOperations">HUB</Setting>
  </Item>
  <Item Name="SubscriptionHandler" Category="" ClassName="HS.Gateway.ECR.Push.RepositoryManager" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="MPIOperations">HUB</Setting>
  </Item>
  <Item Name="HS.Gateway.ECR.Process" Category="" ClassName="HS.Gateway.ECR.Process" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="ECRTarget">HS.Gateway.ECR.Manager</Setting>
    <Setting Target="Host" Name="GatewayOperations">GATEWAY</Setting>
  </Item>
  <Item Name="HS.Gateway.ECR.SDA3XMLFileService" Category="" ClassName="HS.Gateway.ECR.SDA3XMLFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Adapter" Name="FilePath">../../Data/HSEDGE1/SDAIn</Setting>
  </Item>
  <Item Name="HS.Gateway.SDA3.InboundProcess" Category="" ClassName="HS.Gateway.SDA3.InboundProcess" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="HS.Util.Trace.Operations" Category="" ClassName="HS.Util.Trace.Operations" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="HS.Gateway.ECR.Push.HL7SampleOperation" Category="" ClassName="HS.Gateway.ECR.Push.HL7SampleOperation" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="MU2 SyndromicSurveillanceSDAXMLFileService" Category="" ClassName="HS.Gateway.ECR.SDA3XMLFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ProcessingTarget">MU2 SyndromicSurveillanceInboundProcess</Setting>
    <Setting Target="Adapter" Name="FilePath">../../Data/HSEDGE1/MU2SynSDAIn/</Setting>
  </Item>
  <Item Name="MU2 ImmunizationsSDAXMLFileService" Category="" ClassName="HS.Gateway.ECR.SDA3XMLFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">../../Data/HSEDGE1/MU2ImmSDAIn/</Setting>
  </Item>
  <Item Name="MU2 LaboratoryReportingSDAXMLFileService" Category="" ClassName="HS.Gateway.ECR.SDA3XMLFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ProcessingTarget">MU2 LaboratoryReportingInboundProcess</Setting>
    <Setting Target="Adapter" Name="FilePath">../../Data/HSEDGE1/MU2LabSDAIn/</Setting>
  </Item>
  <Item Name="HS.Gateway.SDA3.Validation.SyndromicSurveillance" Category="" ClassName="HS.Gateway.SDA3.Validation.SyndromicSurveillance" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="HS.Gateway.SDA3.Validation.LaboratoryReporting" Category="" ClassName="HS.Gateway.SDA3.Validation.LaboratoryReporting" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="MU2 SyndromicSurveillanceInboundProcess" Category="" ClassName="HS.Gateway.SDA3.InboundProcess" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="PreProcessor">HS.Gateway.SDA3.Validation.SyndromicSurveillance</Setting>
  </Item>
  <Item Name="MU2 LaboratoryReportingInboundProcess" Category="" ClassName="HS.Gateway.SDA3.InboundProcess" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="PreProcessor">HS.Gateway.SDA3.Validation.LaboratoryReporting</Setting>
  </Item>
  <Item Name="HS.Gateway.Analytics.WS.RemoteOperations" Category="" ClassName="HS.Gateway.Analytics.WS.RemoteOperations" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
    <Setting Target="Host" Name="RetryInterval">120</Setting>
    <Setting Target="Adapter" Name="ResponseTimeout">2592000</Setting>
  </Item>
  <Item Name="AnalyticsSubscriptionHandler" Category="" ClassName="HS.Gateway.ECR.Push.AnalyticsManager" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="MPIOperations">HUB</Setting>
  </Item>
  <Item Name="Custom.EHRInterop.Service.SOAP.Service" Category="" ClassName="Custom.EHRInterop.Service.SOAP.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="EnableStandardRequests">1</Setting>
  </Item>
</Production>
}

}
