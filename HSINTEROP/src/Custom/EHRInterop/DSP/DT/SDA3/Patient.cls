Class Custom.EHRInterop.DSP.DT.SDA3.Patient Extends (Ens.DataTransform, Custom.EHRInterop.Core.Util.SDA3)
{

ClassMethod Transform(source As %ResultSet, Output target As HS.SDA3.Patient, pCodingStandard As %String) As %Status
{
	Set tSC = $$$OK
	
    Set target = ##class(HS.SDA3.Patient).%New()
    
    Set tSDA3Name = ""
    Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.Name).Transform(source, .tSDA3Name, "PAT_NAM")
    $$$ThrowOnError(tSC)

    If ($IsObject(tSDA3Name))
    {
        Set target.Name = tSDA3Name
    }

    Set target.MothersMaidenName = $Extract($ZSTRIP(source.Get("PAT_MOT"),"*C"),1,50)
    
    Set tSDA3Alias = ""
    Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.Name).Transform(source, .tSDA3Alias, "PAT_ALI")
    $$$ThrowOnError(tSC)
    
    If ($IsObject(tSDA3Alias))
    {
        Set tSC = target.Aliases.Insert(tSDA3Alias)
        $$$ThrowOnError(tSC)
    }
    
    //Set target.PrimaryLanguage = ..CodeTable("Language","PT","Portuguese")
    
    Set target.Religion = ..CodeTable("Religion", source.Get("PAT_REL_DSC"), $ZSTRIP(source.Get("PAT_REL_DSC"), "*C"))
    Set target.MaritalStatus = ..CodeTable("MaritalStatus", $ZSTRIP(source.Get("PAT_CIV_DSC"), "*C"), $ZSTRIP(source.Get("PAT_CIV_DSC"), "*C"))
    Set target.Gender = ..CodeTable("Gender", $ZSTRIP(source.Get("PAT_GEN"), "*C"), $ZSTRIP(source.Get("PAT_GEN"), "*C"))
    Set target.Race = ..CodeTable("Race", $ZSTRIP(source.Get("PAT_RAC_DSC"), "*C"), $ZSTRIP(source.Get("PAT_RAC_DSC"), "*C"))
    Set target.Citizenship = ..CodeTable("Citizenship", $ZSTRIP(source.Get("PAT_NTL_DSC"), "*C"), $ZSTRIP(source.Get("PAT_NTL_DSC"), "*C"))
    
    
    If (source.Get("PAT_BIR_DAT")'="")
    {
        Set target.BirthTime = source.Get("PAT_BIR_DAT")_"T00:00:00"
    }
    
    If (source.Get("PAT_FAT")'="")
    {
        Set tSDA3SupportContact = ""
        Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.Contact).Transform(source,.tSDA3SupportContact,"PAT_FAT","Father")
        $$$ThrowOnError(tSC)
        
        If ($IsObject(tSDA3SupportContact))
        {
            Set tSC = target.SupportContacts.Insert(tSDA3SupportContact)
            $$$ThrowOnError(tSC)
        }
    }
    
    If (source.Get("PAT_CPL")'="")
    {
        Set tSDA3SupportContact = ""
        Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.Contact).Transform(source,.tSDA3SupportContact,"PAT_CPL","Spouse")
        $$$ThrowOnError(tSC)
        
        If ($IsObject(tSDA3SupportContact))
        {
            Set tSC = target.SupportContacts.Insert(tSDA3SupportContact)
            $$$ThrowOnError(tSC)
        }
    }

    If (source.Get("PAT_DTH_DAT")'="")
    {
        Set target.DeathTime = source.Get("PAT_DTH_DAT")_"T00:00:00"
        Set target.IsDead = 1
        
        If (source.Get("PAT_DTH_LOC") '= "")
        {
            Set target.DeathLocation = $ZSTRIP(source.Get("PAT_DTH_LOC"), "*C")
        }
    }
    
    If (source.Get("PAT_SSN") '= "")
    {
        Set tSDA3PatientNumber = ""
        Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.PatientNumber).Transform(source, .tSDA3PatientNumber, "PAT_SSN", "SSN", "SSN", "SSN")
        $$$ThrowOnError(tSC)

        If ($IsObject(tSDA3PatientNumber))
        {
            Set tSC = target.PatientNumbers.Insert(tSDA3PatientNumber)
            $$$ThrowOnError(tSC)
        }
    }

    If (source.Get("PAT_DL") '= "") 
    {
        Set tSDA3PatientNumber = ""
        Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.PatientNumber).Transform(source, .tSDA3PatientNumber, "PAT_DL", "DL", "DL", "DL")
        $$$ThrowOnError(tSC)

        If ($IsObject(tSDA3PatientNumber))
        {
            Set tSC = target.PatientNumbers.Insert(tSDA3PatientNumber)
            $$$ThrowOnError(tSC)
        }
    }

    /*If ($ZSTRIP(source.Get("CNS"),"*C") '= "") 
    {
        Set tSDA3PatientNumber = ""
        Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.PatientNumber).Transform(source, .tSDA3PatientNumber,"CNS","CNS","MS","Ministério da Saúde")
        $$$ThrowOnError(tSC)

        If ($IsObject(tSDA3PatientNumber))
        {
            Set tSC = target.PatientNumbers.Insert(tSDA3PatientNumber)
             $$$ThrowOnError(tSC)
        }
    }*/
    
    If (source.Get("PAT_PK") '= "") 
    {
        Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.PatientNumber).Transform(source, .tSDA3PatientNumber, "PAT_PK", "MRN", pCodingStandard, pCodingStandard)
        $$$ThrowOnError(tSC)

        If ($IsObject(tSDA3PatientNumber))
        {
            Set tSC = target.PatientNumbers.Insert(tSDA3PatientNumber)
            $$$ThrowOnError(tSC)
        }
}

    Set tSDA3Address = ""
    Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.Address).Transform(source, .tSDA3Address)
    $$$ThrowOnError(tSC)

    If ($IsObject(tSDA3Address))
    {
        Set tSC = target.Addresses.Insert(tSDA3Address)
        $$$ThrowOnError(tSC)
    }
    
    Set tSDA3ContactInfo = ""
    Set tSC = ##Class(Custom.EHRInterop.Core.DT.SDA3.ContactInformation).Transform(source, .tSDA3ContactInfo)
    $$$ThrowOnError(tSC)

    If ($IsObject(tSDA3ContactInfo))
    {
        Set target.ContactInfo = tSDA3ContactInfo
    }
	
	Quit tSC
}

}
