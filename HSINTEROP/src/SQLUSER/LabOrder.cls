Class SQLUSER.LabOrder Extends %Persistent [ SqlTableName = HS_LAB_ORDER ]
{

Property PK As %String(MAXLEN = 200) [ SqlFieldName = LAB_PK ];

Property EncounterId As %String [ SqlFieldName = LAB_ENC_FK ];

Property PatientId As %String [ SqlFieldName = LAB_PAT_FK ];

Property PlacerId As %String [ SqlFieldName = LAB_PID ];

Property FillerId As %String [ SqlFieldName = LAB_FID ];

Property OrdDate As %String [ SqlFieldName = LAB_ORD_DAT ];

Property Code As %String [ SqlFieldName = LAB_COD ];

Property Dsc As %String(MAXLEN = 200) [ SqlFieldName = LAB_DSC ];

Property Status As %String [ SqlFieldName = LAB_STA ];

Property CliCod As %String [ SqlFieldName = LAB_CLI_COD ];

Property CliConsCod As %String [ SqlFieldName = LAB_CLI_CONS_COD ];

Property CliConsDsc As %String(MAXLEN = 200) [ SqlFieldName = LAB_CLI_CONS_DSC ];

Property CliNam As %String(MAXLEN = 200) [ SqlFieldName = LAB_CLI_NAM ];

Property ResDate As %String [ SqlFieldName = LAB_RES_DAT ];

Property ResDocName As %String [ SqlFieldName = LAB_RES_NAM ];

Property ResBody As %String [ SqlFieldName = LAB_RES_BOD ];

Property ResBodyTyp As %String [ SqlFieldName = LAB_RES_BDT ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-HC/tmp/revisao_viewsHC/MV-LABORDER.csv", patid = "6674062", print = 1) As %Status
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
        Set rec=##class(SQLUSER.LabOrder).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If $TR(cont,",.",".")=+$TR(cont,",.",".") Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=26) rec.PK = cont
            Set:(i=21) rec.EncounterId = cont
            Set:(i=22) rec.ResDate = cont
            Set:(i=25) rec.OrdDate = cont
            Set:(i=23) rec.PlacerId = cont
            Set:(i=23) rec.FillerId = cont
            Set:(i=17) rec.Code = cont
            Set:(i=18) rec.Dsc = cont
            Set:(i=12) rec.CliCod = cont
            Set:(i=12) rec.CliConsCod = cont
            Set:(i=11) rec.CliConsDsc = cont
            Set:(i=13) rec.CliNam = cont
            Set:(i=21) rec.Status = cont
        }
        Set rec.PatientId = patid
        Set rec.PlacerId = rec.PlacerId_rec.PK
        Set rec.FillerId = rec.FillerId_rec.PK
        If rec.Code'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="LabOrderDefaultData">
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
<DataLocation>^SQLUSER.LabOrderD</DataLocation>
<DefaultData>LabOrderDefaultData</DefaultData>
<IdLocation>^SQLUSER.LabOrderD</IdLocation>
<IndexLocation>^SQLUSER.LabOrderI</IndexLocation>
<StreamLocation>^SQLUSER.LabOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
