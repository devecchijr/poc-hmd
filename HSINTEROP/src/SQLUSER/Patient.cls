Class SQLUSER.Patient Extends %Persistent [ SqlTableName = HS_Patient ]
{

Property MRN As %String [ SqlFieldName = PAT_PK ];

Property Name As %String(MAXLEN = 200) [ SqlFieldName = PAT_NAM ];

Property MotherName As %String(MAXLEN = 200) [ SqlFieldName = PAT_MOT ];

Property AliasName As %String(MAXLEN = 200) [ SqlFieldName = PAT_ALI ];

Property RelCod As %String [ SqlFieldName = PAT_REL_COD ];

Property RelDsc As %String(MAXLEN = 200) [ SqlFieldName = PAT_REL_DSC ];

Property Gender As %String [ SqlFieldName = PAT_GEN ];

Property CivCod As %String [ SqlFieldName = PAT_CIV_COD ];

Property CivDsc As %String(MAXLEN = 200) [ SqlFieldName = PAT_CIV_DSC ];

Property RacCod As %String [ SqlFieldName = PAT_RAC_COD ];

Property RacDsc As %String(MAXLEN = 200) [ SqlFieldName = PAT_RAC_DSC ];

Property FatherName As %String(MAXLEN = 200) [ SqlFieldName = PAT_FAT ];

Property SpouseName As %String(MAXLEN = 200) [ SqlFieldName = PAT_CPL ];

Property BirthDate As %String [ SqlFieldName = PAT_BIR_DAT ];

Property NtlCod As %String [ SqlFieldName = PAT_NTL_COD ];

Property NtlDsc As %String(MAXLEN = 200) [ SqlFieldName = PAT_NTL_DSC ];

Property NatCod As %String [ SqlFieldName = PAT_NAT_COD ];

Property NatDsc As %String(MAXLEN = 200) [ SqlFieldName = PAT_NAT_DSC ];

Property NID As %String [ SqlFieldName = PAT_NID ];

Property SSN As %String [ SqlFieldName = PAT_SSN ];

Property DL As %String [ SqlFieldName = PAT_DL ];

Property DLUF As %String [ SqlFieldName = PAT_DL_UF ];

Property AdrStreet As %String(MAXLEN = 200) [ SqlFieldName = PAT_ADR_STR ];

Property AdrNumber As %String(MAXLEN = 50) [ SqlFieldName = PAT_ADR_NUM ];

Property AdrComp As %String(MAXLEN = 200) [ SqlFieldName = PAT_ADR_CPL ];

Property AdrCity As %String(MAXLEN = 200) [ SqlFieldName = PAT_ADR_CIT ];

Property AdrProv As %String(MAXLEN = 200) [ SqlFieldName = PAT_ADR_PRV ];

Property AdrCountry As %String(MAXLEN = 200) [ SqlFieldName = PAT_ADR_CTR ];

Property AdrUFCod As %String [ SqlFieldName = PAT_ADR_UF_COD ];

Property AdrUFDsc As %String(MAXLEN = 200) [ SqlFieldName = PAT_ADR_UF_DSC ];

Property AdrZip As %String [ SqlFieldName = PAT_ADR_ZIP ];

Property TelRes As %String [ SqlFieldName = PAT_TEL_RES ];

Property TelCom As %String [ SqlFieldName = PAT_TEL_COM ];

Property TelMob As %String [ SqlFieldName = PAT_TEL_MOB ];

Property Email As %String(MAXLEN = 200) [ SqlFieldName = PAT_EMA ];

Property DeathTime As %String [ SqlFieldName = PAT_DTH_DAT ];

Property DeathLocation As %String [ SqlFieldName = PAT_DTH_LOC ];

ClassMethod LoadData(path As %String = "/Users/claudiodevecchi/Documents/iris-workspace/LOCAL-UCR2022-ICESP/tmp/ICESP-PATIENT.csv", print = 1) As %Status
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
        Set rec=##class(SQLUSER.Patient).%New()
        For i=1:1:$l(line,";") {
            Set cont=$p(line,";",i)
            If $e(cont,3,3)="/",$e(cont,6,6)="/" Set cont = $ZDT($ZDTH(cont,4),3)
            If +$TR(cont,",.",".")'="" Set cont=$TR(cont,",.",".")
            Continue:((cont="")||(cont="[NULL]"))
            Write:print=1 "loading ...",i," ",$p(header,";",i),"=>",cont,!
            Set:(i=1) rec.MRN = cont
            Set:(i=2) rec.Name = cont
            Set:(i=3) rec.MotherName = cont
            Set:(i=5) rec.AliasName = cont
            Set:(i=6) rec.SSN = cont
            Set:(i=7) rec.RelCod = cont
            Set:(i=8) rec.RelDsc = cont
            Set:(i=9) rec.CivCod = cont
            Set:(i=9) rec.CivDsc = cont
            Set:(i=10) rec.Gender = cont
            Set:(i=11) rec.CivCod = cont
            Set:(i=11) rec.CivDsc = cont
            Set:(i=12) rec.FatherName = cont
            Set:(i=14) rec.BirthDate = $p(cont," ",1)
            Set:(i=15) rec.NatCod = cont
            Set:(i=16) rec.NatDsc = cont
            Set:(i=17) rec.NtlCod = cont
            Set:(i=18) rec.NtlDsc = cont
            Set:(i=21) rec.NID = cont
            Set:(i=22) rec.SSN = cont
            Set:(i=23) rec.DL = cont
            Set:(i=19) rec.DLUF = cont
            Set:(i=27) rec.AdrStreet = cont
            Set:(i=28) rec.AdrNumber = cont
            Set:(i=29) rec.AdrProv = cont
            Set:(i=31) rec.AdrCity = cont
            Set:(i=32) rec.AdrUFCod = cont
            Set:(i=33) rec.AdrUFDsc = cont
            Set:(i=34) rec.AdrZip = cont
            Set:(i=35) rec.TelRes = cont
            Set:(i=36) rec.TelCom = cont
            Set:(i=37) rec.TelMob = cont
            Set:(i=38) rec.Email = cont
            Set:(i=40) rec.DeathTime = cont
            Set:(i=41) rec.DeathLocation = cont
        }
        Set tSC=rec.%Save()
        If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC)}
    }
    Quit tSC
}

Storage Default
{
<Data name="PatientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>MRN</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>MotherName</Value>
</Value>
<Value name="5">
<Value>AliasName</Value>
</Value>
<Value name="6">
<Value>RelCod</Value>
</Value>
<Value name="7">
<Value>RelDsc</Value>
</Value>
<Value name="8">
<Value>Gender</Value>
</Value>
<Value name="9">
<Value>CivCod</Value>
</Value>
<Value name="10">
<Value>CivDsc</Value>
</Value>
<Value name="11">
<Value>RacCod</Value>
</Value>
<Value name="12">
<Value>RacDsc</Value>
</Value>
<Value name="13">
<Value>FatherName</Value>
</Value>
<Value name="14">
<Value>SpouseName</Value>
</Value>
<Value name="15">
<Value>BirthDate</Value>
</Value>
<Value name="16">
<Value>NtlCod</Value>
</Value>
<Value name="17">
<Value>NtlDsc</Value>
</Value>
<Value name="18">
<Value>NID</Value>
</Value>
<Value name="19">
<Value>SSN</Value>
</Value>
<Value name="20">
<Value>DL</Value>
</Value>
<Value name="21">
<Value>DLUF</Value>
</Value>
<Value name="22">
<Value>AdrStreet</Value>
</Value>
<Value name="23">
<Value>AdrNumber</Value>
</Value>
<Value name="24">
<Value>AdrComp</Value>
</Value>
<Value name="25">
<Value>AdrCity</Value>
</Value>
<Value name="26">
<Value>AdrProv</Value>
</Value>
<Value name="27">
<Value>AdrCountry</Value>
</Value>
<Value name="28">
<Value>AdrUFCod</Value>
</Value>
<Value name="29">
<Value>AdrUFDsc</Value>
</Value>
<Value name="30">
<Value>AdrZip</Value>
</Value>
<Value name="31">
<Value>TelRes</Value>
</Value>
<Value name="32">
<Value>TelCom</Value>
</Value>
<Value name="33">
<Value>TelMob</Value>
</Value>
<Value name="34">
<Value>Email</Value>
</Value>
<Value name="35">
<Value>DeathTime</Value>
</Value>
<Value name="36">
<Value>DeathLocation</Value>
</Value>
<Value name="37">
<Value>NatCod</Value>
</Value>
<Value name="38">
<Value>NatDsc</Value>
</Value>
</Data>
<DataLocation>^SQLUSER.PatientD</DataLocation>
<DefaultData>PatientDefaultData</DefaultData>
<IdLocation>^SQLUSER.PatientD</IdLocation>
<IndexLocation>^SQLUSER.PatientI</IndexLocation>
<StreamLocation>^SQLUSER.PatientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
