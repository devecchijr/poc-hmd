Class SQLUSER.LabResultItem Extends %Persistent [ SqlTableName = HS_LAB_RESULT_ITEM ]
{

Property PK As %String(MAXLEN = 200) [ SqlFieldName = LRI_PK ];

Property OrderId As %String [ SqlFieldName = LRI_ORD_FK ];

Property Date As %String [ SqlFieldName = LRI_DAT ];

Property Code As %String [ SqlFieldName = LRI_COD ];

Property Dsc As %String(MAXLEN = 200) [ SqlFieldName = LRI_DSC ];

Property Type As %String [ SqlFieldName = LRI_TYP ];

Property Value As %String [ SqlFieldName = LRI_VAL ];

Property Unit As %String [ SqlFieldName = LRI_UNT ];

Property Abnormal As %String [ SqlFieldName = LRI_ABN ];

Property ValueRef As %String [ SqlFieldName = LRI_REF ];

Property Status As %String [ SqlFieldName = LRI_STA ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-HC/tmp/revisao_viewsHC/MV-LABRESULTITEM.csv", patid = "6674062", print = 1) As %Status
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
        Set rec=##class(SQLUSER.LabResultItem).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If +$TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=2) rec.OrderId = cont
            Set:(i=12) rec.Date = cont
            Set:(i=3) rec.Code = cont
            Set:(i=5) rec.Dsc = cont
            Set:(i=6) rec.Value = cont
            Set:(i=7) rec.Unit = cont
            Set:(i=13) rec.Abnormal = cont
            Set:(i=14) rec.Status = cont
            Set:(i=15) rec.Type = cont
            Set:(i=8) rec.ValueRef = cont
            Set:(i=9) rec.ValueRef = rec.ValueRef_"-"_cont
        }
        Set rec.PK = rec.OrderId_rec.Code
        Set:rec.Unit="" rec.Unit="UN"
        If rec.Code'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="LabResultItemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>PK</Value>
</Value>
<Value name="3">
<Value>OrderId</Value>
</Value>
<Value name="4">
<Value>Date</Value>
</Value>
<Value name="5">
<Value>Code</Value>
</Value>
<Value name="6">
<Value>Dsc</Value>
</Value>
<Value name="7">
<Value>Type</Value>
</Value>
<Value name="8">
<Value>Value</Value>
</Value>
<Value name="9">
<Value>Unit</Value>
</Value>
<Value name="10">
<Value>Abnormal</Value>
</Value>
<Value name="11">
<Value>ValueRef</Value>
</Value>
<Value name="12">
<Value>Status</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.LabResultItemD</DataLocation>
<DefaultData>LabResultItemDefaultData</DefaultData>
<IdLocation>^SQLUSER.LabResultItemD</IdLocation>
<IndexLocation>^SQLUSER.LabResultItemI</IndexLocation>
<StreamLocation>^SQLUSER.LabResultItemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
