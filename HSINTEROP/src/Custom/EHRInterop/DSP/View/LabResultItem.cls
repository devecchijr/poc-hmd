Class Custom.EHRInterop.DSP.View.LabResultItem Extends %RegisteredObject
{

ClassMethod GetLabResItemsByOrd() As %String
{
	Set tSQL =	"SELECT "_
					"LRI_PK, "_
					"LRI_ORD_FK, "_
					"LRI_COD, "_
					"LRI_DSC, "_
					"LRI_TYP, "_
					"LRI_VAL, "_
					"LRI_UNT, "_
					"LRI_REF, "_
					"LRI_DAT, "_
                    "LRI_ABN, "_
					"LRI_STA "_
				"FROM HS_LAB_RESULT_ITEM "_
				"WHERE LRI_ORD_FK = ? "
	Quit tSQL
}

}
