Class SQLUSER.Medication Extends %Persistent [ SqlTableName = HS_MEDICATION ]
{

Property PK As %String(MAXLEN = 200) [ SqlFieldName = MED_PK ];

Property EncounterId As %String [ SqlFieldName = MED_ENC_FK ];

Property PatientId As %String [ SqlFieldName = MED_PAT_FK ];

Property PrescriptionId As %String [ SqlFieldName = MED_PSC_COD ];

Property Date As %String [ SqlFieldName = MED_DAT ];

Property DateStart As %String [ SqlFieldName = MED_BEG_DAT ];

Property DateEnd As %String [ SqlFieldName = MED_END_DAT ];

Property Code As %String [ SqlFieldName = MED_COD ];

Property Dsc As %String(MAXLEN = 200) [ SqlFieldName = MED_DSC ];

Property Duration As %String [ SqlFieldName = MED_DUR_VAL ];

Property PresentCode As %String [ SqlFieldName = MED_APR_COD ];

Property PresentDsc As %String [ SqlFieldName = MED_APR_DSC ];

Property FreqCode As %String [ SqlFieldName = MED_FRQ_COD ];

Property FreqDsc As %String [ SqlFieldName = MED_FRQ_DSC ];

Property CatCode As %String [ SqlFieldName = MED_CAT_COD ];

Property CatDsc As %String [ SqlFieldName = MED_CAT_DSC ];

Property Dose As %String [ SqlFieldName = MED_DOS_VAL ];

Property UnitCode As %String [ SqlFieldName = MED_UNI_COD ];

Property UnitDsc As %String [ SqlFieldName = MED_UNI_DSC ];

Property RouteCode As %String [ SqlFieldName = MED_ROU_COD ];

Property RouteDsc As %String [ SqlFieldName = MED_ROU_DSC ];

Property Status As %String [ SqlFieldName = MED_STA ];

Property CliCod As %String [ SqlFieldName = MED_CLI_COD ];

Property CliConsCod As %String [ SqlFieldName = MED_CLI_CONS_COD ];

Property CliConsDsc As %String(MAXLEN = 200) [ SqlFieldName = MED_CLI_CONS_DSC ];

Property CliNam As %String(MAXLEN = 200) [ SqlFieldName = MED_CLI_NAM ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-ICESP/tmp/ICESP-MEDICATION.csv", patid = "815", print = 1) As %Status
{
    Set tSC = $$$OK
    Set tFileStream=##class(%Stream.FileCharacter).%New()
    Set tSC=tFileStream.LinkToFile(path)
    If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    Set ln=0
    Set (line,header)=""
    Do tFileStream.Rewind()
    While ('tFileStream.AtEnd) {
        Set line=tFileStream.ReadLine()
        Set ln=ln+1
        If (ln=1) {
            Set header=line
            Continue
        } 
        Set rec=##class(SQLUSER.Medication).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If +$TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=1) rec.PK = cont
            Set:(i=1) rec.PrescriptionId = cont
            Set:(i=14) rec.EncounterId = cont
            Set:(i=9) rec.Date = cont
            Set:(i=13) rec.Code = cont
            Set:(i=2) rec.Dsc = cont
            Set:(i=3) rec.Dose = $Replace($Replace(cont,".",""),",",".")
            Set:(i=4) rec.UnitCode = cont
            Set:(i=5) rec.RouteCode = cont
            Set:(i=6) rec.RouteDsc = cont
            Set:(i=7) rec.FreqCode = cont
            Set:(i=8) rec.FreqDsc = cont
            Set:(i=16) rec.CliCod = cont
            Set:(i=16) rec.CliConsCod = cont
            Set:(i=17) rec.CliConsDsc = "CRM"
            Set:(i=17) rec.CliNam = cont
        }
        Set rec.PatientId = patid
        If rec.Code'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="MedicationDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>PK</Value>
</Value>
<Value name="3">
<Value>EncounterId</Value>
</Value>
<Value name="4">
<Value>PatientId</Value>
</Value>
<Value name="5">
<Value>PrescriptionId</Value>
</Value>
<Value name="6">
<Value>Date</Value>
</Value>
<Value name="7">
<Value>DateStart</Value>
</Value>
<Value name="8">
<Value>DateEnd</Value>
</Value>
<Value name="9">
<Value>Code</Value>
</Value>
<Value name="10">
<Value>Dsc</Value>
</Value>
<Value name="11">
<Value>Duration</Value>
</Value>
<Value name="12">
<Value>PresentCode</Value>
</Value>
<Value name="13">
<Value>PresentDsc</Value>
</Value>
<Value name="14">
<Value>FreqCode</Value>
</Value>
<Value name="15">
<Value>FreqDsc</Value>
</Value>
<Value name="16">
<Value>CatCode</Value>
</Value>
<Value name="17">
<Value>CatDsc</Value>
</Value>
<Value name="18">
<Value>Dose</Value>
</Value>
<Value name="19">
<Value>UnitCode</Value>
</Value>
<Value name="20">
<Value>UnitDsc</Value>
</Value>
<Value name="21">
<Value>RouteCode</Value>
</Value>
<Value name="22">
<Value>RouteDsc</Value>
</Value>
<Value name="23">
<Value>Status</Value>
</Value>
<Value name="24">
<Value>CliCod</Value>
</Value>
<Value name="25">
<Value>CliConsCod</Value>
</Value>
<Value name="26">
<Value>CliConsDsc</Value>
</Value>
<Value name="27">
<Value>CliNam</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.MedicationD</DataLocation>
<DefaultData>MedicationDefaultData</DefaultData>
<IdLocation>^SQLUSER.MedicationD</IdLocation>
<IndexLocation>^SQLUSER.MedicationI</IndexLocation>
<StreamLocation>^SQLUSER.MedicationS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
