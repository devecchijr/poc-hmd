Class SQLUSER.Diagnosis Extends %Persistent [ SqlTableName = HS_Diagnosis ]
{

Property PK As %String(MAXLEN = 200) [ SqlFieldName = DXG_PK ];

Property EncounterId As %String [ SqlFieldName = DXG_ENC_FK ];

Property PatientId As %String [ SqlFieldName = DXG_PAT_FK ];

Property Type As %String [ SqlFieldName = DXG_TYP ];

Property Code As %String [ SqlFieldName = DXG_COD ];

Property Dsc As %String(MAXLEN = 200) [ SqlFieldName = DXG_DSC ];

Property Date As %String [ SqlFieldName = DXG_DAT ];

Property CliCod As %String [ SqlFieldName = DXG_CLI_COD ];

Property CliConsCod As %String [ SqlFieldName = DXG_CLI_CONS_COD ];

Property CliConsDsc As %String(MAXLEN = 200) [ SqlFieldName = DXG_CLI_CONS_DSC ];

Property CliNam As %String(MAXLEN = 200) [ SqlFieldName = DXG_CLI_NAM ];

Property Status As %String [ SqlFieldName = DXG_STA ];

Property Priority As %String [ SqlFieldName = DXG_PRI ];

Property TypCode As %String [ SqlFieldName = DXG_TYP_COD ];

Property TypDsc As %String(MAXLEN = 200) [ SqlFieldName = DXG_TYP_DSC ];

Property IsAdm As %String [ SqlFieldName = DXG_ADM ];

Property IsDch As %String [ SqlFieldName = DXG_DCH ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-ICESP/tmp/ICESP-ENCOUNTER.csv", patid = "815", print = 1) As %Status
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
        Set rec=##class(SQLUSER.Diagnosis).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If $TR(cont,",.",".")=+$TR(cont,",.",".") Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=1) rec.EncounterId = cont
            Set:(i=12) rec.Date = cont
            Set:(i=1) rec.Type= "CID10"
            Set rec.IsAdm = "TRUE"
            If i=13,cont'="" {
                Set rec.Date = cont
                Set rec.IsDch = "TRUE"
                Set rec.IsAdm = "FALSE"
            }
            Set:(i=16) rec.Code = cont
            Set:(i=17) rec.Dsc = cont
            Set:(i=3) rec.CliCod = cont
            Set:(i=3) rec.CliConsCod = cont
            Set:(i=3) rec.CliConsDsc = "CRM"
            Set:(i=4) rec.CliNam = cont
        }
        Set rec.PatientId = patid
        Set rec.PK = rec.PatientId_rec.EncounterId_rec.Code_rec.Date
        If rec.Code'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

ClassMethod LoadData2(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-ICESP/tmp/ICESP-DIAGNOSIS.csv", patid = "815", print = 1) As %Status
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
        Set rec=##class(SQLUSER.Diagnosis).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If $TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=2) rec.EncounterId = cont
            Set:(i=3) rec.Date = cont
            Set:(i=4) rec.Type= "CID10"
            Set rec.IsAdm = "FALSE"
            Set:(i=4) rec.Code = cont
            Set:(i=5) rec.Dsc = cont
            Set:(i=8) rec.CliCod = cont
            Set:(i=8) rec.CliConsCod = cont
            Set:(i=8) rec.CliConsDsc = "CRM"
            Set:(i=6) rec.CliNam = cont
        }
        Set rec.PatientId = patid
        Set rec.PK = rec.PatientId_rec.EncounterId_rec.Code_rec.Date
        If rec.Code'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="DiagnosisDefaultData">
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
<Value>Type</Value>
</Value>
<Value name="6">
<Value>Code</Value>
</Value>
<Value name="7">
<Value>Dsc</Value>
</Value>
<Value name="8">
<Value>Date</Value>
</Value>
<Value name="9">
<Value>CliCod</Value>
</Value>
<Value name="10">
<Value>CliConsCod</Value>
</Value>
<Value name="11">
<Value>CliConsDsc</Value>
</Value>
<Value name="12">
<Value>CliNam</Value>
</Value>
<Value name="13">
<Value>Status</Value>
</Value>
<Value name="14">
<Value>TypCode</Value>
</Value>
<Value name="15">
<Value>TypDsc</Value>
</Value>
<Value name="16">
<Value>IsAdm</Value>
</Value>
<Value name="17">
<Value>IsDch</Value>
</Value>
<Value name="18">
<Value>Priority</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.DiagnosisD</DataLocation>
<DefaultData>DiagnosisDefaultData</DefaultData>
<IdLocation>^SQLUSER.DiagnosisD</IdLocation>
<IndexLocation>^SQLUSER.DiagnosisI</IndexLocation>
<StreamLocation>^SQLUSER.DiagnosisS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
