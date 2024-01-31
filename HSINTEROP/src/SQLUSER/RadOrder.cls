Class SQLUSER.RadOrder Extends %Persistent [ SqlTableName = HS_RAD_ORDER ]
{

Property PK As %String(MAXLEN = 200) [ SqlFieldName = RAD_PK ];

Property EncounterId As %String [ SqlFieldName = RAD_ENC_FK ];

Property PatientId As %String [ SqlFieldName = RAD_PAT_FK ];

Property PlacerId As %String [ SqlFieldName = RAD_PID ];

Property FillerId As %String [ SqlFieldName = RAD_FID ];

Property OrdDate As %String [ SqlFieldName = RAD_ORD_DAT ];

Property Code As %String [ SqlFieldName = RAD_COD ];

Property Dsc As %String(MAXLEN = 200) [ SqlFieldName = RAD_DSC ];

Property Status As %String [ SqlFieldName = RAD_STA ];

Property CliCod As %String [ SqlFieldName = RAD_CLI_COD ];

Property CliConsCod As %String [ SqlFieldName = RAD_CLI_CONS_COD ];

Property CliConsDsc As %String(MAXLEN = 200) [ SqlFieldName = RAD_CLI_CONS_DSC ];

Property CliNam As %String(MAXLEN = 200) [ SqlFieldName = RAD_CLI_NAM ];

Property ResDate As %String [ SqlFieldName = RAD_RES_DAT ];

Property ResDocName As %String [ SqlFieldName = RAD_RES_NAM ];

Property ResBody As %String(MAXLEN = "") [ SqlFieldName = RAD_RES_BOD ];

Property ResBodyTyp As %String [ SqlFieldName = RAD_RES_BDT ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-HC/tmp/revisao_viewsHC/MV-RADORDER.csv", patid = "6674062", print = 1) As %Status
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
        If $L(line,"^")=1 {
            Set rec.ResBody = rec.ResBody_line
        } ElseIf $L(line,"^")=2 {
            Set rec.ResBody = rec.ResBody_$P(line,"^",1)
            Set rec.ResBodyTyp = $P(line,"^",2)
            If rec.ResBodyTyp'="TXT" Set rec.ResBody =$SYSTEM.Encryption.Base64Decode(rec.ResBody)            
        } Else {
            Set rec=##class(SQLUSER.RadOrder).%New()
            For i=1:1:$l(line,"^") {
                Set cont=$p(line,"^",i)
                If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
                If +$TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
                Continue:((cont="")||(cont="[NULL]"))
                Write:print=1 "loading ...",i," ",$p(header,"^",i),"=>",cont,!
                Set:(i=21) rec.PK = cont
                Set:(i=16) rec.EncounterId = cont
                Set:(i=24) rec.ResDate = cont
                Set:(i=17) rec.OrdDate = cont
                Set:(i=18) rec.PlacerId = cont
                Set:(i=18) rec.FillerId = cont
                Set:(i=14) rec.Code = cont
                Set:(i=15) rec.Dsc = cont
                Set:(i=28) rec.CliCod = cont
                Set:(i=28) rec.CliConsCod = cont
                Set:(i=27) rec.CliConsDsc = cont
                Set:(i=29) rec.CliNam = cont
                Set:(i=19) rec.Status = cont
                Set:(i=30) rec.ResDocName = cont
                Set:(i=31) rec.ResBody = cont
                Set:(i=32) rec.ResBodyTyp = cont
            }
            If rec.ResBodyTyp="TXT" Set rec.ResBody = $Replace($Replace(rec.ResBody,"<br>",$Char(10,13)),"\n",$Char(10,13))
            Set rec.PatientId = patid
            Set rec.PlacerId = rec.PlacerId_rec.PK
            Set rec.FillerId = rec.FillerId_rec.PK
        }
        If rec.ResBody'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="RadOrderDefaultData">
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
<Value name="19">
<Value>ResBodyS</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.RadOrderD</DataLocation>
<DefaultData>RadOrderDefaultData</DefaultData>
<IdLocation>^SQLUSER.RadOrderD</IdLocation>
<IndexLocation>^SQLUSER.RadOrderI</IndexLocation>
<StreamLocation>^SQLUSER.RadOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
