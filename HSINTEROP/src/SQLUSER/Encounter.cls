Class SQLUSER.Encounter Extends %Persistent [ SqlTableName = HS_Encounter ]
{

Property EncounterId As %String [ SqlFieldName = enc_pk ];

Property PatientId As %String [ SqlFieldName = enc_pat_fk ];

Property AdmDate As %String [ SqlFieldName = enc_adm_dat ];

Property Type As %String [ SqlFieldName = enc_typ ];

Property FacCod As %String [ SqlFieldName = enc_fac_cod ];

Property FacDsc As %String(MAXLEN = 200) [ SqlFieldName = enc_fac_dsc ];

Property InsCod As %String [ SqlFieldName = enc_ins_cod ];

Property InsDsc As %String(MAXLEN = 200) [ SqlFieldName = enc_ins_dsc ];

Property SpeCod As %String [ SqlFieldName = enc_spe_cod ];

Property SpeDsc As %String(MAXLEN = 200) [ SqlFieldName = enc_spe_dsc ];

Property DisDate As %String [ SqlFieldName = enc_dis_dat ];

Property Ward As %String(MAXLEN = 200) [ SqlFieldName = enc_wrd ];

Property Bed As %String(MAXLEN = 200) [ SqlFieldName = enc_bed ];

Property CliCod As %String [ SqlFieldName = enc_cli_cod ];

Property CliConsCod As %String [ SqlFieldName = enc_cli_cons_cod ];

Property CliConsDsc As %String(MAXLEN = 200) [ SqlFieldName = enc_cli_cons_dsc ];

Property CliNam As %String(MAXLEN = 200) [ SqlFieldName = enc_cli_nam ];

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
        Set rec=##class(SQLUSER.Encounter).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If +$TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set rec.PatientId = patid
            Set:(i=1) rec.EncounterId = cont
            Set:(i=12) rec.AdmDate = cont
            Set:(i=2) rec.Type= cont
            Set:(i=6) rec.FacCod = cont
            Set:(i=7) rec.FacDsc = cont
            Set:(i=10) rec.SpeCod = cont
            Set:(i=11) rec.SpeDsc = cont
            Set:(i=13) rec.DisDate = cont
            Set:(i=14) rec.Ward = cont
            Set:(i=15) rec.Bed = cont
            Set:(i=8) rec.InsCod = cont
            Set:(i=9) rec.InsDsc = cont
            Set:(i=3) rec.CliCod = cont
            Set:(i=3) rec.CliConsCod = cont
            Set:(i=3) rec.CliConsDsc = "CRM"
            Set:(i=4) rec.CliNam = cont
            If rec.Type="A" Set rec.Type="O"
        }
        If rec.EncounterId'="" Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="EncounterDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>EncounterId</Value>
</Value>
<Value name="3">
<Value>PatientId</Value>
</Value>
<Value name="4">
<Value>AdmDate</Value>
</Value>
<Value name="5">
<Value>Type</Value>
</Value>
<Value name="6">
<Value>FacCod</Value>
</Value>
<Value name="7">
<Value>FacDsc</Value>
</Value>
<Value name="8">
<Value>InsCod</Value>
</Value>
<Value name="9">
<Value>InsDsc</Value>
</Value>
<Value name="10">
<Value>SpeCod</Value>
</Value>
<Value name="11">
<Value>SpeDsc</Value>
</Value>
<Value name="12">
<Value>DisDate</Value>
</Value>
<Value name="13">
<Value>Ward</Value>
</Value>
<Value name="14">
<Value>Bed</Value>
</Value>
<Value name="15">
<Value>CliCod</Value>
</Value>
<Value name="16">
<Value>CliConsCod</Value>
</Value>
<Value name="17">
<Value>CliConsDsc</Value>
</Value>
<Value name="18">
<Value>CliNam</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.EncounterD</DataLocation>
<DefaultData>EncounterDefaultData</DefaultData>
<IdLocation>^SQLUSER.EncounterD</IdLocation>
<IndexLocation>^SQLUSER.EncounterI</IndexLocation>
<StreamLocation>^SQLUSER.EncounterS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
