Class SQLUSER.Procedure Extends %Persistent [ SqlTableName = HS_Procedure ]
{

Property PK As %String(MAXLEN = 200) [ SqlFieldName = PRC_PK ];

Property EncounterId As %String [ SqlFieldName = PRC_ENC_FK ];

Property PatientId As %String [ SqlFieldName = PRC_PAT_FK ];

Property Code As %String [ SqlFieldName = PRC_COD ];

Property Dsc As %String(MAXLEN = 200) [ SqlFieldName = PRC_DSC ];

Property Date As %String [ SqlFieldName = PRC_DAT ];

Property CliCod As %String [ SqlFieldName = PRC_CLI_COD ];

Property CliConsCod As %String [ SqlFieldName = PRC_CLI_CONS_COD ];

Property CliConsDsc As %String(MAXLEN = 200) [ SqlFieldName = PRC_CLI_CONS_DSC ];

Property CliNam As %String(MAXLEN = 200) [ SqlFieldName = PRC_CLI_NAM ];

Property TypCode As %String [ SqlFieldName = PRC_TYP_COD ];

Property TypDsc As %String(MAXLEN = 200) [ SqlFieldName = PRC_TYP_DSC ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-ICESP/tmp/ICESP-PROCEDURE.csv", patid = "815", print = 1) As %Status
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
        Set rec=##class(SQLUSER.Procedure).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If +$TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=3) rec.EncounterId = cont
            Set:(i=3) rec.PK = cont
            Set:(i=4) rec.Date = cont
            Set:(i=6) rec.Code = cont
            Set:(i=8) rec.Dsc = cont
            Set:(i=9) rec.TypCode = cont
            Set:(i=9) rec.TypDsc = cont
            Set:(i=10) rec.CliCod = cont
            Set:(i=10) rec.CliConsCod = cont
            Set:(i=10) rec.CliConsDsc = "CRM"
            Set:(i=11) rec.CliNam = cont
        }
        Set rec.PatientId = patid
        If rec.Code'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="ProcedureDefaultData">
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
<Value>Code</Value>
</Value>
<Value name="6">
<Value>Dsc</Value>
</Value>
<Value name="7">
<Value>Date</Value>
</Value>
<Value name="8">
<Value>CliCod</Value>
</Value>
<Value name="9">
<Value>CliConsCod</Value>
</Value>
<Value name="10">
<Value>CliConsDsc</Value>
</Value>
<Value name="11">
<Value>CliNam</Value>
</Value>
<Value name="12">
<Value>TypCode</Value>
</Value>
<Value name="13">
<Value>TypDsc</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.ProcedureD</DataLocation>
<DefaultData>ProcedureDefaultData</DefaultData>
<IdLocation>^SQLUSER.ProcedureD</IdLocation>
<IndexLocation>^SQLUSER.ProcedureI</IndexLocation>
<StreamLocation>^SQLUSER.ProcedureS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
