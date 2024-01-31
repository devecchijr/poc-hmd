Class SQLUSER.Allergy Extends %Persistent [ SqlTableName = HS_Allergy ]
{

Property PK As %String(MAXLEN = 200) [ SqlFieldName = ALG_PK ];

Property EncounterId As %String [ SqlFieldName = ALG_ENC_FK ];

Property PatientId As %String [ SqlFieldName = ALG_PAT_FK ];

Property Code As %String [ SqlFieldName = ALG_COD ];

Property Dsc As %String(MAXLEN = 200) [ SqlFieldName = ALG_DSC ];

Property TypeCode As %String [ SqlFieldName = ALG_TYP_COD ];

Property TypeDsc As %String [ SqlFieldName = ALG_TYP_DSC ];

Property ReactCode As %String [ SqlFieldName = ALG_REA_COD ];

Property ReactDsc As %String [ SqlFieldName = ALG_REA_DSC ];

Property SevCode As %String [ SqlFieldName = ALG_SEV_COD ];

Property SevDsc As %String [ SqlFieldName = ALG_SEV_DSC ];

Property CertCode As %String [ SqlFieldName = ALG_CER_COD ];

Property CertDsc As %String [ SqlFieldName = ALG_CER_DSC ];

Property Date As %String [ SqlFieldName = ALG_DAT ];

Property StartDate As %String [ SqlFieldName = ALG_BEG_DAT ];

Property EndDate As %String [ SqlFieldName = ALG_END_DAT ];

Property LastManifDate As %String [ SqlFieldName = ALG_LST_DAT ];

Property InactDate As %String [ SqlFieldName = ALG_INA_DAT ];

Property CliCod As %String [ SqlFieldName = ALG_CLI_COD ];

Property CliConsCod As %String [ SqlFieldName = ALG_CLI_CONS_COD ];

Property CliConsDsc As %String(MAXLEN = 200) [ SqlFieldName = ALG_CLI_CONS_DSC ];

Property CliNam As %String(MAXLEN = 200) [ SqlFieldName = ALG_CLI_NAM ];

Property Text As %String(MAXLEN = 300) [ SqlFieldName = ALG_TXT ];

Property Observation As %String(MAXLEN = 300) [ SqlFieldName = ALG_OBS ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-ICESP/tmp/ICESP-ALLERGY.csv", patid = "815", print = 1) As %Status
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
        Set rec=##class(SQLUSER.Allergy).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If +$TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=10) rec.Date = cont
            Set:(i=10) rec.StartDate = cont
            Set:(i=7) rec.TypeCode = cont
            Set:(i=8) rec.TypeDsc = cont
            Set:(i=6) rec.Dsc = cont
            Set:(i=5) rec.Code = cont
            Set:(i=11) rec.CliCod = cont
            Set:(i=11) rec.CliConsCod = cont
            Set:(i=11) rec.CliConsDsc = "CRM"
            Set:(i=12) rec.CliNam = cont
        }
        Set rec.PatientId = patid
        Set rec.PK = rec.PatientId_rec.TypeCode_rec.Code_rec.Date
        If rec.Code'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="AllergyDefaultData">
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
<Value>TypeCode</Value>
</Value>
<Value name="8">
<Value>TypeDsc</Value>
</Value>
<Value name="9">
<Value>ReactCode</Value>
</Value>
<Value name="10">
<Value>ReactDsc</Value>
</Value>
<Value name="11">
<Value>SevCode</Value>
</Value>
<Value name="12">
<Value>SevDsc</Value>
</Value>
<Value name="13">
<Value>CertCode</Value>
</Value>
<Value name="14">
<Value>CertDsc</Value>
</Value>
<Value name="15">
<Value>Date</Value>
</Value>
<Value name="16">
<Value>StartDate</Value>
</Value>
<Value name="17">
<Value>EndDate</Value>
</Value>
<Value name="18">
<Value>LastManifDate</Value>
</Value>
<Value name="19">
<Value>InactDate</Value>
</Value>
<Value name="20">
<Value>CliCod</Value>
</Value>
<Value name="21">
<Value>CliConsCod</Value>
</Value>
<Value name="22">
<Value>CliConsDsc</Value>
</Value>
<Value name="23">
<Value>CliNam</Value>
</Value>
<Value name="24">
<Value>Text</Value>
</Value>
<Value name="25">
<Value>Observation</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.AllergyD</DataLocation>
<DefaultData>AllergyDefaultData</DefaultData>
<IdLocation>^SQLUSER.AllergyD</IdLocation>
<IndexLocation>^SQLUSER.AllergyI</IndexLocation>
<StreamLocation>^SQLUSER.AllergyS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
