Class SQLUSER.Document Extends %Persistent [ SqlTableName = HS_DOCUMENT ]
{

Property PK As %String(MAXLEN = 200) [ SqlFieldName = DOC_PK ];

Property EncounterId As %String [ SqlFieldName = DOC_ENC_FK ];

Property PatientId As %String [ SqlFieldName = DOC_PAT_FK ];

Property Type As %String [ SqlFieldName = DOC_TYP_COD ];

Property Date As %String [ SqlFieldName = DOC_DAT ];

Property Name As %String(MAXLEN = 200) [ SqlFieldName = DOC_NAM ];

Property Status As %String [ SqlFieldName = DOC_STA ];

Property CliCod As %String [ SqlFieldName = DOC_CLI_COD ];

Property CliConsCod As %String [ SqlFieldName = DOC_CLI_CONS_COD ];

Property CliConsDsc As %String(MAXLEN = 200) [ SqlFieldName = DOC_CLI_CONS_DSC ];

Property CliNam As %String(MAXLEN = 200) [ SqlFieldName = DOC_CLI_NAM ];

Property Body As %String(MAXLEN = "") [ SqlFieldName = DOC_BOD ];

Property BodyTyp As %String [ SqlFieldName = DOC_BDT ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-ICESP/tmp/ICESP-DOCUMENT.csv", patid = "815", print = 1) As %Status
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
        Set rec=##class(SQLUSER.Document).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If +$TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=3) rec.PK = cont
            Set:(i=7) rec.EncounterId = cont
            Set:(i=8) rec.Date = cont
            Set:(i=3) rec.Name = cont
            Set:(i=2) rec.Type = cont
            Set:(i=9) rec.CliCod = cont
            Set:(i=12) rec.CliConsCod = cont
            Set:(i=11) rec.CliConsDsc = cont
            Set:(i=10) rec.CliNam = cont
            Set:(i=13) rec.Status = "A"
            Set:(i=13) rec.Body = $Replace(cont,"\n",$Char(10,13))
            Set:(i=13) rec.BodyTyp = "TXT"
        }
        Set rec.PatientId = patid
        If rec.Body'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="DocumentDefaultData">
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
<Value>Date</Value>
</Value>
<Value name="7">
<Value>Name</Value>
</Value>
<Value name="8">
<Value>Status</Value>
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
<Value>Body</Value>
</Value>
<Value name="14">
<Value>BodyTyp</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.DocumentD</DataLocation>
<DefaultData>DocumentDefaultData</DefaultData>
<IdLocation>^SQLUSER.DocumentD</IdLocation>
<IndexLocation>^SQLUSER.DocumentI</IndexLocation>
<StreamLocation>^SQLUSER.DocumentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
