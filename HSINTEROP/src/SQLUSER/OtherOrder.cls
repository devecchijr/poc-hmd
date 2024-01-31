Class SQLUSER.OtherOrder Extends %Persistent [ SqlTableName = HS_OTHER_ORDER ]
{

Property PK As %String(MAXLEN = 200) [ SqlFieldName = OTH_PK ];

Property EncounterId As %String [ SqlFieldName = OTH_ENC_FK ];

Property PatientId As %String [ SqlFieldName = OTH_PAT_FK ];

Property PlacerId As %String [ SqlFieldName = OTH_PID ];

Property FillerId As %String [ SqlFieldName = OTH_FID ];

Property OrdDate As %String [ SqlFieldName = OTH_ORD_DAT ];

Property Code As %String [ SqlFieldName = OTH_COD ];

Property Dsc As %String(MAXLEN = 200) [ SqlFieldName = OTH_DSC ];

Property Status As %String [ SqlFieldName = OTH_STA ];

Property CliCod As %String [ SqlFieldName = OTH_CLI_COD ];

Property CliConsCod As %String [ SqlFieldName = OTH_CLI_CONS_COD ];

Property CliConsDsc As %String(MAXLEN = 200) [ SqlFieldName = OTH_CLI_CONS_DSC ];

Property CliNam As %String(MAXLEN = 200) [ SqlFieldName = OTH_CLI_NAM ];

Property ResDate As %String [ SqlFieldName = OTH_RES_DAT ];

Property ResDocName As %String [ SqlFieldName = OTH_RES_NAM ];

Property ResBody As %String(MAXLEN = "") [ SqlFieldName = OTH_RES_BOD ];

Property ResBodyTyp As %String [ SqlFieldName = OTH_RES_BDT ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-ICESP/tmp/ICESP-OTHERORDER.csv", patid = "815", print = 1) As %Status
{
    Set tSC = $$$OK
    Set tFileStream=##class(%Stream.FileCharacter).%New()
    Set tSC=tFileStream.LinkToFile(path)
    If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    Set ln=0
    Set (line,header,rec)=""
    Do tFileStream.Rewind()
    While ('tFileStream.AtEnd) {
        Set line=tFileStream.ReadLine()
        Set ln=ln+1
        If (ln=1) {
            Set header=line
            Continue
        } 
        Set rec=##class(SQLUSER.OtherOrder).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" {
                Set cont = $ZDT($ZDTH($E(cont,1,16),4),3)
            }
            If +$TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=1) rec.PK = cont
            Set:(i=2) rec.EncounterId = cont
            Set:(i=8) rec.ResDate = cont
            Set:(i=8) rec.OrdDate = cont
            Set:(i=1) rec.PlacerId = cont
            Set:(i=1) rec.FillerId = cont
            Set:(i=4) rec.Code = cont
            Set:(i=5) rec.Dsc = cont
            Set:(i=6) rec.CliCod = cont
            Set:(i=6) rec.CliConsCod = cont
            Set:(i=7) rec.CliConsDsc = cont
            Set:(i=7) rec.CliNam = cont
            Set:(i=1) rec.Status = "E"
            Set:(i=1) rec.ResDocName = cont
        }
        Set rec.PatientId = patid
        Set tSC=rec.%Save()
        If 'tSC {
            w tSC
            Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)
        }
    }
    Quit tSC
}

Storage Default
{
<Data name="OtherOrderDefaultData">
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
<Value>PlacerId</Value>
</Value>
<Value name="6">
<Value>FillerId</Value>
</Value>
<Value name="7">
<Value>OrdDate</Value>
</Value>
<Value name="8">
<Value>Code</Value>
</Value>
<Value name="9">
<Value>Dsc</Value>
</Value>
<Value name="10">
<Value>Status</Value>
</Value>
<Value name="11">
<Value>CliCod</Value>
</Value>
<Value name="12">
<Value>CliConsCod</Value>
</Value>
<Value name="13">
<Value>CliConsDsc</Value>
</Value>
<Value name="14">
<Value>CliNam</Value>
</Value>
<Value name="15">
<Value>ResDate</Value>
</Value>
<Value name="16">
<Value>ResDocName</Value>
</Value>
<Value name="17">
<Value>ResBody</Value>
</Value>
<Value name="18">
<Value>ResBodyTyp</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.OtherOrderD</DataLocation>
<DefaultData>OtherOrderDefaultData</DefaultData>
<IdLocation>^SQLUSER.OtherOrderD</IdLocation>
<IndexLocation>^SQLUSER.OtherOrderI</IndexLocation>
<StreamLocation>^SQLUSER.OtherOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
